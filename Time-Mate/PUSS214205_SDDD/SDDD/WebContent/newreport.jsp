<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<%@ page import="java.util.*" %>
<%@ page import="java.sql.*"%>

<!DOCTYPE html>
<html lang="en">

<link rel="stylesheet" href="https://stackpath.bootstrapcdn.com/bootstrap/4.1.3/css/bootstrap.min.css"> 
<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/font-awesome/4.7.0/css/font-awesome.min.css">
<link rel="stylesheet" href="css/style.css">
<script src="https://code.jquery.com/jquery-3.2.1.slim.min.js" integrity="sha384-KJ3o2DKtIkvYIK3UENzmM7KCkRr/rE9/Qpg6aAZGJwFDMVNA/GpGFF93hXpG5KkN" crossorigin="anonymous"></script>
<script src="https://cdnjs.cloudflare.com/ajax/libs/popper.js/1.12.9/umd/popper.min.js" integrity="sha384-ApNbgh9B+Y1QKtv3Rn7W3mgPxhU9K/ScQsAP7hUibX39j7fakFPskvXusvfa0b4Q" crossorigin="anonymous"></script>
<script src="https://maxcdn.bootstrapcdn.com/bootstrap/4.0.0/js/bootstrap.min.js" integrity="sha384-JZR6Spejh4U02d8jOt6vLEHfe/JQGiRRSQQxSfFWpi1MquVdAyjUar5+76PVCmYl" crossorigin="anonymous"></script>

<head>
  <meta charset="utf-8">
  <meta name="viewport" content="width=device-width, initial-scale=1, shrink-to-fit=no">
  <meta name="description" content="TimeMate">
  <meta name="author" content="PUSPGroup2">
  <title>TimeMate - New Time Report</title>
</head>

<body>
  <!-- To make sure user is logged in -->
  <%
    if(session.getAttribute("username") == null) {
      response.sendRedirect("login.jsp");
    }
  %>

  <!-- Start of navbar-->
  <nav class="navbar navbar-light navbar-expand-md bg-light">

  <a class="navbar-brand abs" href="index.jsp">TimeMate</a>
  
  <button class="navbar-toggler" type="button" data-toggle="collapse" data-target="#collapsingNavbar">
      <span class="navbar-toggler-icon"></span>
  </button>

  <div class="navbar-collapse collapse" id="collapsingNavbar">
      <ul class="navbar-nav">
          
          <form action="TimeReportServlet">
              <input type="submit" value="Time Report" class="nav-link astext">  
           </form>
          <c:if test = "${sessionScope.role eq 'ADMIN' || sessionScope.role eq 'PG'}">
            <form action="UserManagementServlet">
              <input type="submit" value="User Management" class="nav-link astext">
            </form>
          </c:if>
          <c:if test = "${sessionScope.role eq 'ADMIN'}">
            <form action="AdministrationServlet">
              <input type="submit" value="Administration" class="nav-link astext">
            </form>
            </c:if>
      </ul>

      <ul class="navbar-nav ml-auto">
              <li class="nav-item">
                <form class="form-inline my-2 my-lg-0" action="changepassword.jsp">
                  <input type="submit" value="Change Password" class="btn btn-primary" style="margin-right:7px">
                </form>
              </li>
              <li class="nav-item">
                <form class="form-inline my-2 my-lg-0">
                  <a class="btn btn-danger" href="#" data-toggle="modal" data-target="#logoutModal">Log out</a>
                </form>
              </li> 
          </ul>
      </div>
  </nav>
  <!-- End of navbar-->

