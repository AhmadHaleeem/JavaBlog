package com.tech.blog.helper;

import java.sql.*;

public class ConnectionProvider {

	private static Connection con;

	public static Connection getConnection() {
		try {
			if (con == null) {
				// driver class load
				Class.forName("com.mysql.cj.jdbc.Driver");
				// Create a connection..
				con = DriverManager.getConnection(
						"jdbc:mysql://localhost:3306/techblog?useUnicode=true&useJDBCCompliantTimezoneShift=true&useLegacyDatetimeCode=false&serverTimezone=UTC",
						"root", "root");

			}

		} catch (Exception e) {
			e.printStackTrace();
		}
		return con;
	}
}
