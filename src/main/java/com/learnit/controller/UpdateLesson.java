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

@WebServlet("/UpdateLesson")
@MultipartConfig(location = "D:\\UploadedCourseFiles", fileSizeThreshold = 1024 * 1024 * 1024, // close to 1024MB
maxFileSize = -1, // No maximum file size limit
maxRequestSize = -1 // No maximum request size limit
)
public class UpdateLesson extends HttpServlet {
	private static final long serialVersionUID = 1L;

    public UpdateLesson() {
        super();
    }

	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		
	}

	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		// Get the session
				HttpSession session = request.getSession();
				// Retrieve the user's email from the session
				String userEmail = (String) session.getAttribute("userEmail");

				// Retrieve course data
				String courseId = request.getParameter("id");
				String courseName = request.getParameter("courseName");
				String epno = request.getParameter("epno");
				String eptitle = request.getParameter("eptitle");
				String epdesc = request.getParameter("epdesc");
				
				String videoLocation = "C:\\Users\\Yash\\eclipse-workspace\\Project_V_New\\src\\main\\webapp\\UploadedCourseFiles\\Lessonfiles";
				String pdfLocation = "C:\\Users\\Yash\\eclipse-workspace\\Project_V_New\\src\\main\\webapp\\UploadedCourseFiles\\Lessonfiles";

				String videoMessage = "";
				String pdfMessage = "";

				String relativePathpdf = "";
				String relativePathvid = "";

				String message = "";
				try {
					String videoFolderPath = videoLocation + File.separator + userEmail + "_" + courseName;
					File videoFolder = new File(videoFolderPath);
					if (!videoFolder.exists()) {
						videoFolder.mkdirs();
					}

					String pdfFolderPath = pdfLocation + File.separator + userEmail + "_" + courseName;
					File pdfFolder = new File(pdfFolderPath);
					if (!pdfFolder.exists()) {
						pdfFolder.mkdirs();
					}

					Part videoPart = request.getPart("lessonVideo");
					String videoFileName = getFileName(videoPart);
					if (videoFileName != null) {
						String fileExtension = videoFileName.substring(videoFileName.lastIndexOf('.'));
						videoFileName = userEmail + "_" + courseName + "_" + epno + "_video" + fileExtension;
						relativePathvid = "UploadedCourseFiles\\Lessonfiles" + File.separator + userEmail + "_" + courseName
								+ File.separator + videoFileName;
						String videoPath = videoFolderPath + File.separator + videoFileName;
						videoPart.write(videoPath);
					}

					Part pdfPart = request.getPart("lessonNotes");
					String pdfFileName = getFileName(pdfPart);
					if (pdfFileName != null) {
						String fileExtension = pdfFileName.substring(pdfFileName.lastIndexOf('.'));
						pdfFileName = userEmail + "_" + courseName + "_" + epno + "_pdf" + fileExtension;
						relativePathpdf = "UploadedCourseFiles\\Lessonfiles" + File.separator + userEmail + "_" + courseName
								+ File.separator + pdfFileName;
						String pdfPath = pdfFolderPath + File.separator + pdfFileName;
						pdfPart.write(pdfPath);
					}

					// Now, you can store the file paths in the database if needed
					DBConnect dbConnect = new DBConnect();
					dbConnect.UpdateLesson(courseId, userEmail, courseName, epno, eptitle, epdesc, relativePathvid,
							relativePathpdf); // Updated variables

				} catch (Exception e) {
					// Handle exceptions here
					e.printStackTrace();
				}

				response.sendRedirect("UploadLessons.jsp");
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
