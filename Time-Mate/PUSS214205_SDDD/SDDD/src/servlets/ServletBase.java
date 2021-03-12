package servlets;

import javax.servlet.http.HttpServlet;

import database.DataBase;

/**
 * This class is the superclass for most servlets in the application. It includes
 * basic functionality required by many servlets, like for example the connection to the database.
 */
public class ServletBase extends HttpServlet {

	// Define states
	public static final int LOGIN_FALSE = 0;
	public static final int LOGIN_TRUE = 1;
	protected static DataBase db = null;

	/**
	 * This is the connector to the database.
	 */
	public ServletBase() {
		db = new DataBase();
		db.connect();
	}

}
