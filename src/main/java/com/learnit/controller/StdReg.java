package com.learnit.controller;

import java.io.IOException;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.learnit.db.DBConnect;

@WebServlet("/StdReg")
public class StdReg extends HttpServlet {
	private static final long serialVersionUID = 1L;

	public StdReg() {
		super();
	}

	protected void doGet(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		response.getWriter().append("Served at: ").append(request.getContextPath());
	}

	protected void doPost(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		try {
			String firstName = request.getParameter("firstName");
			String lastName = request.getParameter("lastName");
			String email = request.getParameter("email");
			String password = request.getParameter("password");
			String retypedPassword = request.getParameter("retypedPassword");
			if(password!=retypedPassword) {
				response.getWriter().write("<script>alert('Passwords do not match. Please re-enter.')</script>");
				response.getWriter().write("<script>window.location.href = \"registration.html\";</script>");
			} else {
				DBConnect dbConnect = new DBConnect();
				dbConnect.sReg(firstName, lastName, email, password, retypedPassword);

				Thread.sleep(3000);
				// Redirect to a success page (e.g., home.html)
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
