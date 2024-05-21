package com.learnit.controller;

import java.io.IOException;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import java.util.*;

import org.bson.Document;
import org.bson.types.ObjectId;

import com.learnit.db.DBConnect;
import com.mongodb.client.FindIterable;
import com.mongodb.client.MongoCursor;

@WebServlet("/stdCourses")
public class stdCourses extends HttpServlet {
	private static final long serialVersionUID = 1L;

    public stdCourses() {
        super();
    }

	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		HttpSession session = request.getSession();
		String stdEmail = (String) session.getAttribute("userEmail");
		System.out.println("Student Email to retrive purchased courses: " + stdEmail);
		
		DBConnect dbConnect = new DBConnect();
		
		List<ObjectId> courseIds = new ArrayList<>();

		System.out.println("data to be retrived executed now : ");
		FindIterable<Document> AllPaymentData = dbConnect.retrieveAllUserPaymentData(stdEmail);
		if (AllPaymentData != null) {
			System.out.println("AllPaymentData IS NOT NULL");
			MongoCursor<Document> cursor = AllPaymentData.iterator();
			if (cursor.hasNext()) {
				while (cursor.hasNext()) {
			        Document lesson = cursor.next();
		            ObjectId id = lesson.getObjectId("courseId");
		            //System.out.println("CourseId of courses purchased by student is: " + id);
		            courseIds.add(id);
					} 
			} else {
				System.out.println("No LESSON data");
			}
		} else {
			System.out.println("AllPaymentData IS NULL");
		}

// TO PRINT THE LIST OF COURSE-ID'S		
//		if (!courseIds.isEmpty()) {
//		    System.out.print("The course IDs in the list are: ");
//		    for (ObjectId courseId : courseIds) {
//		        System.out.print(courseId + " ");
//		    }
//		    System.out.println(); // Move to the next line
//		} else {
//		    System.out.println(courseIds.isEmpty() ? "No course IDs in the list." : "No LESSON data");
//		}
		
		FindIterable<Document> courseData = dbConnect. RetrieveCourseDataById(courseIds);
		
		
		request.setAttribute("courseIds", courseIds);
		request.setAttribute("courseData", courseData);
		RequestDispatcher dispatcher = request.getRequestDispatcher("profile.jsp");
		dispatcher.forward(request, response);
		
		
	}

	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		doGet(request, response);
	}

}