<div class="d-flex" id="wrapper">

 <!-- Sidebar -->
    <div>
        <div class="bg-light border-right" id="sidebar-wrapper">
            <div class="sidebar-heading">Time Report</div>
            <div class="list-group list-group-flush">
            <form action="TimeReportServlet">
       	        <input type="submit" name="summary" value="Time Report Summary" class="list-group-item list-group-item-action bg-light astext">
            </form>
            <form action="TimeReportServlet" method="POST">
        	    <input type="submit" name="new" value="Create New Time Report" class="list-group-item active list-group-item-action bg-secondary astext">
            </form>
            <c:if test = "${sessionScope.role eq 'ADMIN' || sessionScope.role eq 'PG'}">
    	       	<form action="TimeReportManagementServlet">
        	        <input type="submit" value="Sign Time Reports" class="list-group-item list-group-item-action bg-light astext">
              	</form>
            </c:if>
            </div>
        </div>
    </div>
    <!-- /#sidebar-wrapper -->

  <!-- Page Content -->
  <div id="page-content-wrapper">
    <!-- Start pop up messages -->
    <c:if test="${sessionScope.reportError eq 1}">
        <div class="alert alert-danger p-1 mx-auto" style="margin-top:1rem; max-width: 25rem" role="alert">
            There is already a report with the given week.
        </div>
    </c:if>

	  <c:if test="${sessionScope.reportError eq 2}">
        <div class="alert alert-danger p-1 mx-auto" style="margin-top:1rem; max-width: 25rem" role="alert">
            You need to enter a week for the report.
        </div>
    </c:if>

    <c:remove var="reportError" scope="session"/>
    <!-- End pop up messages -->

    <!-- Start new time report card -->
    <div class="container-fluid">
      <div>
        <div class="card mx-auto rounded shadow shadow-sm" style="max-width: 50rem; margin-top:1rem; margin-bottom:50px;">
          <div class="card-header">
          New Time Report
          </div>
          <div class="card-body">
        
         <form action="TimeReportServlet" method="POST">
            <table class="table table-bordered">
              <tbody>
                <tr>
                <td colspan="7">
                <fieldset disabled>
                  <div class="form-group row">
                    <label for="text" class="col-2 col-form-label">Name:</label> 
                    <div class="col-10">
                      <input id="username" name="username" type="text" class="form-control" placeholder="${username}">
                    </div>
                  </div>
                </fieldset>
                </td>
              </tr>
              <tr>
                <td colspan="4">
                  <fieldset disabled>
                  <div class="form-group row">
                    <label for="text" class="col-4 col-form-label">Role:</label> 
                    <div class="col-8">
                      <input id="projectgroup" name="projectgroup" type="text" class="form-control" placeholder="${role}">
                    </div>
                  </div>
                  </fieldset>
                </td>
                <td colspan="3">
                  <div class="form-group row">
                    <label for="text" class="col-4 col-form-label">Week:</label> 
                    <div class="col-8">
                      <input type="number" id="week" name="week" class="form-control">
                    </div>
                  </div>
                </td>
              </tr>
              <tr>
                <td colspan="7">
                    <div class="form-group row">
                      <label for="text" class="col-5 col-form-label"><b>Part A: Total time this week (minutes):</b></label>
                      <div class="col-7">
                        <input type="number" id="totalMinutes" name="totalMinutes" class="form-control" readonly>
                      </div>
                    </div>
                </td>
              </tr>
              <tr>
                <td colspan="7">
                  <b>Part B: Number of minutes per activity</b><br>
                  (The sum of all seperate activities are automatically summed up and entered above)
                </td>
              </tr>
              <!-- Start header row -->
              <tr>
                <td><b>Number</b></td>
                <td><b>Activity</b></td>
                <td><b>D</b></td>
                <td><b>I</b></td>
                <td><b>F</b></td>
                <td><b>R</b></td>
                <td><b>Total time</b></td>
              </tr>
              <!-- End header row -->
              <!-- Start SDP row -->
              <tr>
                <td>11</td>
                <td>SDP</td>
                <td>
                  <input type="number" id="sdp_d" min="0" name="sdp_d" class="sdp_report_value form-control">
                </td>
                <td>
                  <input type="number" id="sdp_i" min="0" name="sdp_i" class="sdp_report_value form-control">
                </td>
                <td>
                  <input type="number" id="sdp_f" min="0" name="sdp_f" class="sdp_report_value form-control">
                </td>
                <td>
                  <input type="number" id="sdp_r" min="0" name="sdp_r" class="sdp_report_value form-control">
                </td>
                <td>
                    <input type="number" id="sdp_total" name="sdp_total" class="form-control" disabled>
                </td>
              </tr>
              <!-- End SDP row -->
              <!-- Start SRS row -->
              <tr>
                <td>12</td>
                <td>SRS</td>
                <td>
                  <input type="number" id="srs_d" min="0" name="srs_d" class="srs_report_value form-control">
                </td>
                <td>
                  <input type="number" id="srs_i" min="0" name="srs_i" class="srs_report_value form-control">
                </td>
                <td>
                  <input type="number" id="srs_f" min="0" name="srs_f" class="srs_report_value form-control">
                </td>
                <td>
                  <input type="number" id="srs_r" min="0" name="srs_r" class="srs_report_value form-control">
                </td>
                <td>
                  <input type="number" id="srs_total"  name="srs_total" class="form-control" disabled>
                </td>
              </tr>
              <!-- End SRS row -->
              <!-- Start SVVS row -->
              <tr>
                <td>13</td>
                <td>SVVS</td>
                <td>
                  <input type="number" id="svvs_d" min="0" name="svvs_d" class="svvs_report_value form-control">
                </td>
                <td>
                  <input type="number" id="svvs_i" min="0" name="svvs_i" class="svvs_report_value form-control">
                </td>
                <td>
                  <input type="number" id="svvs_f" min="0" name="svvs_f" class="svvs_report_value form-control">
                </td>
                <td>
                  <input type="number" id="svvs_r" min="0" name="svvs_r" class="svvs_report_value form-control">
                </td>
                <td>
                  <input type="number" id="svvs_total" name="svvs_total" class="form-control" disabled>
                </td>
              </tr>
              <!-- End SVVS row -->
              <!-- Start STLDD row -->
              <tr>
                <td>14</td>
                <td>STLDD</td>
                <td>
                  <input type="number" id="stldd_d" min="0" name="stldd_d" class="stldd_report_value form-control">
                </td>
                <td>
                  <input type="number" id="stldd_i" min="0" name="stldd_i" class="stldd_report_value form-control">
                </td>
                <td>
                  <input type="number" id="stldd_f" min="0" name="stldd_f" class="stldd_report_value form-control">
                </td>
                <td>
                  <input type="number" id="stldd_r" min="0" name="stldd_r" class="stldd_report_value form-control">
                </td>
                <td>
                  <input type="number" id="stldd_total"  name="stldd_total" class="form-control" disabled>
                </td>
              </tr>
              <!-- End STLDD row -->
              <!-- Start SVVI row -->
              <tr>
                <td>15</td>
                <td>SVVI</td>
                <td>
                  <input type="number" id="svvi_d" min="0" name="svvi_d" class="svvi_report_value form-control">
                </td>
                <td>
                  <input type="number" id="svvi_i" min="0" name="svvi_i" class="svvi_report_value form-control">
                </td>
                <td>
                  <input type="number" id="svvi_f" min="0" name="svvi_f" class="svvi_report_value form-control">
                </td>
                <td>
                  <input type="number" id="svvi_r" min="0" name="svvi_r" class="svvi_report_value form-control">
                </td>
                <td>
                  <input type="number" id="svvi_total" name="svvi_total" class="form-control" disabled>
                </td>
              </tr>
              <!-- End SVVI row -->
              <!-- Start SDDD row -->
              <tr>
                <td>16</td>
                <td>SDDD</td>
                <td>
                  <input type="number" id="sddd_d" min="0" name="sddd_d" class="sddd_report_value form-control">
                </td>
                <td>
                  <input type="number" id="sddd_i" min="0" name="sddd_i" class="sddd_report_value form-control">
                </td>
                <td>
                  <input type="number" id="sddd_f" min="0" name="sddd_f" class="sddd_report_value form-control">
                </td>
                <td>
                  <input type="number" id="sddd_r" min="0" name="sddd_r" class="sddd_report_value form-control">
                </td>
                <td>
                  <input type="number" id="sddd_total" name="sddd_total" class="form-control" disabled>
                </td>
              </tr>
              <!-- End SDDD row -->
              <!-- Start SVVR row -->
              <tr>
                <td>17</td>
                <td>SVVR</td>
                <td>
                  <input type="number" id="svvr_d" min="0" name="svvr_d" class="svvr_report_value form-control">
                </td>
                <td>
                  <input type="number" id="svvr_i" min="0" name="svvr_i" class="svvr_report_value form-control">
                </td>
                <td>
                  <input type="number" id="svvr_f" min="0" name="svvr_f" class="svvr_report_value form-control">
                </td>
                <td>
                  <input type="number" id="svvr_r" min="0" name="svvr_r" class="svvr_report_value form-control">
                </td>
                <td>
                  <input type="number" id="svvr_total" name="svvr_total" class="form-control" disabled>
                </td>
              </tr>
              <!-- End SVVR row -->
              <!-- Start SDD row -->
              <tr>
                <td>18</td>
                <td>SSD</td>
                <td>
                  <input type="number" id="ssd_d" min="0" name="ssd_d" class="ssd_report_value form-control">
                </td>
                <td>
                  <input type="number" id="ssd_i" min="0" name="ssd_i" class="ssd_report_value form-control">
                </td>
                <td>
                  <input type="number" id="ssd_f" min="0" name="ssd_f" class="ssd_report_value form-control">
                </td>
                <td>
                  <input type="number" id="ssd_r" min="0" name="ssd_r" class="ssd_report_value form-control">
                </td>
                <td>
                  <input type="number" id="ssd_total" name="ssd_total" class="form-control" disabled>
                </td>
              </tr>
              <!-- End SDD row -->
              <!-- Start Final Report row -->
              <tr>
                <td>19</td>
                <td>Final Report</td>
                <td>
                  <input type="number" id="final_d" min="0" name="final_d" class="final_report_value form-control">
                </td>
                <td>
                  <input type="number" id="final_i" min="0" name="final_i" class="final_report_value form-control">
                </td>
                <td>
                  <input type="number" id="final_f" min="0" name="final_f" class="final_report_value form-control">
                </td>
                <td>
                  <input type="number" id="final_r" min="0" name="final_r" class="final_report_value form-control">
                </td>
                <td>
                  <input type="number" id="final_total" name="final_total" class="form-control" disabled>
                </td>
              </tr>
              <!-- End Final Report row -->
              <!-- Start Sum row -->
              <tr>
                <td colspan="2"><b>Sum</b></td>
                <td>
                    <input type="number" id="total_d" name="total_d" class="form-control" disabled>
                </td>
                <td>
                    <input type="number" id="total_i" name="total_i" class="form-control" disabled>
                </td>
                <td>
                    <input type="number" id="total_f" name="total_f" class="form-control" disabled>
                </td>
                <td>
                    <input type="number" id="total_r" name="total_r" class="form-control" disabled>
                </td>
                <td>
                    <input type="number" id="total_total" name="total_total" class="form-control" disabled>
                </td>
              </tr>
              <!-- End Sum row -->
              <!-- Start Functional test row -->
              <tr>
                <td colspan="2">21</td>
                <td colspan="4">Functional test</td>
                <td><input type="number" id="functionalTest" min="0" class="other-values" name="functionalTest" class="form-control"></td>
              </tr>
              <!-- End Functional test row -->
              <!-- Start System test row -->
              <tr>
                <td colspan="2">22</td>
                <td colspan="4">System test</td>
                <td><input type="number" id="systemTest" min="0" class="other-values" name="systemTest" class="form-control"></td>
              </tr>
              <!-- End System test row -->
              <!-- Start Regression test row -->
              <tr>
                <td colspan="2">23</td>
                <td colspan="4">Regression test</td>
                <td><input type="number" id="regressionTest" min="0" class="other-values" name="regressionTest" class="form-control"></td>
              </tr>
              <!-- End Regression test row -->
              <!-- Start Meeting row -->
              <tr>
                <td colspan="2">30</td>
                <td colspan="4">Meeting</td>
                <td><input type="number" id="meeting" min="0" class="other-values" name="meeting" class="form-control"></td>
              </tr>
              <!-- End Meeting row -->
              <!-- Start Lecture row -->
              <tr>
                <td colspan="2">41</td>
                <td colspan="4">Lecture</td>
                <td><input type="number" id="lecture" min="0" class="other-values" name="lecture" class="form-control"></td>
              </tr>
              <!-- End Lecture row -->
              <!-- Start Exercise row -->
              <tr>
                <td colspan="2">42</td>
                <td colspan="4">Exercise</td>
                <td><input type="number" id="exercise" min="0" class="other-values" name="exercise" class="form-control"></td>
              </tr>
              <!-- End Exercise row -->
              <!-- Start Computer Exercise row -->
              <tr>
                <td colspan="2">43</td>
                <td colspan="4">Computer Exercise</td>
                <td><input type="number" id="computerExercise" min="0" class="other-values" name="computerExercise" class="form-control"></td>
              </tr>
              <!-- End Computer Exercise row -->
              <!-- Start Home Reading row -->
              <tr>
                <td colspan="2">44</td>
                <td colspan="4">Home reading</td>
                <td><input type="number" id="homeReading" min="0" class="other-values" name="homeReading" class="form-control"></td>
              </tr>
              <!-- End Home Reading row -->
              <!-- Start Other row -->
              <tr>
                <td colspan="2">100</td>
                <td colspan="4">Other</td>
                <td><input type="number" id="other" min="0" class="other-values" name="other" class="form-control"></td>
              </tr>
              <!-- End Other row -->
              <!-- Start Part C row -->
              <tr>
                <td colspan="7">
                  <b>Part C: Time spent at different types of sub activites</b><br>
                  (The values are summed up automatically)
                </td>
              </tr>
              <!-- End part C row -->
              </tbody>
              <!-- Start total time -->
              <tr>
                <td colspan="2"><b>Activity type</b></td>
                <td><b>Activity code</b></td>
                <td colspan="3"><b>Description</b></td>
                <td><b>Sum</b></td>
              </tr>
              <tr>
                <td colspan="2">Development and documentation</td>
                <td>D</td>
                <td colspan="3">Developing new code, test cases and documentation including documentation of the system</td>
                <td>
                    <input type="number" id="total_d" name="total_d" type="text" class="form-control" disabled>
                </td>
              </tr>
              <tr>
                <td colspan="2">Informal review</td>
                <td>I</td>
                <td colspan="3">Time spent preparing and at meeting for informal reviews</td>
                <td>
                    <input type="number" id="total_i" name="total_i" type="text" class="form-control" disabled>
                </td>
              </tr>
              <tr>
                <td colspan="2">Formal review</td>
                <td>F</td>
                <td colspan="3">Time spent preparing and at meeting for formal reviews</td>
                <td>
                    <input type="number" id="total_f" name="total_f" type="text" class="form-control" disabled>
                </td>
              </tr>
              <tr>
                <td colspan="2">Rework, improvement or correction</td>
                <td>R</td>
                <td colspan="3">Time spent improving, revising or correction documents and design objects</td>
                <td>
                    <input type="number" id="total_r" name="total_r" type="text" class="form-control" disabled>
                </td>
              </tr>
              <!-- End total time -->
            </table>
            <div class="form-group row">
              <div class="offset-0 col-8">
                <button name="submitNew" type="submit" class="btn btn-primary">Submit</button>
              </div>
            </div>
          </form>
          </div>
        </div>
      </div>
    </div>
  </div>
  <!-- End new time report card -->
  <!-- /#page-content-wrapper -->
