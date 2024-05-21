package com.learnit.controller;

import java.io.File;
import java.io.IOException;
import javax.servlet.ServletException;
import javax.servlet.annotation.MultipartConfig;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import javax.servlet.http.Part;

import com.learnit.db.DBConnect;

@WebServlet("/UpdateCourse")
@MultipartConfig(location = "D:\\UploadedCourseFiles", fileSizeThreshold = 1024 * 1024 * 1024, // close to 1024MB
maxFileSize = -1, // No maximum file size limit
maxRequestSize = -1 // No maximum request size limit
)
public class UpdateCourse extends HttpServlet {
	private static final long serialVersionUID = 1L;

	public UpdateCourse() {
		super();
		// TODO Auto-generated constructor stub
	}

	protected void doGet(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		// TODO Auto-generated method stub
		response.getWriter().append("Served at: ").append(request.getContextPath());
	}

	protected void doPost(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {

		// Get the session
		HttpSession session = request.getSession();
		// Retrieve the user's email from the session
		String userEmail = (String) session.getAttribute("userEmail");

		// Retrieve course data
		String courseId = request.getParameter("course_id");
		System.out.println(courseId + "This is the course Id");
		String courseName = request.getParameter("playlistName");
		System.out.println(courseName);
		String courseDescription = request.getParameter("courseDescription");
		String courseDuration = request.getParameter("courseDuration");
		String coursePrice = request.getParameter("coursePrice");
		String discount = request.getParameter("discount");
		String locationValue = "C:\\Users\\Yash\\eclipse-workspace\\Project_V_New\\src\\main\\webapp\\UploadedCourseFiles\\CourseImg";

		String message = "";

		try {
			String folderPath = locationValue + File.separator + userEmail + "_" + courseName;
			File folder = new File(folderPath);
			if (!folder.exists()) {
				folder.mkdirs(); // Create the folder if it doesn't exist
			}

			// Get the course image Part
			Part courseImagePart = request.getPart("courseImage");
			String courseImageFileName = getFileName(courseImagePart);

			if (courseImageFileName != null) {
				String fileExtension = courseImageFileName.substring(courseImageFileName.lastIndexOf('.'));
				courseImageFileName = userEmail + "_" + courseName + "_image" + fileExtension;
				String relativePath = "UploadedCourseFiles\\CourseImg" + File.separator + userEmail + "_" + courseName
						+ File.separator + courseImageFileName;
				String imagePath = folderPath + File.separator + courseImageFileName;
				courseImagePart.write(imagePath);

				// Your DBConnect code here to store the course data and image path in the
				// database
				DBConnect dbConnect = new DBConnect();
				dbConnect.UpdateCourse(courseId, courseName, courseDescription, courseDuration, coursePrice, discount,
						relativePath);
			}

		} catch (Exception e) {
			message = "File upload failed: " + e.getMessage();
		}
		response.sendRedirect("Upcourses.jsp");
	}

	private String getFileName(Part part) {
		String contentDisposition = part.getHeader("content-disposition");

		if (!contentDisposition.contains("filename=")) {
			return null;
		}

		int beginIndex = contentDisposition.indexOf("filename=") + 10;
		int endIndex = contentDisposition.length() - 1;
		return contentDisposition.substring(beginIndex, endIndex);
	}
}
