package com.learnit.controller;

import java.io.IOException;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

@WebServlet("/InstructorAppointmentServlet")
public class InstructorAppointmentServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;

    public InstructorAppointmentServlet() {
        super();
    }

	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		String appointmentData="yash";
		request.setAttribute("appointmentData", appointmentData);
		RequestDispatcher dispatcher = request.getRequestDispatcher("Tprofile.jsp");
		dispatcher.forward(request, response);
	}

	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		
	}

}
