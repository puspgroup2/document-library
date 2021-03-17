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
  <title>TimeMate - Log in</title>
</head>

<!-- Start of pop up messages -->
<c:if test="${sessionScope.message eq 0}">
    <div class="alert alert-danger p-1 mx-auto" style="margin-top:1rem; max-width: 25rem" role="alert">
        You have entered wrong username and/or password
    </div>
</c:if>

<c:if test="${sessionScope.message eq 1}">
    <div class="alert alert-danger p-1 mx-auto" style="margin-top:1rem; max-width: 25rem" role="alert">
        There is no such user in the database
    </div>
</c:if>


<c:if test="${sessionScope.message eq 2}">
    <div class="alert alert-success p-1 mx-auto" style="margin-top:1rem; max-width: 25rem" role="alert">
        A new password has been sent to your mail
    </div>
</c:if>

<c:remove var="message" scope="session"/>
<!-- End of pop up messages -->

<body>
  <!--Log in card-->
  <div>
    <div class="card mx-auto rounded shadow shadow-sm text-center" style="max-width: 25rem; margin-top:1rem; margin-bottom:50px;">
      <!--Log in header-->
      <div class="card-header">
        <h5>Log in</h5>
      </div>
      <!--Log in body-->
      <div class="card-body">
        <form action="LogIn">
          <!--Username input-->
          <div class="input-group">
            <div class="input-group-append">
              <div class="input-group-text"><i class="fa fa-user"></i></div>
            </div>
            <input class="form-control" type="text" placeholder="Username" name="username">
          </div>

          <!--Password input-->
          <div class="input-group" style="margin-top:10px">
            <div class="input-group-append">
              <div class="input-group-text"><i class="fa fa-lock"></i></div>
            </div>
            <input class="form-control" type="password" placeholder="Password" name="password">
          </div>

          <!--Log in button-->
          <div class="row justify-content-center" style="margin-top:20px">
            <button type="submit" class="btn btn-success justify-content-center" id="btnLogin">Log in</button>
          </div>
        </form>
      </div>

      <!--Open password modal-->
      <div class="card-footer text-muted">
        <a data-target="#forgotPassword" data-toggle="modal" href="#">Forgot password?</a>
      </div>
    </div>
  </div>

  <!--Forgot password modal-->
  <div class="modal fade" id="forgotPassword" tabindex="-1" role="dialog">
    <div class="modal-dialog" role="document">
      <!--Modal content-->
      <div class="modal-content">
        <!--Modal header-->
        <div class="modal-header">
          <h5 class="modal-title">Reset password</h5>
          <button type="button" class="close" data-dismiss="modal" aria-label="Close">
            <span aria-hidden="true">&times;</span>
          </button>
        </div>
      
        <!--Modal body-->
        <form method="post" action="LogIn"> 
          <div class="modal-body">
              <!--Email icon-->
              <div class="input-group">
                  <div class="input-group-append">
                <div class="input-group-text"><i class="fa fa-envelope"></i></div>
              </div>
              <!--Email text field-->
              <input class="form-control" type="text" placeholder="Enter your username" name="username" id="username"></div>
          </div>

          <!--Modal footer-->
          <div class="modal-footer">
            <button type="button" class="btn btn-secondary" data-dismiss="modal">Close</button>
            <button class="btn btn-primary" type="submit">Request new password</button>
          </div>
        </form>
      </div>
    </div>
  </div>
</body>