package com.learnit.controller;

import java.io.IOException;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.bson.Document;

import com.learnit.db.DBConnect;

@WebServlet("/UpdateCourseById")
public class UpdateCourseById extends HttpServlet {
	private static final long serialVersionUID = 1L;

	public UpdateCourseById() {
		super();
		// TODO Auto-generated constructor stub
	}

	protected void doGet(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
	}

	protected void doPost(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		// Get the session
		HttpSession session = request.getSession();

		// Retrieve the user's email from the session
		String userEmail = (String) session.getAttribute("userEmail");

		String courseId = request.getParameter("course_id");

		if (courseId != null) {
			// Create an instance of DBConnect
			DBConnect dbConnect = new DBConnect();

			// Call the retrieveCourseDataById method to get the course data for the
			// specified ObjectId
			Document courseData = dbConnect.retrieveCourseDataById(courseId, userEmail);

			// Inside the doGet method of RetriveCourseById servlet
			if (courseData != null) {
				// Store the course data in a request attribute to make it available in the JSP
				// page
				request.setAttribute("userData", courseData);
				// Forward the request to the same JSP page
				RequestDispatcher dispatcher = request.getRequestDispatcher("UpdateCourse.jsp");
				dispatcher.forward(request, response);
			} else {
				// Set a message as an attribute
				System.out.println("no data found");
			}
		}
		doGet(request, response);
	}

}
