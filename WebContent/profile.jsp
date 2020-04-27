<%@page import="com.tech.blog.entities.Category"%>
<%@page import="com.tech.blog.dao.PostDao"%>
<%@page import="com.tech.blog.entities.Message"%>
<%@page import="com.tech.blog.helper.ConnectionProvider"%>
<%@page import="com.tech.blog.entities.User"%>
<%@page errorPage="error_page.jsp"%>
<%
	User user = (User) session.getAttribute("currentUser");
	if (user == null) {
		response.sendRedirect("login_page.jsp");
	}
%>

<!DOCTYPE html>
<html>
<head>
<meta charset="ISO-8859-1">
<title>Login page</title>
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
				<li class="nav-item"><a class="nav-link" href="#" data-toggle="modal" data-target="#do-post-modal"><span
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

	<%
		Message message = (Message) session.getAttribute("msg");
		if (message != null) {
	%>
	<div class="alert <%=message.getCssClass()%>" role="alert">
		<%=message.getContent()%>
	</div>
	<%
		session.removeAttribute("msg");
		}
	%>
	
	<!-- Main body of the page  -->
	
	<main>
		<div class="container">
			<div class="row mt-4">
				<div class="col-md-4">
					<!-- CATEGORIES -->
					<div class="list-group">
					  <a href="#" onclick="getPosts(0)" class="c-link list-group-item list-group-item-action active">
					    All Categories
					  </a>
					  <% 
					  	PostDao post = new PostDao(ConnectionProvider.getConnection());
						for(Category category: post.getAllCategories()) {
					  	
					  %>
					 	 <a href="#" onclick="getPosts(<%= category.getCid() %>)" class="c-link list-group-item list-group-item-action"><%= category.getName() %></a>
				 	 <%
					  	}
				 	 %>
					</div>
				</div>
				
				<div class="col-md-8">
					<!-- POSTS  -->
					<div class="container text-center" id="loader">
						<i class="fa fa-refresh fa-4x fa-spin"></i>
						<h3 class="mt-2">Loading....</h3>
					</div>
					
					<div class="container-fluid" id="post-container">
						
					</div>
					
				</div>
			</div>
			
					
		</div>
	</main>
	

	<!-- PROFILE SECTION -->

	<!-- Modal -->
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


	<!-- Start Post Modal -->
	<div class="modal fade" id="do-post-modal" tabindex="-1" role="dialog"
		aria-labelledby="exampleModalLabel" aria-hidden="true">
		<div class="modal-dialog" role="document">
			<div class="modal-content">
				<div class="modal-header">
					<h5 class="modal-title" id="exampleModalLabel">Add new post</h5>
					<button type="button" class="close" data-dismiss="modal"
						aria-label="Close">
						<span aria-hidden="true">&times;</span>
					</button>
				</div>
				<div class="modal-body">
					<form id="add-post-form" action="AddPostServlet" method="post" enctype="multipart/form-data">
						<div class="form-group">
							<select class="form-control" name="cid">
								<option selected disabled>---Select Category---</option>
								<%
									PostDao postDao = new PostDao(ConnectionProvider.getConnection());
									for(Category cat: postDao.getAllCategories()) {
								%>
									<option value="<%= cat.getCid() %>"><%= cat.getName() %></option>
								<%
									}
								%>
							</select>
						</div>
					
						<div class="form-group">
							<input name="pTitle" type="text" placeholder="Enter Post Title" class="form-control">
						</div>
						
						<div class="form-group">
							<textarea name="pContent" class="form-control" rows="4" placeholder="Enter Post Content"></textarea>
						</div>
						
						<div class="form-group">
							<textarea name="pCode" class="form-control" placeholder="Enter Post Program(if any)"></textarea>
						</div>
						
						<div class="form-group">
							<label for="post-photo">Select your post photo</label>
							<input name="pic" id="post-photo" type="file" class="form-control">
						</div>
						
						<div class="container text-center">
							<button type="submit" class="btn btn-primary">Post</button>
						</div>
						
					</form>
					
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
	<script src="https://cdnjs.cloudflare.com/ajax/libs/sweetalert/2.1.2/sweetalert.min.js"></script>

	<script>
		$(document).ready(function() {
			let editStatus = false;

			$("#edit-profile-btn").on("click", function() {
				if (!editStatus) {
					$("#profile-details").hide();

					$("#profile-edit").show();
					editStatus = true;
					$(this).text("Back");
				} else {
					$("#profile-details").show();

					$("#profile-edit").hide();
					editStatus = false;
					$(this).text("Edit");
				}
			});
		});
	</script>

	<!-- Add Post JS -->
	<script>
		$(document).ready(function() {

			$("#add-post-form").on("submit", function(e) {
				e.preventDefault();
				
				console.log("CLICKED event");
				let form = new FormData(this);
				$.ajax({
					url: "AddPostServlet",
					type: "POST",
					data: form,
					success: function(data, textStatus, jqXHR) {
						//success...
						console.log(data);
						if (data.trim() == "DONE") {
							swal("Good job!", "Saved successfully!", "success");
						} else {
							swal("Error!!", "Something went wrong, please try again..", "error");
						}
					},
					error: function(data, textStatus, jqXHR) {
						// error...
						
					},
					processData: false,
					contentType: false
				});
			});
		});
	</script>

	<!-- Loading post using Ajax -->
	<script>
		function getPosts(catId) {
			$("#loader").show();
			$("#post-container").hide();
			
			$.ajax({
				url: "load_posts.jsp",
				data: { cid: catId },
				method: "get",
				success: function(data, textStatus, jqXHR) {
					console.log(catId);
					
					$("#loader").hide();
					$("#post-container").show();
					$("#post-container").html(data);
				}
			});
		}
		$(document).ready(function (e) {
			getPosts(0);
		});
	</script>


</body>
</html>