</div>

  <!-- Start of log out modal -->
  <div class="modal" id="logoutModal" tabindex="-1" role="dialog" aria-hidden="true">
    <div class="modal-dialog modal-sm">
      <div class="modal-content">
        <div class="modal-header">
          <button type="button" class="close" data-dismiss="modal" aria-label="Close"><span aria-hidden="true"></span></button>
          <h4>Log Out <i class="fa fa-lock"></i></h4>
        </div>
        <div class="modal-body">
          <p><i class="fa fa-question-circle"></i> Are you sure you want to log out? <br /></p>
          <div class="actionsBtns">
              <form action="LogOut">
              
                  <input type="hidden" name="${_csrf.parameterName}" value="${_csrf.token}"/>
                  <input type="submit" class="btn btn-default btn-primary" value="Logout" />
                    <button class="btn btn-default" data-dismiss="modal">Cancel</button>
              </form>
          </div>
        </div>
      </div>
    </div>
  </div>
  <!-- End of log out modal -->

<script>

  // Format is "row-boxes", "row-total"
  let documents = [
    ["sdp_report_value", "sdp_total"],
    ["srs_report_value", "srs_total"],
    ["svvs_report_value", "svvs_total"],
    ["stldd_report_value", "stldd_total"],
    ["svvi_report_value", "svvi_total"],
    ["sddd_report_value", "sddd_total"],
    ["svvr_report_value", "svvr_total"],
    ["ssd_report_value", "ssd_total"],
    ["final_report_value", "final_total"]
  ];

  let total_columns = ['total_d', 'total_i', 'total_f', 'total_r'];

  // Bind event listeners on all inputs
  for (let doc of documents) {
    for (let box of document.getElementsByClassName(doc[0])) {
      box.addEventListener('input', updateTotals);
    }
  }

  // Bind event listeners for others as well.
  for (let box of document.getElementsByClassName("other-values")) {
    box.addEventListener('input', updateTotals);
  }

  // Week must be between 0-53!
  document.getElementById('week').addEventListener('input', change => {
    const week = document.getElementById('week');
    const value = getValue(week);
    if (value > 53) {
      week.value = 53;
    } else if (value < 0) {
      week.value = 0;
    }
  });

  // Call it once to set to 0.
  updateTotals();

  /* Updates all the total boxes with the total report for each document. */
  function updateTotals() {
    let col_sums = [0, 0, 0, 0];

    for (let doc of documents) {
      let totalMinutes = getTotal(doc[0]);
      document.getElementById(doc[1]).value = totalMinutes;

      // Calculate the column totals.
      let boxes = document.getElementsByClassName(doc[0]);
      for (let i = 0; i < 4; i++) {
        col_sums[i] += getValue(boxes[i]);
      }
    }

    // Update the total boxes.
    for (let i = 0; i < 4; i++) {
        console.log(total_columns[i], col_sums[i])
        for (let box of document.getElementsByName(total_columns[i])) {
          box.value = col_sums[i];
        }
    }

    let others = getOtherValues();

    // Update the total time (not including "others").
    let totalTotal = 0;
    col_sums.forEach(time => totalTotal += time);
    document.getElementById("total_total").value = totalTotal;


    console.log(others, totalTotal)
    // Update the absolute TOTAL time.
    document.getElementById('totalMinutes').value = others + totalTotal;
  }

  /* Get the total time for the "other" values. */
  function getOtherValues() {
    let sum = 0;
    for (let box of document.getElementsByClassName("other-values")) {
      sum += getValue(box);
    }
    return sum;
  }

  /* Gets the total time for a given document. */
  function getTotal(box_class) {
    let boxes = document.getElementsByClassName(box_class);
    let sum = 0;
    for (let i = 0; i < 4; i++) {
      let value = getValue(boxes[i]);
      sum += value;
    }
    return sum;
  }

  /* Helper function to parse the integer value. */
  function getValue(box) {
    return Number.isNaN(parseInt(box.value)) ? 0 : parseInt(box.value);
  }

</script>
</body>