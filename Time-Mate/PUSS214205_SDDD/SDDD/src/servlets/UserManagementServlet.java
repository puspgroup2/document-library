package servlets;

import java.io.IOException;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import beans.UserManagementBean;
import java.util.ArrayList;
import java.util.HashMap;

/**
 * This servlet handles most managements for user handling
 */
@WebServlet("/UserManagementServlet")
public class UserManagementServlet extends ServletBase {
	
	/**
	 * This method is called when the webpage using this class is loaded.
	 * 
	 * @throws ServletException if interference with normal operations occurs.
	 * @throws IOException if wrong input is received.
	 * @param request a HttpServletRequest which contains session data
	 * @param response a HttpServletResponse which is used to send redirects to the user
	 */
	protected void doGet(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		HttpSession session = request.getSession();
		UserManagementBean umb = new UserManagementBean();
		HashMap<String, String> userMap = new HashMap<>(); // Creates a map intended to contain <Username, Role>.
		ArrayList<String> userNames = (ArrayList<String>) db.getUsers();
		for (String s : userNames) {
			if (!s.equals("admin")) {
				userMap.put(s, db.getRole(s)); // Fills the map with values from the database.
			}
		}
		umb.populateBean(userMap);
		session.setAttribute("UserManagementBean", umb);
		response.sendRedirect("usermanagement.jsp");
	}

	/**
	 * This method is called when submitting the changes made to users.
	 * 
	 * @throws ServletException if interference with normal operations occurs.
	 * @throws IOException if wrong input is received.
	 * @param request a HttpServletRequest which contains session data
	 * @param response a HttpServletResponse which is used to send redirects to the user
	 */
	protected void doPost(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		ArrayList<String> userNames = (ArrayList<String>) db.getUsers(); // Retrieve all members in database
		for (String name : userNames) {
			if (!name.equals("admin")) {
				db.updateRole(name, request.getParameter(name + "role")); // Updates the roles of all users according to
																			// the fields on the webpage.
			}
		}
		doGet(request, response);
	}
}