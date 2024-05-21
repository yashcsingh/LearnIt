package com.learnit.controller;

import java.io.IOException;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import com.learnit.db.DBConnect;

@WebServlet("/DeleteCourseById")
public class DeleteCourseById extends HttpServlet {
	private static final long serialVersionUID = 1L;

	public DeleteCourseById() {
		super();
		// TODO Auto-generated constructor stub
	}

	protected void doGet(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		// TODO Auto-generated method stub
		// response.getWriter().append("Served at: ").append(request.getContextPath());
	}

	protected void doPost(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {

		try {
			String course_id = request.getParameter("course_id");

			DBConnect dbConnect = new DBConnect();
			boolean delsucc = dbConnect.DeleteCourseById(course_id);

			if (delsucc) {
				response.sendRedirect("Upcourses.jsp");
			} else {
				System.out.println("incorrect password");

				response.sendRedirect("adminLogin.jsp");

			}
		} catch (Exception e) {
			// Handle the exception, for example, log the error and show an error page to
			// the user.
			System.out.println("Error occurred: " + e);
			response.sendRedirect("error.html");
		}

		doGet(request, response);
	}

}
