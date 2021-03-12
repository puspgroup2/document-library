<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
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
  <title>TimeMate - Home</title>
</head>

<body>
  <!-- To make sure user is logged in-->
  <%
    if(session.getAttribute("username") == null) {
      response.sendRedirect("login.jsp");
    }
  %>

  <!-- Start of navbar -->
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
            	<li class="nav-item">
                <form action="UserManagementServlet">
                  <input type="submit" value="User Management" class="nav-link astext">
                </form>
            	</li>
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
  <!-- End of navbar -->

  <!-- Start card for welcoming user -->
  <div class="card mx-auto rounded shadow shadow-sm text-center" style="max-width: 30rem; margin-top:50px; margin-bottom:50px;">
    <div class="card-header">
      <h5>Welcome to TimeMate ${username}</h5>
    </div>

    <div class="card-body">
      Please see the navigation bar at the top of the website in order to navigate.
    </div>
  </div>
  <!-- End card for welcoming user -->

  <!-- Start modal for logout -->
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
  <!-- End modal for logout -->
</body>