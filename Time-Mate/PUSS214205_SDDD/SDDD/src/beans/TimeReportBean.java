package beans;

import java.io.IOException;
import java.io.Serializable;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

/** This class is the bean for the web pages "newReport.jsp, editReport.jsp and summaryReport.jsp".*/
public class TimeReportBean implements Serializable {

	private int week = 0;
	private String userName;
	private String signed;
	private int totalTime;
	private int reportID = -1;
	private String role;
	private Map<String, Integer> reportValuesD = new HashMap<String, Integer>();
	private Map<String, Integer> reportValuesI = new HashMap<String, Integer>();
	private Map<String, Integer> reportValuesF = new HashMap<String, Integer>();
	private Map<String, Integer> reportValuesR = new HashMap<String, Integer>();
	private Map<String, Integer> reportValuesActivity = new HashMap<String, Integer>();
	private String[] fieldNamesD = { "sdp_d", "srs_d", "svvs_d", "stldd_d", "svvi_d", "sddd_d", "svvr_d", "ssd_d",
			"final_d", "total_d" };
	private String[] fieldNamesI = { "sdp_i", "srs_i", "svvs_i", "stldd_i", "svvi_i", "sddd_i", "svvr_i", "ssd_i",
			"final_i", "total_i" };
	private String[] fieldNamesF = { "sdp_f", "srs_f", "svvs_f", "stldd_f", "svvi_f", "sddd_f", "svvr_f", "ssd_f",
			"final_f", "total_f" };
	private String[] fieldNamesR = { "sdp_r", "srs_r", "svvs_r", "stldd_r", "svvi_r", "sddd_r", "svvr_r", "ssd_r",
			"final_r", "total_r" };
	private String[] fieldNamesActivity = { "totalMinutes", "functionalTest", "systemTest", "regressionTest", "meeting",
			"lecture", "exercise", "computerExercise", "homeReading", "other" };

	private List<String[]> allFields = new ArrayList<String[]>();
	private List<Map<String, Integer>> reportFields = new ArrayList<Map<String, Integer>>();

	/**
	 * Fetches the week that the report was created for.
	 * 
	 * @return week
	 */
	public int getWeek() {
		return week;
	}

	/**
	 * Sets the week that the time report was created for.
	 * 
	 * @param week
	 */
	public void setWeek(int week) {
		this.week = week;
	}

	/**
	 * Fetches the role of the user.
	 * 
	 * @return role
	 */
	public String getRole() {
		return role;
	}

	/**
	 * Sets the role of the user.
	 * 
	 * @param role
	 */
	public void setRole(String role) {
		this.role = role;
	}

	/**
	 * Fetches the signed time report.
	 * 
	 * @return signed
	 */
	public String getSigned() {
		return signed;
	}

	/**
	 * Sets the time report as signed.
	 * 
	 * @param signed
	 */
	public void setSigned(String signed) {
		this.signed = signed;
	}

	/**
	 * Fetches the total time that reported.
	 * 
	 * @return totalTime
	 */
	public int getTotalTime() {
		return totalTime;
	}

	/**
	 * Sets the total time for a specified week.
	 * 
	 * @param totalTime
	 */
	public void setTotalTime(int totalTime) {
		this.totalTime = totalTime;
	}

	/**
	 * Fetches the ID of the report.
	 * 
	 * @return reportID
	 */
	public int getReportID() {
		return this.reportID;
	}

	/**
	 * Sets ID to the report.
	 * 
	 * @param reportID
	 */
	public void setReportID(int reportID) {
		this.reportID = reportID;
	}

	/**
	 * Sets the userName for the current user.
	 * 
	 * @param username
	 */
	public void setUsername(String userName) {
		this.userName = userName;
	}

	/**
	 * Fetches the userName.
	 * 
	 * @return userName
	 */
	public String getUsername() {
		return this.userName;
	}

	/**
	 * Fetches a list of the reported values for Document Development, the values are in minutes.
	 * 
	 * @return map reportValuesD
	 */
	public Map<String, Integer> getReportValuesD() {
		return reportValuesD;
	}

	/**
	 * Fetches a list of the reported values for Document Informal Review, the values are in minutes.
	 * 
	 * @return map reportValuesI
	 */
	public Map<String, Integer> getReportValuesI() {
		return reportValuesI;
	}

	/**
	 * Fetches a list of the reported values for Document Formal Review, the values are in minutes.
	 * 
	 * @return map reportValuesF
	 */
	public Map<String, Integer> getReportValuesF() {
		return reportValuesF;
	}

	/**
	 * Fetches a list of the reported values for Document Rework, the values are in minutes.
	 * 
	 * @return map reportValuesR
	 */
	public Map<String, Integer> getReportValuesR() {
		return reportValuesR;
	}

	/**
	 * Fetches a list of the reported values that are not directly linked to a specific document, the values are in minutes.
	 * 
	 * @return map reportValuesActivity
	 */
	public Map<String, Integer> getReportValuesActivity() {
		return reportValuesActivity;
	}

	/**
	 * Fills the bean with report values from the database.
	 * One map for each field in the time report with an Integer for the total time.
	 * 
	 * @param D        The map of the reported values in the Development field of a time report
	 * @param I        The map of the reported values in the Informal Review field of a time report
	 * @param F        The map of the reported values in the Formal Review field of a time report
	 * @param R        The map of the reported values in the Rework field of a time report
	 * @param Activity The map of the reported values in the Activity field of a time report
	 * @param time     Total time
	 */
	public void populateBean(Map<String, Integer> D, Map<String, Integer> I, Map<String, Integer> F,
			Map<String, Integer> R, Map<String, Integer> Activity, Integer time) {
		reportValuesD = D;
		reportValuesI = I;
		reportValuesF = F;
		reportValuesR = R;
		reportValuesActivity = Activity;
		totalTime = time;
	}

	/**
	 * Fills the bean with report values from front-end.
	 * Retrieves values from each field in the time report and puts it into the corresponding map.
	 * Retrieves the value of the total time entered into the time report and puts it into an integer.
	 * 
	 * @throws ServletException if interference with normal operations occurs.
	 * @throws IOException if wrong input is received.
	 * @param request a HttpServletRequest which contains session data
	 * @param response a HttpServletResponse which is used to send redirects to the user
	 */
	public void populateBean(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		allFields.add(fieldNamesD);
		allFields.add(fieldNamesI);
		allFields.add(fieldNamesF);
		allFields.add(fieldNamesR);
		allFields.add(fieldNamesActivity);

		reportFields.add(reportValuesD);
		reportFields.add(reportValuesI);
		reportFields.add(reportValuesF);
		reportFields.add(reportValuesR);
		reportFields.add(reportValuesActivity);

		for (int i = 0; i < allFields.size(); i++) {
			for (int j = 0; j < allFields.get(i).length; j++) {
				String Input = request.getParameter(allFields.get(i)[j]);
				if (Input == null || Input == "") {
					reportFields.get(i).put(allFields.get(i)[j], 0);
				} else {
					reportFields.get(i).put(allFields.get(i)[j], Integer.parseInt(Input));
				}
			}
		}

		String Input = request.getParameter("totalMinutes");
		totalTime = Integer.parseInt(Input);
	}

}
