<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html lang="en">

<link rel="stylesheet" href="https://stackpath.bootstrapcdn.com/bootstrap/4.1.3/css/bootstrap.min.css"> 
<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/font-awesome/4.7.0/css/font-awesome.min.css">
<link rel="stylesheet" href="css/style.css">
<script src="https://code.jquery.com/jquery-3.6.0.js" integrity="sha256-H+K7U5CnXl1h5ywQfKtSj8PCmoN9aaq30gDh27Xc0jk=" crossorigin="anonymous"></script>
<script src="https://cdnjs.cloudflare.com/ajax/libs/popper.js/1.12.9/umd/popper.min.js" integrity="sha384-ApNbgh9B+Y1QKtv3Rn7W3mgPxhU9K/ScQsAP7hUibX39j7fakFPskvXusvfa0b4Q" crossorigin="anonymous"></script>
<script src="https://maxcdn.bootstrapcdn.com/bootstrap/4.0.0/js/bootstrap.min.js" integrity="sha384-JZR6Spejh4U02d8jOt6vLEHfe/JQGiRRSQQxSfFWpi1MquVdAyjUar5+76PVCmYl" crossorigin="anonymous"></script>
<%@page import = "java.util.ArrayList"%>
<%@page import = "java.util.List" %>
<%@page import = "beans.*" %>

<head>
  <meta charset="utf-8">
  <meta name="viewport" content="width=device-width, initial-scale=1, shrink-to-fit=no">
  <meta name="description" content="">
  <meta name="author" content="">
  <%@page import="java.sql.*"%>
  <title>TimeMate - View Time Reports</title>
</head>

<body>
    <%
		if(session.getAttribute("username") == null) {
			response.sendRedirect("login.jsp");
		}
	%>

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

<div class="d-flex" id="wrapper">

 <!-- Sidebar -->
    <div>
        <div class="bg-light border-right" id="sidebar-wrapper">
            <div class="sidebar-heading">Time Report</div>
            <div class="list-group list-group-flush">
            <form action="TimeReportServlet">
       	        <input type="submit" name="summary" value="Time Report Summary" class="list-group-item active list-group-item-action bg-secondary astext">
            </form>
            <form action="TimeReportServlet" method="POST">
        	    <input type="submit" name="new" value="Create New Time Report" class="list-group-item list-group-item-action bg-light astext">
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
    
  <div class="collapse multi-collapse show"  id="collapseExample">

   <div style="background-color:white">
          <table class="table table-striped">
          <thead>
            <tr>
              <th scope="col" data-field="state">Selection</th>
              <th scope="col">User</th>
              
              <th scope="col">Week</th>
              
              <th scope="col">Total time</th>
              <th scope="col">Signed</th>
            </tr>
          </thead>
          <form name="radioButtons">
          <tbody>
          <%List<TimeReportBean> list = (ArrayList<TimeReportBean>) session.getAttribute("timeReports"); %>
          
          <% for (TimeReportBean bean : list) { %>
        	  
            <tr>
              <td><input type="radio" name="radioGroup" id="<%=bean.getReportID()%>" class='<%=(bean.getSigned() == null ? "notSigned" : "signed")%>'></td>
              <td><%=bean.getUsername()%></td>
              <td><%=bean.getWeek() %></td>
              <td><%=bean.getTotalTime() %></td>
              <td><%=(bean.getSigned() == null ? "No" : "Yes")%></td>
            </tr>
           <%} %>
          </tbody>
          </form>
        </table>
        
      </div>
 </div> 
 
 <div class="collapse multi-collapse"  id="collapseExample2">

  <div style="background-color:white">
         <table class="table table-striped">
         <thead>
           <tr>
             <th scope="col" data-field="state">Unsign</th>
             <th scope="col">User</th>
             
             <th scope="col">Week</th>
             
             <th scope="col">Total time</th>
             <th scope="col">Signed</th>
           </tr>
         </thead>
         <tbody>
          	<%List<TimeReportBean> signedList = (ArrayList<TimeReportBean>) session.getAttribute("signedReports"); %>
          	
          	<%for (TimeReportBean bean: signedList) { %>
          	
          	<tr>
          	<td>
                    <div class="form-check">
                       <input class="form-check-input" type="checkbox" value="" id="<%=bean.getReportID()%>">
                    </div>
                  </td>
          	<td>
          	<form action="TimeReportServlet" method="POST">
                <input type="submit" value="<%=bean.getUsername()%>" id="getUsersReport" name="getUsersReport" value="<%=bean.getUsername()%>" class="nav-link astext">
            </form>
            </td>
          	<td><%=bean.getWeek() %></td>
          	<td><%=bean.getTotalTime() %></td>
          	<td><%=(bean.getSigned() == null ? "No" : "Yes") %></td>
          	</tr>
          <%} %>
         </tbody>
       </table>
       <button class="btn btn-primary" id="Unsign" type="button">Unsign</button>
     </div>
