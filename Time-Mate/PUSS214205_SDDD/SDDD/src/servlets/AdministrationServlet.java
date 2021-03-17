package servlets;

import java.io.IOException;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.Map;
import java.util.regex.*;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import beans.UserManagementBean;
import handlers.MailHandler;
import handlers.PasswordHandler;

/**
 * This class handles the administration page, which lets the admin remove/add users.
 */
@WebServlet("/AdministrationServlet")
public class AdministrationServlet extends ServletBase {

	/**
	 * This method gets users'name and emails then they are located to the adminstration function page.
	 * It serves to administration.jsp
	 * 
	 * @throws ServletException if interference with normal operations occurs.
	 * @throws IOException if wrong input is received.
	 * @param request a HttpServletRequest which contains session data
	 * @param response a HttpServletResponse which is used to send redirects to the user
	 */
	protected void doGet(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {

		HttpSession session = request.getSession();
		UserManagementBean userBeanAdmin = new UserManagementBean();

		Map<String, String> memberMap = new HashMap<String, String>();
		ArrayList<String> memberNames = (ArrayList<String>) db.getUsers();

		for (String s : memberNames) {
			if (!s.equals("admin")) {
				memberMap.put(s, db.getEmail(s));
			}
		}

		userBeanAdmin.populateBean(memberMap);
		session.setAttribute("AdministrationBean", userBeanAdmin);
		response.sendRedirect("administration.jsp");
	}

	/**
	 *This method handles removing and adding users functions. 
	 *Used to see which buttons is pressed. If a string != null, then that button was pressed
	 * 
	 * @throws ServletException if interference with normal operations occurs.
	 * @throws IOException if wrong input is received.
	 * @param request a HttpServletRequest which contains session data
	 * @param response a HttpServletResponse which is used to send redirects to the user
	 */
	protected void doPost(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		String removeBtn = request.getParameter("remove");
		String addBtn = request.getParameter("add");
		String username = request.getParameter("username");
		String mail = request.getParameter("mail");

		HttpSession session = request.getSession();

		HashMap<String, String> mapM = new HashMap<String, String>();
		ArrayList<String> memberNames = (ArrayList<String>) db.getUsers();

		for (String s : memberNames) {
			if (!s.equals("admin")) {
				mapM.put(s, db.getEmail(s));
			}
		}

		// If the button to remove a user was pressed
		if (removeBtn != null) {
			for (Map.Entry<String, String> member : mapM.entrySet()) {
				if (member.getKey().equals(request.getParameter(member.getKey()))
						&& !member.getKey().equals(request.getParameter("admin"))) {
					db.removeUser(member.getKey());
				}
			}
		}

		// If the button to add a user was pressed
		if (addBtn != null) {
			if (verifyName(username)) {
				String pw = PasswordHandler.generatePassword();
				String salt = PasswordHandler.generateSalt();
				String hashedPw = PasswordHandler.hashPassword(pw, salt);
				if (!db.addUser(username, hashedPw, mail, salt)) {
					session.setAttribute("AdminMessage", 0);
				} else {
					session.setAttribute("AdminMessage", 1);

					if (request.getParameter("mail") != null) {
						MailHandler mh = new MailHandler();
						mh.sendPasswordMail(mail, username, pw);

						db.changePassword(username, hashedPw);
					}
				}
			} else {
				session.setAttribute("AdminMessage", 2);
			}
		}
		doGet(request, response);
	}

	private static boolean verifyName(String username) {
		String regex = "^[0-9a-zA-Z]\\w{4,10}$";

		Pattern pattern = Pattern.compile(regex);

		if (username == null) {
			return false;
		}

		Matcher matcher = pattern.matcher(username);

		return matcher.matches();
	}
}
