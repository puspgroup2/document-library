package servlets;

import java.io.IOException;
import java.util.ArrayList;
import java.util.Comparator;
import java.util.List;

import javax.servlet.ServletException;
import javax.servlet.ServletOutputStream;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import beans.TimeReportBean;

/**
 * This servlet handles sign/unsigning Time reports.
 */
@WebServlet("/TimeReportManagementServlet")
public class TimeReportManagementServlet extends ServletBase {

	/**
	 * Handles GET request and serves signreport.jsp.
	 * 
	 * @throws ServletException if interference with normal operations occurs.
	 * @throws IOException if wrong input is received.
	 * @param request a HttpServletRequest which contains session data
	 * @param response a HttpServletResponse which is used to send redirects to the user
	 */
	protected void doGet(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		HttpSession session = request.getSession();
		List<TimeReportBean> unsignedReports = getUnsignedReports();
		session.setAttribute("unsignedReports", unsignedReports);
		response.sendRedirect("signreport.jsp");
		System.out.println(request.getParameter("getUsersReport"));
	}

	/** Helper method to get all unsigned time reports. */
	private List<TimeReportBean> getUnsignedReports() {
		List<TimeReportBean> unsignedReports = new ArrayList<TimeReportBean>();

		for (Integer id : db.getUnsignedTimeReportIDs()) {
			TimeReportBean bean = new TimeReportBean();
			bean.setReportID(id);
			bean.setTotalTime(db.getTotalMinutesFromTimeReport(id));
			bean.setWeek(db.getWeekFromTimeReport(id));
			bean.setSigned(db.getSignatureFromTimeReport(id));
			bean.setUsername(db.getUserNameFromTimeReport(id));
			unsignedReports.add(bean);
		}

		// Cryptic sorting, but works fine!
		unsignedReports.sort(Comparator.comparing(b -> b.getWeek(), Comparator.nullsFirst(Comparator.naturalOrder())));
		return unsignedReports;
	}

	/**
	 * This post handles sign/unsign with a Time report.
	 * 
	 * @throws ServletException if interference with normal operations occurs.
	 * @throws IOException if wrong input is received.
	 * @param request a HttpServletRequest which contains session data
	 * @param response a HttpServletResponse which is used to send redirects to the user
	 */
	protected void doPost(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		HttpSession session = request.getSession();
		String userName = (String) session.getAttribute("username");

		// The timereports come as a string in the format of: ["x1", "x2"]
		// We need to parse this into a Java list.
		String unsignedReports = request.getParameter("timeReports");
		List<Integer> ids = unStringifiy(unsignedReports);

		if (request.getParameter("input").equals("sign")) {
			// Sign the reports.
			for (Integer id : ids) {
				db.setSigned(true, userName, id);
			}
		} else if (request.getParameter("input").equals("Unsign")) {
			// UNsign the reports.
			for (Integer id : ids) {
				db.setSigned(false, userName, id);
			}
		}

		sendJsResponse(response);

	}

	/**
	 * Helper method to send response to frontend JS. Not that this is needed
	 * instead of a redirect because the frontend handles the page redirect.
	 */
	private void sendJsResponse(HttpServletResponse response) throws IOException {
		ServletOutputStream out = response.getOutputStream();
		out.print("ok");
		out.flush();
	}

	/**
	 * Parses raw string data to a list of integers.
	 * 
	 * @param rawData raw string
	 * @return List of integers
	 */
	private List<Integer> unStringifiy(String rawData) {
		List<Integer> ids = new ArrayList<Integer>();
		if (!rawData.equals("[]")) {
			for (String rawId : rawData.split(",")) {
				String id = rawId.split("\"")[1];
				ids.add(Integer.parseInt(id));
			}
		}
		return ids;
	}

}
