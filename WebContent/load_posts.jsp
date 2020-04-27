<%@page import="com.tech.blog.entities.Post"%>
<%@page import="java.util.List"%>
<%@page import="com.tech.blog.helper.ConnectionProvider"%>
<%@page import="com.tech.blog.dao.PostDao"%>
<div class="row">
	<%
		Thread.sleep(1000);
		PostDao dao = new PostDao(ConnectionProvider.getConnection());
		int cid = Integer.parseInt(request.getParameter("cid"));
		List<Post> posts = null;
		if (cid == 0) {
			posts = dao.getAllPosts();
		} else {
			posts = dao.getPostByCatId(cid);
		}
		
		if (posts.size() == 0) {
			out.println("<h3 class='display-3 text-center'>No Posts in the category..</h3>");
			return;
		}
		
		for (Post post : posts) {
	%>
			<div class="col-md-6 mt-2">
				<div class="card">
					<img class="card-img-top " src="blog_pics/<%=post.getpPic()%>"
						alt="<%=post.getpTitle()%>">
					<div class="card-body">
						<b><%=post.getpTitle()%></b>
						<p><%=post.getpContent()%></p>
						<pre><%=post.getpCode()%></pre>
					</div>
					
					<div class="card-footer primary-background text-center">
						<a href="" class="btn btn-outline-light btn-sm "><i class="fa fa-thumbs-o-up"></i> <span>10</span></a>
						<a href="show_blog_page.jsp?post_id=<%= post.getPid() %>" class="btn btn-outline-light btn-sm">Read More</a>
						<a href="" class="btn btn-outline-light btn-sm "><i class="fa fa-commenting-o"></i> <span>20</span></a>
					</div>
		
				</div>
			</div>
	<%
		}
	%>
</div>