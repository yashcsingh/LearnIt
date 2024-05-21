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

@WebServlet("/UpdateSProfile")
public class UpdateSProfile extends HttpServlet {
	private static final long serialVersionUID = 1L;

	public UpdateSProfile() {
		super();
	}

	protected void doGet(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {

		// Get the session
		HttpSession session = request.getSession();

		// Retrieve the user's email from the session
		String userEmail = (String) session.getAttribute("userEmail");

		// dao
		DBConnect dbConnect = new DBConnect();

		// Retrieve user inputs from the update profile form
		String firstName = request.getParameter("firstName");
		String lastName = request.getParameter("lastName");

		// pass the data to database and update
		FindIterable<Document> userData = dbConnect.updateUserData(userEmail, firstName, lastName);

		// Store the user data in a request attribute to make it available in the JSP
		// page
		request.setAttribute("userData", userData);

		// Forward the request to the JSP page
		RequestDispatcher dispatcher = request.getRequestDispatcher("profile.jsp");
		dispatcher.forward(request, response);

	}

	protected void doPost(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		// TODO Auto-generated method stub
		doGet(request, response);
	}

}
