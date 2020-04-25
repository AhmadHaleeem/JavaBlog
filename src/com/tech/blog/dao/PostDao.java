package com.tech.blog.dao;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.ArrayList;

import com.tech.blog.entities.Category;
import com.tech.blog.entities.Post;
import com.tech.blog.entities.User;

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
}
