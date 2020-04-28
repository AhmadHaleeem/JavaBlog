package com.tech.blog.dao;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;

public class LikeDao {

	Connection con;

	public LikeDao(Connection con) {
		this.con = con;
	}

	public boolean insertLike(int pid, int uid) {
		boolean f = false;
		try {
			String q = "insert into liked (pid,uid) values (?, ?)";
			PreparedStatement stmt = this.con.prepareStatement(q);
			// values set...
			stmt.setInt(1, pid);
			stmt.setInt(2, uid);
			stmt.executeUpdate();
			f = true;

		} catch (Exception e) {
			e.printStackTrace();
		}

		return f;
	}

	public int countLikeOnPost(int pid) {

		int count = 0;

		try {
			String query = "select count(*) as count from liked where pid = ?";
			PreparedStatement stmt = this.con.prepareStatement(query);
			stmt.setInt(1, pid);
			ResultSet res = stmt.executeQuery();
			if (res.next()) {
				count = res.getInt("count");
			}

		} catch (SQLException e) {
			e.printStackTrace();
		}

		return count;
	}

	public boolean isLikedByUser(int pid, int uid) {
		boolean f = false;

		try {
			PreparedStatement stmt = this.con.prepareStatement("select * from liked where pid = ? and uid = ?");
			stmt.setInt(1, pid);
			stmt.setInt(2, uid);

			ResultSet res = stmt.executeQuery();
			if (res.next()) {
				f = true;
			}
		} catch (Exception e) {
			e.printStackTrace();
		}

		return f;
	}

	public boolean deletelike(int pid, int uid) {
		boolean f = false;

		try {
			PreparedStatement stmt = this.con.prepareStatement("delete from liked where pid = ? and uid = ?");
			stmt.setInt(1, pid);
			stmt.setInt(2, uid);
			stmt.executeUpdate();
			f = true;

		} catch (Exception e) {
			e.printStackTrace();
		}

		return f;
	}
}
