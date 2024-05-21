package com.learnit.controller;

import java.io.IOException;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.bson.Document;

import com.learnit.db.DBConnect;
import com.mongodb.client.FindIterable;

@WebServlet("/AllCourses")
public class AllCourses extends HttpServlet {
	private static final long serialVersionUID = 1L;

	public AllCourses() {
		super();
	}

	protected void doGet(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		try {
			DBConnect dbConnect = new DBConnect();

			FindIterable<Document> courseData = dbConnect.retrieveCourseData();

			if (courseData == null) {
				System.out.println("no course data retrived");
			} else {
				// Store the user data in a request attribute to make it available in the JSP
				// page
				request.setAttribute("courseData", courseData);
				System.out.println("data found" + courseData);
				RequestDispatcher dispatcher = request.getRequestDispatcher("courses.jsp");
				dispatcher.forward(request, response);
			}
		} catch (Exception e) {
			// Handle the exception, for example, log the error and show an error page to
			// the user.
			System.out.println("Error occurred: " + e);
			response.sendRedirect("error.html");
		}
	}

	protected void doPost(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
	}

}
