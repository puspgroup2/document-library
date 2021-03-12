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
  <title>TimeMate - Change Password</title>
</head>

<body>
  <!-- To make sure user is logged in -->
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
  <c:if test="${sessionScope.passwordMessage eq 0}">
      <div class="alert alert-danger p-1 mx-auto" style="margin-top:1rem; max-width: 25rem" role="alert">
          Your new password can not be the same as your old
      </div>
  </c:if>

  <c:if test="${sessionScope.passwordMessage eq 1}">
      <div class="alert alert-danger p-1 mx-auto" style="margin-top:1rem; max-width: 25rem" role="alert">
          Database error, try again
      </div>
  </c:if>

  <c:if test="${sessionScope.passwordMessage eq 2}">
      <div class="alert alert-success p-1 mx-auto" style="margin-top:1rem; max-width: 25rem" role="alert">
          Password changed succesfully
      </div>
  </c:if>

  <c:if test="${sessionScope.passwordMessage eq 3}">
      <div class="alert alert-danger p-1 mx-auto" style="margin-top:1rem; max-width: 25rem" role="alert">
          Your current password was wrong, try again
      </div>
  </c:if>

  <c:remove var="passwordMessage" scope="session"/>
  <!-- End of pop up messages -->

  <!-- Start card for change password -->
  <div>
    <div class="card mx-auto rounded shadow shadow-sm text-center" style="max-width: 25rem; margin-top:1rem; margin-bottom:50px;">
      <div class="card-header"><h5>Change password</h5></div>
      <div class="card-body">
        <form action="PasswordChangerServlet" method="post">
          <!--Current password input-->
          <div class="input-group">
            <div class="input-group-append">
              <div class="input-group-text"><i class="fa fa-key"></i></div>
            </div>
            <input class="form-control" type="password" placeholder="Current password" id="oldPassword" name="oldPassword">
          </div>

          <!--New password input-->
          <div class="input-group" style="margin-top:10px">
            <div class="input-group-append">
              <div class="input-group-text"><i class="fa fa-lock"></i></div>
            </div>
            <input class="form-control" type="password" placeholder="New password" id="password" name="password">
          </div>

          <!--New password input-->
          <div class="input-group" style="margin-top:10px">
            <div class="input-group-append">
              <div class="input-group-text"><i class="fa fa-lock"></i></div>
            </div>
            <input class="form-control" type="password" placeholder="Repeat new password" id="password2">
          </div>

          <!--Change password button-->
          <div class="row justify-content-center" style="margin-top:20px">
            <button type="submit" class="btn btn-success justify-content-center" id="changePassword" disabled>Change password</button>
          </div>
        </form>

        <!--Password requirements-->
        <div style="margin-top:5px">
          <a><b>Your password must fullfil the following requirements:</b></a><br>
          <span id="8chars" style="color:#FF0004;">8 characters long</span><br>
          <span id="ucase" style="color:#FF0004;">Atleast one uppercase letter</span><br>
          <span id="lcase" style="color:#FF0004;">Atleast one lowercasecase letter</span><br>
          <span id="num" style="color:#FF0004;">Atleast one number</span><br>
          <span id="pwmatch" style="color:#FF0004;">The passwords must match</span> 
        </div>
      </div>
    </div>
  </div>
  <!-- End card for change password -->

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

  <!-- Start script for password check -->
  <script>
    $("input[type=password]").keyup(function(){
      // Check for uppercase letters
      var ucase = new RegExp("[A-Z]+");
      // Check for lowercase letters
      var lcase = new RegExp("[a-z]+");
      // Check for numbers
      var num = new RegExp("[0-9]+");
      
      // If password length is equal to or greater than 8
      if($("#password").val().length >= 8){
        // Set color to green for 8chars
        $("#8chars").css("color","#00A41E");
      }else{
        // Otherwise, set color to red and keep button disabled
        $("#8chars").css("color","#FF0004");
        $('#changePassword').prop('disabled', true);
      }
      
      // If password contains atleast one uppercase letter
      if(ucase.test($("#password").val())){
        // Set color to green for ucase
        $("#ucase").css("color","#00A41E");
      }else{
        // Otherwise, set color to red and keep button disabled
        $("#ucase").css("color","#FF0004");
        $('#changePassword').prop('disabled', true);
      }
      
      // If password contains atleast one lowercase letter
      if(lcase.test($("#password").val())){
        // Set color to green for lcase
        $("#lcase").css("color","#00A41E");
      }else{
        // Otherwise, set color to red and keep button disabled
        $("#lcase").css("color","#FF0004");
        $('#changePassword').prop('disabled', true);
      }
      
      // If password contains atleast one number
      if(num.test($("#password").val())){
        // Set color to green for num
        $("#num").css("color","#00A41E");
      }else{
        // Otherwise, set color to red and keep button disabled
        $("#num").css("color","#FF0004");
        $('#changePassword').prop('disabled', true);
      }
      
      // If passwords are matching
      if($("#password").val() == $("#password2").val() && $("#password").val() != ""){
        // Set color green for pwmatch
        $("#pwmatch").css("color","#00A41E");
      }else{
        // Otherwise, set color to red and keep button disabled
        $("#pwmatch").css("color","#FF0004");
        $('#changePassword').prop('disabled', true);
      }
      
      // If all the above requirements are fullfilled
      if($("#password").val() == $("#password2").val() && num.test($("#password").val()) && lcase.test($("#password").val()) && ucase.test($("#password").val()) && $("#password").val().length >= 8) {
        // Enable the button
        $('#changePassword').prop('disabled', false);
      }
      
    });
  </script>
  <!-- End script for password check -->
</body>