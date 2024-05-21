package com.learnit.controller;

import java.io.IOException;
import java.util.List;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import org.bson.Document;

import com.learnit.db.DBConnect;
import com.mongodb.client.FindIterable;

@WebServlet("/TestLessonLoading")
public class TestLessonLoading extends HttpServlet {
	private static final long serialVersionUID = 1L;

	public TestLessonLoading() {
		super();
	}

	protected void doGet(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {

		// Retrieve the user's email from the session
		String courseId = request.getParameter("courseid");

		DBConnect dbConnect = new DBConnect();

		FindIterable<Document> lessonData = dbConnect.getAllLessonData(courseId);

		if (lessonData == null) {
			System.out.println("no user data retrived");
		} else {
			System.out.println("data found" + lessonData);
		}

		// Store the user data in a request attribute to make it available in the JSP
		// page
		request.setAttribute("lessonData", lessonData);

		// Forward the request to the JSP page
		RequestDispatcher dispatcher = request.getRequestDispatcher("TestLessonLoading.jsp");
		dispatcher.forward(request, response);
	}

	protected void doPost(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
	}

}
