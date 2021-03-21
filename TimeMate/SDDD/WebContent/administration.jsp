<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@page import="beans.UserManagementBean"%>
<%@page import="java.util.Map"%>
<%@page import="java.util.HashMap"%>

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
  <title>TimeMate - Administration</title>
</head>

<body>
  <!-- To make sure user is logged in -->
  <%
    if(session.getAttribute("username") == null) {
      response.sendRedirect("login.jsp");
    } else if (!session.getAttribute("role").equals("ADMIN")) {
      response.sendRedirect("index.jsp");
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
  <!-- End of navbar -->

  <!-- Start of pop up messages -->
  <c:if test="${sessionScope.AdminMessage eq 0}">
      <div class="alert alert-danger p-1 mx-auto" style="margin-top:1rem; max-width: 25rem" role="alert">
          There is already an user with that name.
      </div>
  </c:if>

  <c:if test="${sessionScope.AdminMessage eq 1}">
      <div class="alert alert-success p-1 mx-auto" style="margin-top:1rem; max-width: 25rem" role="alert">
          User added
      </div>
  </c:if>

  <c:if test="${sessionScope.AdminMessage eq 2}">
    <div class="alert alert-danger p-1 mx-auto" style="margin-top:1rem; max-width: 25rem" role="alert">
        The username must be 5-10 letters long and only contain 0-9, A-Z, a-z
    </div>
  </c:if>

  <c:remove var="AdminMessage" scope="session"/>
  <!-- End of pop up messages -->

  <!-- Start card for add user -->
  <div>
    <div class="card mx-auto rounded shadow shadow-sm" style="max-width: 50rem; margin-top:1rem; margin-bottom:50px;">
      <div class="card-header">Add user</div>
      <div class="card-body">
        <form method="post" action="AdministrationServlet">
          <table class="table table-bordered">
            <tbody>
              <tr>
                <td>
                  <div class="form-group row">
                    <label for="text" class="col-4 col-form-label">Username:</label> 
                    <div class="col-8">
                      <input name="username" type="text" class="form-control">
                    </div>
                  </div>
                </td>
                <td>
                  <div class="form-group row">
                    <label for="text1" class="col-4 col-form-label">E-mail:</label> 
                    <div class="col-8">
                      <input name="mail" type="text" class="form-control">
                    </div>
                  </div>
                </td>
              </tr>
              <tr>
                <td colspan="7">A password will be randomly generated and sent along with the username to the mail.</td>
              </tr>
            </tbody>
          </table>
          <div class="form-group row">
            <div class="offset-0 col-8">
              <button name="add" type="submit" class="btn btn-success">Add user</button>
            </div>
          </div>
        </form>
      </div>
    </div>
  </div>
  <!-- End card for add user -->

  <!-- Start card for remove user -->
  <div class="card mx-auto rounded shadow shadow-sm" style="max-width:50rem; margin-top:50px; margin-bottom:50px;">
    <div class="card-header">Remove users</div>
    <div class="card-body">
      <form method="post" action="AdministrationServlet">
        <table class="table table-striped">
          <thead>
            <tr>
              <th scope="col">Selection</th>
              <th scope="col">User</th>
              <th scope="col">Mail</th>
            </tr>
          </thead>
          <tbody>
            <!-- Start code to populate table with users -->
            <%
            UserManagementBean adminBean = (UserManagementBean) session.getAttribute("AdministrationBean");
            HashMap<String, String> userMap = (HashMap<String, String>)adminBean.getUserMap();
            for(Map.Entry<String, String> user : userMap.entrySet()) {
            %>
            <tr>
              <td>
                <div class="form-check">
                  <input class="form-check-input" value="<%=user.getKey()%>" type="checkbox" name="<%=user.getKey()%>" id="flexCheckDefault">
                </div>
              </td>
              <td><%=user.getKey()%></td>
              <td><%=user.getValue()%></td>
            </tr>
            <%}%>
          </tbody>
          <!-- End code to populate table with users -->
        </table>
        <div><b>When clicking confirm, you will remove all checked users</b></div><br>
        <div class="form-group row">
          <div class="offset-0 col-8">
            <button name="remove" type="submit" class="btn btn-danger">Confirm</button>
          </div>
        </div>
      </form>
    </div>
  </div>
  <!-- End card for remove user -->

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