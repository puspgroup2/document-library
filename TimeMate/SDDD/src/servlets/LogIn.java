package servlets;

import java.io.IOException;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpSession;

import handlers.MailHandler;
import handlers.PasswordHandler;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

/**
 * Servlet implementation class LogIn
 * 
 * A log-in page.
 * 
 * The first thing that happens is that the user is logged out if he/she is
 * logged in. Then the user is asked for name and password. If the user is
 * logged in he/she is directed to the functionality page.
 */
@WebServlet("/LogIn")
public class LogIn extends ServletBase {
	private final int USER_LOGIN_FAILED_ = 0;
	private final int PW_CHANGE_FAILED_ = 1;
	private final int PW_CHANGE_SUCCESS_ = 2;

	/**
	 * Implementation of all input to the servlet. All post-messages are forwarded
	 * to this method.
	 * 
	 * First logout the user, then check if he/she has provided a userName and a
	 * password. If he/she has, it is checked with the database and if it matches
	 * then the session state is changed to login, the userName that is saved in the
	 * session is updated, and the user is relocated to the functionality page.
	 * 
	 * @throws ServletException if interference with normal operations occurs.
	 * @throws IOException if wrong input is received.
	 * @param request a HttpServletRequest which contains session data
	 * @param response a HttpServletResponse which is used to send redirects to the user
	 */
	protected void doGet(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {

		HttpSession session = request.getSession();
		String userName = request.getParameter("username");
		String password = request.getParameter("password");

		if (userName == null || password == null) {
			session.setAttribute("message", USER_LOGIN_FAILED_);
		} else {
			String salt = db.getSalt(userName);
			if (salt != null) {
				String hashPassword = PasswordHandler.hashPassword(password, salt);
				if (db.checkLogin(userName, hashPassword)) {
					session.setAttribute("username", userName);
					session.setAttribute("role", db.getRole(userName));
					session.setAttribute("state", LOGIN_TRUE);
					response.sendRedirect("index.jsp");
				} else {
					// ---------Failed Login--------------
					session.setAttribute("message", USER_LOGIN_FAILED_);
					response.sendRedirect("login.jsp");
				}
			} else {
				// ------------Failed Login----------------
				session.setAttribute("message", USER_LOGIN_FAILED_);
				response.sendRedirect("login.jsp");
			}
		}
	}

	/**
	 * All requests are forwarded to the doGet method. ,
	 * 
	 * @throws ServletException if interference with normal operations occurs.
	 * @throws IOException if wrong input is received.
	 * @param request a HttpServletRequest which contains session data
	 * @param response a HttpServletResponse which is used to send redirects to the user
	 */
	protected void doPost(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {

		HttpSession session = request.getSession();
		String userName = request.getParameter("username");
		String mail = db.getEmail(userName);

		if (mail != null) {
			MailHandler mh = new MailHandler();
			String pw = PasswordHandler.generatePassword();
			mh.sendPasswordMail(mail, userName, pw);

			db.changePassword(userName, PasswordHandler.hashPassword(pw, db.getSalt(userName)));
			session.setAttribute("message", PW_CHANGE_SUCCESS_);
			response.sendRedirect("login.jsp");
		} else {
			session.setAttribute("message", PW_CHANGE_FAILED_);
			response.sendRedirect("login.jsp");
		}
	}
}
