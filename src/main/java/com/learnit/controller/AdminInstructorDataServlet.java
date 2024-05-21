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

@WebServlet("/AdminInstructorDataServlet")
public class AdminInstructorDataServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;

	public AdminInstructorDataServlet() {
		super();
		// TODO Auto-generated constructor stub
	}

	protected void doGet(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		// dao
		DBConnect dbConnect = new DBConnect();

		FindIterable<Document> userData = dbConnect.retrieveAllInstructorsData();

		if (userData == null) {
			System.out.println("no user data retrived");
		} else {
			System.out.println("data found" + userData);
		}
		// Store the user data in a request attribute to make it available in the JSP
		// page
		request.setAttribute("userData", userData);

		// Forward the request to the JSP page
		RequestDispatcher dispatcher = request.getRequestDispatcher("adminInstructorsData.jsp");
		dispatcher.forward(request, response);
	}

	protected void doPost(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		// TODO Auto-generated method stub
		doGet(request, response);
	}

}
