<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
	pageEncoding="ISO-8859-1"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="ISO-8859-1">
<title>Register Page</title>
<link rel="stylesheet"
	href="https://maxcdn.bootstrapcdn.com/bootstrap/4.0.0/css/bootstrap.min.css"
	integrity="sha384-Gn5384xqQ1aoWXA+058RXPxPg6fy4IWvTNh0E263XmFcJlSAwiGgFAW/dAiS6JXm"
	crossorigin="anonymous">
<link rel="stylesheet"
	href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/4.7.0/css/font-awesome.min.css">
<link href="css/mystyle.css" rel="stylesheet" type="text/css">
<style>
.banner-background {
	clip-path: polygon(0 0, 100% 0, 100% 30%, 100% 95%, 74% 94%, 36% 100%, 0 91%, 0%
		30%);
}
</style>
</head>
<body>
	<!-- Navbar -->
	
	<%@include file="normal_navbar.jsp" %>
	
	<main class="primary-background banner-background" style="padding-bottom: 80px">
		<div class="container">
			<div class="col-md-6 offset-md-3">
				<div class="card">
					<div class="card-header primary-background text-white text-center">
						<span class="fa fa-user-circle fa-3x"></span>
						<p>Sign up here</p>
					</div>

					<div class="card-body">
						<form>
							<div class="form-group">
								<label for="user_name">Username</label> <input
									type="text" class="form-control" id="user_name"
									aria-describedby="emailHelp" placeholder="Enter name">
							</div>
						
						
							<div class="form-group">
								<label for="exampleInputEmail1">Email address</label> <input
									type="email" class="form-control" id="exampleInputEmail1"
									aria-describedby="emailHelp" placeholder="Enter email">
								<small id="emailHelp" class="form-text text-muted">We'll
									never share your email with anyone else.</small>
							</div>
							
							
							<div class="form-group">
								<label for="exampleInputPassword1">Password</label> <input
									type="password" class="form-control" id="exampleInputPassword1"
									placeholder="Password">
							</div>
							
							<div class="form-group">
								<label for="gender">Select gender</label>
								<br>
								<input type="radio" id="gender" name="gender"> Male
								<input type="radio" id="gender" name="gender"> Female
							</div>
							
							<div class="form-group">
								<textarea class="form-control" name="about"  cols="30" placeholder="Enter something about your self"></textarea>
							</div>
							
							
							<div class="form-check">
								<input type="checkbox" class="form-check-input"
									id="exampleCheck1"> <label class="form-check-label"
									for="exampleCheck1">Agree terms and conditions</label>
							</div>
							<br>
							<button type="submit" class="btn btn-primary">Submit</button>
						</form>
					</div>

					<div class="card-footer"></div>
				</div>
			</div>
		</div>
	</main>


	<script src="https://code.jquery.com/jquery-3.2.1.slim.min.js"
		integrity="sha384-KJ3o2DKtIkvYIK3UENzmM7KCkRr/rE9/Qpg6aAZGJwFDMVNA/GpGFF93hXpG5KkN"
		crossorigin="anonymous"></script>
	<script
		src="https://cdnjs.cloudflare.com/ajax/libs/popper.js/1.12.9/umd/popper.min.js"
		integrity="sha384-ApNbgh9B+Y1QKtv3Rn7W3mgPxhU9K/ScQsAP7hUibX39j7fakFPskvXusvfa0b4Q"
		crossorigin="anonymous"></script>
	<script
		src="https://maxcdn.bootstrapcdn.com/bootstrap/4.0.0/js/bootstrap.min.js"
		integrity="sha384-JZR6Spejh4U02d8jOt6vLEHfe/JQGiRRSQQxSfFWpi1MquVdAyjUar5+76PVCmYl"
		crossorigin="anonymous"></script>
</body>
</html>