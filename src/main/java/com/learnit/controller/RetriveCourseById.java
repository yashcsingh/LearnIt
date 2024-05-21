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
import com.mongodb.client.FindIterable;

@WebServlet("/RetriveCourseById")
public class RetriveCourseById extends HttpServlet {
	private static final long serialVersionUID = 1L;

	public RetriveCourseById() {
		super();
		// TODO Auto-generated constructor stub
	}

	protected void doGet(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		// Get the session
		HttpSession session = request.getSession();

		// Retrieve the user's email from the session
		String userEmail = (String) session.getAttribute("userEmail");

		// Get the ObjectId from the frontend (assuming it's passed as a request
		// parameter)
		String courseId = request.getParameter("courseId");

		if (courseId != null) {
			// Create an instance of DBConnect
			DBConnect dbConnect = new DBConnect();

			// Call the retrieveCourseDataById method to get the course data for the
			// specified ObjectId
			Document courseData = dbConnect.retrieveCourseDataById(courseId, userEmail);

			// Call the retriveLessonById method to retrive lesson data
			FindIterable<Document> lessonData = dbConnect.retriveLessonById(courseId);
			for (Document document : lessonData) {
				System.out.println(document.toJson());
			}

			// Inside the doGet method of RetriveCourseById servlet
			if (courseData != null && lessonData != null) {
				// Store the course data & lesson data in a request attribute to make it
				// available in the JSP page
				request.setAttribute("userData", courseData);
				request.setAttribute("lessonData", lessonData);

				// set data to session
				session.setAttribute("courseid", courseId);
				Document doc = (Document) courseData;
				session.setAttribute("courseName", doc.getString("courseName"));

				// Forward the request to the same JSP page
				RequestDispatcher dispatcher = request.getRequestDispatcher("UploadLessons.jsp");
				dispatcher.forward(request, response);
			} else {
				// Set a message as an attribute
				request.setAttribute("errorMessage", "No data found for ObjectId: " + courseId);
				// Forward the request to the same JSP page
				RequestDispatcher dispatcher = request.getRequestDispatcher("UploadLessons.jsp");
				dispatcher.forward(request, response);
			}

		}

	}

	protected void doPost(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		// TODO Auto-generated method stub
		doGet(request, response);
	}

}
