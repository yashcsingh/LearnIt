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

@WebServlet("/StdLogin")
public class StdLogin extends HttpServlet {
	private static final long serialVersionUID = 1L;

	public StdLogin() {
		super();
	}

	protected void doGet(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
	}

	protected void doPost(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		try {
			String email = request.getParameter("email");
			String password = request.getParameter("password");

			DBConnect dbConnect = new DBConnect();
			boolean loginSuccess = dbConnect.sLogin(email, password);

			FindIterable<Document> courseData = dbConnect.retrieveCourseData();

			if (courseData == null) {
				System.out.println("no course data retrived");
			} else {
				System.out.println("data found" + courseData);
			}

			if (loginSuccess) {

				// Assuming the user is successfully authenticated
				HttpSession session = request.getSession();
				session.setAttribute("userEmail", email); // Store user's email in the session

				// Store the user data in a request attribute to make it available in the JSP
				// page
				request.setAttribute("courseData", courseData);

				System.out.println("loginsuccessfull");

				RequestDispatcher dispatcher = request.getRequestDispatcher("home.jsp");
				dispatcher.forward(request, response);
			} else {
				System.out.println("incorrect password");

				response.sendRedirect("login.html");

			}
		} catch (Exception e) {
			// Handle the exception, for example, log the error and show an error page to
			// the user.
			System.out.println("Error occurred: " + e);
			response.sendRedirect("error.html");
		}
	}
}
