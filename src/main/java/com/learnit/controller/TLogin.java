package com.learnit.controller;

import java.io.IOException;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import com.learnit.db.DBConnect;

@WebServlet("/TLogin")
public class TLogin extends HttpServlet {
	private static final long serialVersionUID = 1L;

	public TLogin() {
		super();
	}

	protected void doGet(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		response.getWriter().append("Served at: ").append(request.getContextPath());
	}

	protected void doPost(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		try {
			String email = request.getParameter("email");
			String password = request.getParameter("password");

			DBConnect dbConnect = new DBConnect();
			boolean loginSuccess = dbConnect.TLogin(email, password);

			if (loginSuccess) {

				// Assuming the user is successfully authenticated
				HttpSession session = request.getSession();
				session.setAttribute("userEmail", email); // Store user's email in the session

				// Redirect to a success page (e.g., home.html)
				response.sendRedirect("Thome.jsp");
			} else {
				System.out.println("incorrect password");

				// Show an alert on the current page
				response.getWriter().write("<script>alert('Incorrect Password');window.history.back();</script>");

				response.sendRedirect("TLogin.jsp");

			}
		} catch (Exception e) {
			// Handle the exception, for example, log the error and show an error page to
			// the user.
			System.out.println("Error occurred: " + e);
			response.sendRedirect("error.html");
		}

		doGet(request, response);
	}

}
