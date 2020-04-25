/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package com.tech.blog.servlets;

import com.mysql.cj.Session;
import com.tech.blog.dao.UserDao;
import com.tech.blog.entities.Message;
import com.tech.blog.entities.User;
import com.tech.blog.helper.ConnectionProvider;
import com.tech.blog.helper.Helper;

import java.io.File;
import java.io.IOException;
import java.io.PrintWriter;
import javax.servlet.ServletException;
import javax.servlet.annotation.MultipartConfig;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import javax.servlet.http.Part;

/**
 *
 * @author Ahmad
 */

@MultipartConfig
public class EditServlet extends HttpServlet {

	/**
	 * Processes requests for both HTTP <code>GET</code> and <code>POST</code>
	 * methods.
	 *
	 * @param request  servlet request
	 * @param response servlet response
	 * @throws ServletException if a servlet-specific error occurs
	 * @throws IOException      if an I/O error occurs
	 */
	protected void processRequest(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		response.setContentType("text/html;charset=UTF-8");
		try (PrintWriter out = response.getWriter()) {
			out.println("<!DOCTYPE html>");
			out.println("<html>");
			out.println("<head>");
			out.println("<title>Servlet LoginServlet</title>");
			out.println("</head>");
			out.println("<body>");
			// Fetch all data
			String name = request.getParameter("user_name");
			String email = request.getParameter("user_email");
			String password = request.getParameter("user_password");
			String about = request.getParameter("user_about");
			Part part = request.getPart("user_file");

			String imageName = part.getSubmittedFileName();

			// get the user data from the session
			HttpSession session = request.getSession();
			User user = (User) session.getAttribute("currentUser");
			user.setEmail(email);
			user.setName(name);
			user.setPassword(password);
			user.setAbout(about);
			String oldFile = user.getProfile();
			user.setProfile(imageName);
			
			

			// update database
			UserDao userDao = new UserDao(ConnectionProvider.getConnection());
			boolean updateUser = userDao.updateUser(user);

			if (updateUser) {

				String oldPathFile = request.getRealPath("/") + "pics" + File.separator + oldFile;
				
				if (!oldFile.equals("default.png")) {
					// delete
					Helper.deleteFile(oldPathFile);
				}
				
				if (Helper.saveFile(part.getInputStream(), oldPathFile)) {
					// out.println("Profile UPDATED");
					Message message = new Message("Profile details updated successfully", "success", "alert-success");
					session.setAttribute("msg", message);
				} else {
					Message message = new Message("Something went wrong", "error", "alert-danger");
					session.setAttribute("msg", message);
				}

			} else {
				// out.println("NOT UPDATED");
				Message message = new Message("Something went wrong", "error", "alert-danger");
				session.setAttribute("msg", message);
			}

			response.sendRedirect("profile.jsp");

			out.println("</body>");
			out.println("</html>");

		}

	}

	// <editor-fold defaultstate="collapsed" desc="HttpServlet methods. Click on the
	// + sign on the left to edit the code.">
	/**
	 * Handles the HTTP <code>GET</code> method.
	 *
	 * @param request  servlet request
	 * @param response servlet response
	 * @throws ServletException if a servlet-specific error occurs
	 * @throws IOException      if an I/O error occurs
	 */
	@Override
	protected void doGet(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		processRequest(request, response);
	}

	/**
	 * Handles the HTTP <code>POST</code> method.
	 *
	 * @param request  servlet request
	 * @param response servlet response
	 * @throws ServletException if a servlet-specific error occurs
	 * @throws IOException      if an I/O error occurs
	 */
	@Override
	protected void doPost(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		processRequest(request, response);
	}

	/**
	 * Returns a short description of the servlet.
	 *
	 * @return a String containing servlet description
	 */
	@Override
	public String getServletInfo() {
		return "Short description";
	}// </editor-fold>

}