<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
	pageEncoding="ISO-8859-1"%>
<%@page import="com.tech.blog.entities.User"%>
<%@page import="com.tech.blog.entities.Post"%>
<%@page import="com.tech.blog.helper.ConnectionProvider"%>
<%@page import="com.tech.blog.dao.PostDao"%>

<%@page errorPage="error_page.jsp"%>
<%
	User user = (User) session.getAttribute("currentUser");
	if (user == null) {
		response.sendRedirect("login_page.jsp");
	}
%>

<%
	int postId = Integer.parseInt(request.getParameter("post_id"));

	PostDao dao = new PostDao(ConnectionProvider.getConnection());
	Post post = dao.getPostById(postId);
%>


<!DOCTYPE html>
<html>
<head>
<meta charset="ISO-8859-1">
<title><%=post.getpTitle()%></title>
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

.post-title {
	font-weight: 100;
	font-size: 30px;
}

.post-content {
	font-weight: 100;
	font-size: 25px;
}

.post-date {
	font-style: italic;
	font-weight: bold;
}

.post-user-info {
	font-size: 20px;
}

.row-user {
	border: 1px solid #e2e2e2;
	padding-top: 15px;
}

body {
	background: url(img/bg.jpeg);
	background-size: cover;
	background-attachment: fixed;
}
</style>
</head>
<body>

	<nav class="navbar navbar-expand-lg navbar-dark primary-background">
		<a class="navbar-brand" href="index.jsp"><span
			class="fa fa-asterisk"></span> TechBlog</a>
		<button class="navbar-toggler" type="button" data-toggle="collapse"
			data-target="#navbarSupportedContent"
			aria-controls="navbarSupportedContent" aria-expanded="false"
			aria-label="Toggle navigation">
			<span class="navbar-toggler-icon"></span>
		</button>

		<div class="collapse navbar-collapse" id="navbarSupportedContent">
			<ul class="navbar-nav mr-auto">
				<li class="nav-item active"><a class="nav-link" href="#"><span
						class="fa fa-bell-o"></span> Learn Code with Ahmad <span
						class="sr-only">(current)</span> </a></li>
				<li class="nav-item dropdown"><a
					class="nav-link dropdown-toggle" href="#" id="navbarDropdown"
					role="button" data-toggle="dropdown" aria-haspopup="true"
					aria-expanded="false"><span class="fa fa-check-square-o"></span>
						Categories </a>
					<div class="dropdown-menu" aria-labelledby="navbarDropdown">
						<a class="dropdown-item" href="#">Programming Language</a> <a
							class="dropdown-item" href="#">Project Implementation</a>
						<div class="dropdown-divider"></div>
						<a class="dropdown-item" href="#">Data Structure</a>
					</div></li>
				<li class="nav-item"><a class="nav-link" href="#"><span
						class="fa fa-address-book-o"></span> Contact</a></li>
				<li class="nav-item"><a class="nav-link" href="#"
					data-toggle="modal" data-target="#do-post-modal"><span
						class="fa fa-asterisk"></span> New Post</a></li>

			</ul>

			<ul class="navbar-nav mr-right">
				<li class="nav-item"><a class="nav-link" href="#!"
					data-toggle="modal" data-target="#profile-modal"><span
						class="fa fa-user-circle"></span> <%=user.getName()%></a></li>

				<li class="nav-item"><a class="nav-link" href="LogoutServlet"><span
						class="fa fa-user-plus"></span> Logout</a></li>
			</ul>
		</div>
	</nav>

	  <!--main content of body-->

        <div class="container">
            <div class="row my-4">
                <div class="col-md-8 offset-md-2">
                    <div class="card">

                        <div class="card-header primary-background text-white">
                            <h4 class="post-title"><%= post.getpTitle()%></h4>
                            
                        </div>
                        <div class="card-body">
							<img class="card-img-top" style="width: 100%; height: 400px" src="blog_pics/<%=post.getpPic()%>" alt="<%=post.getpTitle()%>">
							
							<div class="row my-3 row-user">
								<div class="col-md-8">
									<p class=post-user-info"><a href=""><b>Ahmad haleem </b></a> has posted</p>
								</div>
								<div class="col-md-4">
									<p class="post-date"><%= post.getpDate().toLocaleString() %></p>
								</div>
							</div>
							
							<p class="post-content"><%= post.getpContent()  %></p>
							<br>
							<br>
							<div class="post-code">
								<pre><%= post.getpCode() %></pre>
							</div>
                        </div>
                        
                        <div class="card-footer primary-background">
							<a href="" class="btn btn-outline-light btn-sm "><i class="fa fa-thumbs-o-up"></i> <span>10</span></a>
							<a href="" class="btn btn-outline-light btn-sm float-right"><i class="fa fa-commenting-o"></i> <span>20</span></a>
                        </div>
                    </div>
                </div>
            </div>
        </div>
	
	
	<div class="modal fade" id="profile-modal" tabindex="-1" role="dialog"
		aria-labelledby="exampleModalLabel" aria-hidden="true">
		<div class="modal-dialog" role="document">
			<div class="modal-content">
				<div class="modal-header primary-background text-white ">
					<h5 class="modal-title" id="exampleModalLabel">TechBlog</h5>
					<button type="button" class="close" data-dismiss="modal"
						aria-label="Close">
						<span aria-hidden="true">&times;</span>
					</button>
				</div>
				<div class="modal-body">
					<div class="container text-center">
						<img src="pics/<%=user.getProfile()%>" alt=""
							style="border-radius: 50%; max-width: 150px">
						<h5 class="modal-title mt-3" id="exampleModalLabel"><%=user.getName()%></h5>

						<!-- USER DETAILS -->
						<div id="profile-details">
							<table class="table">
								<tbody>
									<tr>
										<th scope="row">ID:</th>
										<td><%=user.getId()%></td>
									</tr>
									<tr>
										<th scope="row">Email:</th>
										<td><%=user.getEmail()%></td>
									</tr>
									<tr>
										<th scope="row">Gender:</th>
										<td><%=user.getGender()%></td>
									</tr>
									<tr>
										<th scope="row">About:</th>
										<td><%=user.getAbout()%></td>
									</tr>
									<tr>
										<th scope="row">Registered On:</th>
										<td><%=user.getDateTime().toString()%></td>
									</tr>
								</tbody>
							</table>
						</div>
						<!-- PROFILE EDIT  -->

						<div id="profile-edit" style="display: none">
							<h3 class="mt-2">Please Edit Carefully</h3>
							<form action="EditServlet" method="POST"
								enctype="multipart/form-data">
								<table class="table">
									<tr>
										<td>ID:</td>
										<td><%=user.getId()%></td>
									</tr>
									<tr>
										<th scope="row">Email:</th>
										<td><input type="email" class="form-control"
											name="user_email" value="<%=user.getEmail()%>"></td>
									</tr>
									<tr>
										<th scope="row">Name:</th>
										<td><input type="text" class="form-control"
											name="user_name" value="<%=user.getName()%>"></td>
									</tr>
									<tr>
										<th scope="row">Password:</th>
										<td><input type="password" class="form-control"
											name="user_password" value="<%=user.getPassword()%>">
										</td>
									</tr>
									<tr>
										<th scope="row">Gender:</th>
										<td><%=user.getGender().toUpperCase()%></td>
									</tr>
									<tr>
										<th scope="row">About:</th>
										<td><textarea rows="3" class="form-control"
												name="user_about"><%=user.getAbout()%></textarea></td>
									</tr>

									<tr>
										<th scope="row">New Profile:</th>
										<td><input type="file" class="form-control"
											name="user_file" value=""></td>
									</tr>
								</table>

								<div class="container">
									<button type="submit" class="btn btn-outline-primary">Save</button>
								</div>

							</form>
						</div>

					</div>
				</div>
				<div class="modal-footer">
					<button type="button" class="btn btn-secondary"
						data-dismiss="modal">Close</button>
					<button id="edit-profile-btn" type="button" class="btn btn-primary">Edit</button>
				</div>
			</div>
		</div>
	</div>


	<script src="https://code.jquery.com/jquery-3.1.1.min.js"></script>
	<script
		src="https://cdnjs.cloudflare.com/ajax/libs/popper.js/1.12.9/umd/popper.min.js"
		integrity="sha384-ApNbgh9B+Y1QKtv3Rn7W3mgPxhU9K/ScQsAP7hUibX39j7fakFPskvXusvfa0b4Q"
		crossorigin="anonymous"></script>
	<script
		src="https://maxcdn.bootstrapcdn.com/bootstrap/4.0.0/js/bootstrap.min.js"
		integrity="sha384-JZR6Spejh4U02d8jOt6vLEHfe/JQGiRRSQQxSfFWpi1MquVdAyjUar5+76PVCmYl"
		crossorigin="anonymous"></script>
	<script
		src="https://cdnjs.cloudflare.com/ajax/libs/sweetalert/2.1.2/sweetalert.min.js"></script>
</body>
</html>