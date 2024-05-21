package com.learnit.controller;

import java.io.IOException;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.learnit.db.DBConnect;

@WebServlet("/DeleteLessonById")
public class DeleteLessonById extends HttpServlet {
	private static final long serialVersionUID = 1L;

    public DeleteLessonById() {
        super();
    }

	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		
	}

	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {

		try {
			String lessonId = request.getParameter("lessonId");

			DBConnect dbConnect = new DBConnect();
			boolean delsucc = dbConnect.DeleteLessonById(lessonId);

			if (delsucc) {
				response.sendRedirect("UploadLessons.jsp");
			} else {
				System.out.println("Unable to delete");

				response.sendRedirect("adminLogin.jsp");

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
