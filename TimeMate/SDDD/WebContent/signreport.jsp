<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@page import="java.util.List"%>
<%@page import="java.sql.*"%>
<%@page import="beans.TimeReportBean"%>

<!DOCTYPE html>
<html lang="en">

<link rel="stylesheet" href="https://stackpath.bootstrapcdn.com/bootstrap/4.1.3/css/bootstrap.min.css"> 
<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/font-awesome/4.7.0/css/font-awesome.min.css">
<link rel="stylesheet" href="css/style.css">
<script
  src="https://code.jquery.com/jquery-3.6.0.js"
  integrity="sha256-H+K7U5CnXl1h5ywQfKtSj8PCmoN9aaq30gDh27Xc0jk="
  crossorigin="anonymous"></script>
<script src="https://cdnjs.cloudflare.com/ajax/libs/popper.js/1.12.9/umd/popper.min.js" integrity="sha384-ApNbgh9B+Y1QKtv3Rn7W3mgPxhU9K/ScQsAP7hUibX39j7fakFPskvXusvfa0b4Q" crossorigin="anonymous"></script>
<script src="https://maxcdn.bootstrapcdn.com/bootstrap/4.0.0/js/bootstrap.min.js" integrity="sha384-JZR6Spejh4U02d8jOt6vLEHfe/JQGiRRSQQxSfFWpi1MquVdAyjUar5+76PVCmYl" crossorigin="anonymous"></script>

<head>
  <meta charset="utf-8">
  <meta name="viewport" content="width=device-width, initial-scale=1, shrink-to-fit=no">
  <meta name="description" content="TimeMate">
  <meta name="author" content="PUSPGroup2">
  <title>TimeMate - View Time Reports</title>
</head>

<body>
  <!-- To make sure user is logged in-->
  <%
  if(session.getAttribute("username") == null) {
    response.sendRedirect("login.jsp");
  }
	%>

  <!-- Start navbar -->
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
  <!-- End navbar -->

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
        	    <input type="submit" name="new" value="Create New Time Report" class="list-group-item list-group-item-action bg-light astext">
            </form>
            <c:if test = "${sessionScope.role eq 'ADMIN' || sessionScope.role eq 'PG'}">
    	       	<form action="TimeReportManagementServlet">
        	        <input type="submit" value="Sign Time Reports" class="list-group-item list-group-item-action active bg-secondary astext">
              	</form>
            </c:if>
            </div>
        </div>
    </div>
    <!-- /#sidebar-wrapper -->

    <!-- Page Content -->
    <div id="page-content-wrapper">
        <div style="background-color:white">
          <table class="table table-striped">
          <thead>
            <tr>
              <th scope="col" data-field="state">Signed</th>
              <th scope="col">User</th>
              <th scope="col">Week</th>
              <th scope="col">Total time</th>
            </tr>
          </thead>
          <tbody>

            <% List<TimeReportBean> timeReports = (List<TimeReportBean>) session.getAttribute("unsignedReports"); %>

            <% for (TimeReportBean report: timeReports) { %>
                <tr>
                  <td>
                    <div class="form-check">
                       <input class="form-check-input" type="checkbox" value="" id="<%=report.getReportID()%>">
                    </div>
                  </td>
                  <td><%= report.getUsername() %></td>
                  <td><%= report.getWeek() %></td>
                  <td><%= report.getTotalTime() %></td>
                </tr>
            <%}%>
          </tbody>
        </table>
        </div>

        <!-- Submit button -->
        <div class="d-flex justify-content-center">
          <button id="submit" class="btn btn-success">Submit</button>
        </div>
    </div>
    <!-- /#page-content-wrapper -->
</div>

  <!-- Start log out modal -->
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
  <!-- End log out modal -->
  
<!-- script for signing Time Reports -->
<script>
  $('#submit').on('click', () => {
    const boxes = getSignedReports();
    const ids = boxes.map(box => $(box).attr('id'));
    console.log(ids)
    $.post("/SDDD/TimeReportManagementServlet",  {
      "input": "sign",
      "timeReports": JSON.stringify(ids)
    },
    (data) => {
      if (data == 'ok') {
        // Reload the page.
        
        location.href = "/TimeReportManagementServlet";
        //location.reload();
      }
    });
  })

  function getReports(signed) {
    let boxes = [];
    for (box of $(".form-check-input")) {
      if (signed) {
        if (box.checked) {
           boxes.push(box);
        }
      } else {
        if (!box.checked) {
           boxes.push(box);
        }
      }

    }
    return boxes;
  }

  function getUnsignedReports() {
    return getReports(false);
  }

  function getSignedReports() {
    return getReports(true);
  }


</script>

</body>