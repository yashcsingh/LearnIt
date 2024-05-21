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

@WebServlet("/AdminCourseDataServlet")
public class AdminCourseDataServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;

	public AdminCourseDataServlet() {
		super();
		// TODO Auto-generated constructor stub
	}

	protected void doGet(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		// dao
		DBConnect dbConnect = new DBConnect();

		FindIterable<Document> courseData = dbConnect.retrieveAllCoursesData();

		if (courseData == null) {
			System.out.println("no user data retrived");
		} else {
			System.out.println("data found" + courseData);
		}
		// Store the user data in a request attribute to make it available in the JSP
		// page
		request.setAttribute("userData", courseData);

		// Forward the request to the JSP page
		RequestDispatcher dispatcher = request.getRequestDispatcher("adminCourseData.jsp");
		dispatcher.forward(request, response);
	}

	protected void doPost(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		// TODO Auto-generated method stub
		doGet(request, response);
	}

}
