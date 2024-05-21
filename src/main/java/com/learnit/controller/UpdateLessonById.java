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

@WebServlet("/UpdateLessonById")
public class UpdateLessonById extends HttpServlet {
	private static final long serialVersionUID = 1L;

    public UpdateLessonById() {
        super();
    }

	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		
	}

	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
				// Get the session
				HttpSession session = request.getSession();

				// Retrieve the user's email from the session
				String userEmail = (String) session.getAttribute("userEmail");

				String lessonId = request.getParameter("lessonId");

				System.out.println("Lesson Id: " + lessonId + " UserEmail: " + userEmail);
				
				if (lessonId != null) {
					// Create an instance of DBConnect
					DBConnect dbConnect = new DBConnect();

					// Call the retrieveCourseDataById method to get the course data for the
					// specified ObjectId
					Document lessonData = dbConnect.retrieveLessonDataById(lessonId, userEmail);

					if (lessonData != null) {
						// Store the course data in a request attribute to make it available in the JSP
						// page
						request.setAttribute("lessonData", lessonData);
						// Forward the request to the same JSP page
						RequestDispatcher dispatcher = request.getRequestDispatcher("Updatelesson.jsp");
						dispatcher.forward(request, response);
					} else {
						// Set a message as an attribute
						System.out.println("no data found");
					}
				}
		doGet(request, response);
	}

}
