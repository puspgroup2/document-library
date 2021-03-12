package servlets;

import java.io.IOException;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import handlers.PasswordHandler;

/**
 * Servlet implementation class PasswordChangerServlet.
 * Handles password changes from changepassword.jsp. Sends the changes to the database if it's approved.
 * Returns messages to changepassword.jsp upon success or failure.
 */
@WebServlet("/PasswordChangerServlet")
public class PasswordChangerServlet extends ServletBase {
	
	private final int PW_CHANGE_SUCCESSFUL_ = 2;
	private final int PW_CHANGE_FAILED_NETWORK_ERROR_ = 1;
	private final int PW_CHANGE_FAILED_IDENTICAL_PASSWORDS_ = 0;
	private final int PW_CHANGE_FAILED_FALSE_CURRENT_PASSWORD_ = 3;

	/**
	 * Handles POST request and serves changepassword.jsp, which allows users
	 * to change their password.
	 * The method checks and highlights if the password change was successful and if it fails why.
	 * 
	 * @throws ServletException if interference with normal operations occurs.
	 * @throws IOException if wrong input is received.
	 * @param request a HttpServletRequest which contains session data
	 * @param response a HttpServletResponse which is used to send redirects to the user
	 */
	protected void doPost(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		HttpSession session = request.getSession();
		String username = (String) session.getAttribute("username");
		String newPw = (String) request.getParameter("password");
		String oldPw = (String) request.getParameter("oldPassword");
		String salt = db.getSalt(username);
		if (db.checkLogin(username, PasswordHandler.hashPassword(oldPw, salt))) {
			if (!newPw.equals(oldPw)) {
				// sets the password.
				if (db.changePassword(username, PasswordHandler.hashPassword(newPw, salt))) {
					// change successful.
					session.setAttribute("passwordMessage", PW_CHANGE_SUCCESSFUL_);
				} else {
					// change not successful because of error in database.
					session.setAttribute("passwordMessage", PW_CHANGE_FAILED_NETWORK_ERROR_);
				}
			} else {
				// change not successful because of new password can not be the same as old
				// password.
				session.setAttribute("passwordMessage", PW_CHANGE_FAILED_IDENTICAL_PASSWORDS_);
			}
		} else {
			// change not successful because of current password was wrong.
			session.setAttribute("passwordMessage", PW_CHANGE_FAILED_FALSE_CURRENT_PASSWORD_);
		}
		response.sendRedirect("changepassword.jsp");
		
	}

}