</div>
    
      <div class="d-flex justify-content-center" style="margin-top:5px">
            <button class="btn btn-success" id='editBtn' style="margin-right:3px">Edit selected report</button>
            <button class="btn btn-success" id='viewBtn' style="margin-left:3px; margin-right:3px">View selected report</button>
            <c:if test = "${sessionScope.role eq 'ADMIN' || sessionScope.role eq 'PG'}">
            <button class="btn btn-primary" id='showSignBtn' type="button" data-toggle="collapse" data-target=".multi-collapse" aria-expanded="false" aria-controls="collapseExample collapseExample2" style="margin-left:3px">
                SHOW SIGNED REPORTS
            </button>
            </c:if>
        </div>
  </div>
    <!-- /#page-content-wrapper -->

</div>

<!-- Script for resetting radiobuttons when refreshing the page -->
<script>
  window.onload = function(){
    radioButtons.reset();
  }
</script>

<!-- Script for unsigning Time reports -->
<script>
  $('#Unsign').on('click', () => {
    const boxes = getSignedReports();
    const ids = boxes.map(box => $(box).attr('id'));
    
    $.post("/TimeReportManagementServlet",  {
      "input": "Unsign",
      "timeReports": JSON.stringify(ids)
    },
    (data) => {
      if (data == 'ok') {
        // Reload the page.
        location.href = "/TimeReportServlet";
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

<!-- Script for clicking the different buttons "Edit Selected Report", "View selected report" and "Show signed reports" -->
<script>

    let showToggled = false;

    /* Edit button callback function. Send a POST request with the report id. */
    $('#editBtn').click(() =>  {
      const report = getCheckedReport();
      if (report == null)
        return;

      $.post("/TimeReportServlet", {
        'editBtn': 'true',
        'reportID': report.id
      },
      (response) => {
        if (response == 'ok') {
          // Reload the page.
          location.href = "updatereport.jsp";
        }
      });
    });

    $('#viewBtn').click(() =>  {
      const report = getCheckedReport();
      if (report == null)
        return;

      $.post("/TimeReportServlet", {
        'viewBtn': 'true',
        'reportID': report.id
      },
      (response) => {
        if (response == 'ok') {
          // Reload the page.
          location.href = "updatereport.jsp";
        }
      });
    });


    $('#showSignBtn').click(() => {
      showToggled = !showToggled;

      if (showToggled) {
        $('#editBtn').prop('disabled', true);
        $('#viewBtn').prop('disabled', true);
      } else {
        $('#editBtn').prop('disabled', false);
        $('#viewBtn').prop('disabled', false);
      }
    });

    for (let radio of document.getElementsByName('radioGroup')) {
      radio.addEventListener('click', radioButton => {
        if (radio.checked && radio.classList.contains('signed')) {
          $('#editBtn').prop('disabled', true);
        } else {
          $('#editBtn').prop('disabled', false);
        }
      })
    }

    function getCheckedReport() {
      for (let radio of document.getElementsByName('radioGroup')) {
        if (radio.checked) {
          console.log(radio)
          return radio;
        }
      }
      return null;
    }


</script>

</body>