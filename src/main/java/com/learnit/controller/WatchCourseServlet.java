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

@WebServlet("/WatchCourseServlet")
public class WatchCourseServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;

    public WatchCourseServlet() {
        super();
    }

	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		
	}

	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		try {
			String courseId = request.getParameter("course_id");
			String email = request.getParameter("email");

			DBConnect dbConnect = new DBConnect();
			Document courseData = dbConnect.retrieveCourseDataById(courseId, email);
			FindIterable<Document> lessonData = dbConnect.retriveLessonById(courseId);

			if (courseData == null && lessonData == null) {
				System.out.println("no course data & lesson data retrived");
			} else {
				System.out.println("course data found" + courseData + "lesson data found" + lessonData);
				request.setAttribute("courseData", courseData);
				request.setAttribute("lessonData", lessonData);
				RequestDispatcher dispatcher = request.getRequestDispatcher("WatchCourse.jsp");
				dispatcher.forward(request, response);
			}
		} catch (Exception e) {
			// Handle the exception, for example, log the error and show an error page to
			// the user.
			System.out.println("Error occurred: " + e);
			response.sendRedirect("error.jsp");
		}
	}

}
