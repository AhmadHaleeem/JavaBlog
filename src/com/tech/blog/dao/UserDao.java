package com.tech.blog.dao;

import java.sql.*;

import com.tech.blog.entities.User;

public class UserDao {

	private Connection con;

	public UserDao(Connection con) {
		this.con = con;
	}

	// method to insert user to database
	public boolean saveUser(User user) {
		boolean f = false;

		try {
			String query = "insert into user(name, email, password, gender, about) values (?,?,?,?,?)";
			PreparedStatement pstmt = this.con.prepareStatement(query);
			pstmt.setString(1, user.getName());
			pstmt.setString(2, user.getEmail());
			pstmt.setString(3, user.getPassword());
			pstmt.setString(4, user.getGender());
			pstmt.setString(5, user.getAbout());

			pstmt.executeUpdate();
			f = true;

		} catch (Exception e) {
			e.printStackTrace();
		}

		return f;

	}

	// get user by user email and user password
	public User getUserByEmailAndPassword(String email, String password) {
		User user = null;
		try {
			String query = "select * from user where email = ? and password = ?";
			PreparedStatement pstmt = con.prepareStatement(query);
			pstmt.setString(1, email);
			pstmt.setString(2, password);

			ResultSet set = pstmt.executeQuery();
			if (set.next()) {
				user = new User();

				// data from db
				String name = set.getString("name");
				// set to user object
				user.setName(name);

				user.setId(set.getInt("id"));
				user.setEmail(set.getString("email"));
				user.setPassword(set.getString("password"));
				user.setGender(set.getString("gender"));
				user.setAbout(set.getString("about"));
				user.setDateTime(set.getTimestamp("rdate"));
				user.setProfile(set.getString("profile"));

			}

		} catch (Exception e) {
			e.printStackTrace();
		}

		return user;
	}

	public boolean updateUser(User user) {
		boolean f = false;

		try {
			String query = "update user set name = ?, email = ?, password = ?, gender = ?, about = ?, profile = ? where id = ?";

			PreparedStatement stmt = con.prepareStatement(query);
			stmt.setString(1, user.getName());
			stmt.setString(2, user.getEmail());
			stmt.setString(3, user.getPassword());
			stmt.setString(4, user.getGender());
			stmt.setString(5, user.getAbout());
			stmt.setString(6, user.getProfile());
			stmt.setInt(7, user.getId());

			stmt.executeUpdate();
			f = true;

		} catch (Exception ex) {
			ex.printStackTrace();
		}
		return f;
	}

	public User getUserByPostId(int userId) {
		User user = null;
		
		try {
			String query = "select * from user where id = ?";
			PreparedStatement stmt = this.con.prepareStatement(query);
			
			stmt.setInt(1, userId);
			
			ResultSet set = stmt.executeQuery();
			if (set.next()) {
				user = new User();
				
				// set to user object
				user.setId(set.getInt("id"));
				user.setName(set.getString("name"));
				user.setEmail(set.getString("email"));
				user.setPassword(set.getString("password"));
				user.setGender(set.getString("gender"));
				user.setAbout(set.getString("about"));
				user.setDateTime(set.getTimestamp("rdate"));
				user.setProfile(set.getString("profile"));
				
				
			}
		} catch (SQLException e) {
			e.printStackTrace();
		}
		
		return user;
	}
}
