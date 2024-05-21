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

/**
 * Servlet implementation class RetriveCourseByEmail
 */
@WebServlet("/RetriveCourseByEmail")
public class RetriveCourseByEmail extends HttpServlet {
	private static final long serialVersionUID = 1L;

	public RetriveCourseByEmail() {
		super();
		// TODO Auto-generated constructor stub
	}

	protected void doGet(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		// Get the session
		HttpSession session = request.getSession();

		// Retrieve the user's email from the session
		String userEmail = (String) session.getAttribute("userEmail");

		DBConnect dbConnect = new DBConnect();

		FindIterable<Document> courseData = dbConnect.retrieveCourseData(userEmail);

		if (courseData == null) {
			System.out.println("no user data retrived");
		} else {
			System.out.println("data found" + courseData);
		}

		// Store the user data in a request attribute to make it available in the JSP
		// page
		request.setAttribute("courseData", courseData);

		// Forward the request to the JSP page
		RequestDispatcher dispatcher = request.getRequestDispatcher("Upcourses.jsp");
		dispatcher.forward(request, response);

	}

	protected void doPost(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		// TODO Auto-generated method stub
		doGet(request, response);
	}

}
