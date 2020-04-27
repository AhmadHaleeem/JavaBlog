package com.tech.blog.dao;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.Timestamp;
import java.util.ArrayList;
import java.util.List;

import com.tech.blog.entities.Category;
import com.tech.blog.entities.Post;

public class PostDao {

	Connection con;

	public PostDao(Connection con) {
		this.con = con;
	}

	public ArrayList<Category> getAllCategories() {
		ArrayList<Category> list = new ArrayList<Category>();

		try {
			String query = "select * from categories";
			PreparedStatement stmt = con.prepareStatement(query);
			ResultSet resultSet = stmt.executeQuery();

			while (resultSet.next()) {
				int cid = resultSet.getInt("cid");
				String name = resultSet.getString("name");
				String description = resultSet.getString("description");
				Category category = new Category(cid, name, description);
				list.add(category);
			}

		} catch (Exception e) {
			e.printStackTrace();
		}

		return list;
	}

	public boolean savePost(Post post) {
		boolean f = false;

		try {
			String query = "insert into posts (pTitle, pContent, pCode, pPic, catId, userId) values (?, ?, ?, ?, ?, ?)";
			PreparedStatement stmt = this.con.prepareStatement(query);
			stmt.setString(1, post.getpTitle());
			stmt.setString(2, post.getpContent());
			stmt.setString(3, post.getpCode());
			stmt.setString(4, post.getpPic());
			stmt.setInt(5, post.getCatId());
			stmt.setInt(6, post.getUserId());
			stmt.executeUpdate();
			f = true;

		} catch (Exception e) {
			e.printStackTrace();
		}

		return f;
	}

	public List<Post> getAllPosts() {
		List<Post> postsList = new ArrayList<>();

		try {
			PreparedStatement stmt = this.con.prepareStatement("select * from posts order by pid desc");
			ResultSet executeQuery = stmt.executeQuery();

			while (executeQuery.next()) {
				int pId = executeQuery.getInt("pid");
				String pTitle = executeQuery.getString("pTitle");
				String pContent = executeQuery.getString("pContent");
				String pCode = executeQuery.getString("pCode");
				String pPic = executeQuery.getString("pPic");
				Timestamp date = executeQuery.getTimestamp("pDate");
				int catId = executeQuery.getInt("catId");
				int userId = executeQuery.getInt("userId");

				Post post = new Post(pId, pTitle, pContent, pCode, pPic, date, catId, userId);

				postsList.add(post);
			}

		} catch (Exception e) {
			e.printStackTrace();
		}

		return postsList;
	}

	public List<Post> getPostByCatId(int catId) {
		List<Post> postsListByCatId = new ArrayList<>();

		try {
			PreparedStatement stmt = this.con.prepareStatement("select * from posts where catId = ?");
			stmt.setInt(1, catId);
			ResultSet executeQuery = stmt.executeQuery();

			while (executeQuery.next()) {
				int pId = executeQuery.getInt("pid");
				String pTitle = executeQuery.getString("pTitle");
				String pContent = executeQuery.getString("pContent");
				String pCode = executeQuery.getString("pCode");
				String pPic = executeQuery.getString("pPic");
				Timestamp date = executeQuery.getTimestamp("pDate");
				int cId = executeQuery.getInt("catId");
				int userId = executeQuery.getInt("userId");

				Post post = new Post(pId, pTitle, pContent, pCode, pPic, date, cId, userId);

				postsListByCatId.add(post);
			}

		} catch (Exception e) {
			e.printStackTrace();
		}
		
		
		return postsListByCatId;
	}
}
