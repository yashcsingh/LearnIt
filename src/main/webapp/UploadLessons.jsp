<%@page import="java.util.jar.Attributes.Name"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="com.mongodb.client.FindIterable" %>
<%@ page import="org.bson.Document" %>
<%@ page import="com.mongodb.client.MongoCursor" %>
<%@ page import="org.bson.types.ObjectId" %>

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<link rel="stylesheet" href="styles.css">
<link rel="stylesheet"
    href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.2/css/all.min.css"
    integrity="sha512-z3gLpd7yknf1YoNbCzqRKc4qyor8gaKU1qmn+CShxbuBusANI9QpRohGBreCFkKxLhei6S9CQXFEbbKuqLg0DA=="
    crossorigin="anonymous" referrerpolicy="no-referrer" />
<title>My Courses</title>
</head>
<body>
    <%
        String userEmail = (String) session.getAttribute("userEmail");
    	String courseId = (String) session.getAttribute("courseid");
		String courseName = (String) session.getAttribute("courseName");
        // Access other user-specific data if needed
        if(userEmail==null){
            response.sendRedirect("TLogin.jsp");
        }  
    %>
    
    <header style="padding-left: 50px; padding-right: 50px;">
        <img class="logo" src="Images\logo.png" alt="logo" style=" margin-left: 10px; margin-right: 10px;">
        <nav>
            <ul class="nav-links">
                <li><a href="Thome.jsp">Home</a></li>
                <li><a href="Upcourses.jsp">My Courses</a></li>
                <li><a href="#">Contact Us</a></li>
                <li><a href="#">About</a></li>
            </ul>
        </nav>
        <form action="TProfileinfo"><a class="cta" href="Tprofile.jsp"><button>Profile</button></a></form>
    </header>
    
<div style="text-align: center;">
	<form action="RetriveCourseByEmail" style="display: inline; margin: 7px;">
        <input type="submit" value="Load Course" style="padding: 5px 10px; font-size: 14px;">
    </form>
    
    <form action="UploadCourses.jsp" style="display: inline; margin: 7px;">
        <input type="submit" value="Add Course" style="padding: 5px 10px; font-size: 14px;">
    </form>

    <form action="UploadLessons.jsp" style="display: inline; margin: 7px;">
        <input type="submit" value="Add Lesson" style="padding: 5px 10px; font-size: 14px;">
    </form>
</div>

    <h2 align="center">Add Lessons</h2>
	<form action="RetriveCourseById" method="post">
		<label for="courseId">Enter Course ID:</label>
		<input type="text" name="courseId" placeholder="Enter ID" required>
		<input type="submit" value="Search">
	</form>

    <% 
        // Retrieve the course data from the request attribute
        Object userData = request.getAttribute("userData");
    	FindIterable<Document> lessonData = (FindIterable<Document>) request.getAttribute("lessonData");
        // Check if course data is available
    	if (userData != null) {
        	if (userData instanceof Document) {
            	// Cast userData to a Document
            	Document doc = (Document) userData;
            	String CName = doc.getString("courseName");
	%>
    	        <div>
        	        <h3>Course Name: <%= CName %> Course ID: <%= courseId %></h3>
            	</div>

				<%
				    if (lessonData != null) {
				        MongoCursor<Document> cursor = lessonData.iterator();
				        if (cursor.hasNext()) {
				%>
	<table style="margin: 20px; border-collapse: collapse; width: 80%;">
	    <thead>
	        <tr>
	            <th style="background-color: #f2f2f2; border: 1px solid #ccc; padding: 8px; text-align: left;">Ep.No.</th>
	            <th style="background-color: #f2f2f2; border: 1px solid #ccc; padding: 8px; text-align: left;">Ep. Title</th>
	            <th style="background-color: #f2f2f2; border: 1px solid #ccc; padding: 8px; text-align: left;">Video</th>
	            <th style="background-color: #f2f2f2; border: 1px solid #ccc; padding: 8px; text-align: left;">Notes</th>
	            <th style="background-color: #f2f2f2; border: 1px solid #ccc; padding: 8px; text-align: left;">Action</th>
	        </tr>
	    </thead>
	    <tbody>
	        <%
	            while (cursor.hasNext()) {
	                Document lesson = cursor.next();
	                ObjectId id = lesson.getObjectId("_id");
	                String epno = lesson.getString("epno");
	                String eptitle = lesson.getString("eptitle");
	                String vidpath = lesson.getString("relativePathvid");
	                String notespath = lesson.getString("relativePathpdf");
			%>
	        <tr>
	        	<td style="border: 1px solid #ccc; padding: 8px; text-align: left;"><%= epno %></td>   <!--.toHexString()-->
	            <td style="border: 1px solid #ccc; padding: 8px; text-align: left;"><%= eptitle %></td>
	            <td style="border: 1px solid #ccc; padding: 8px; text-align: left;">
	            	<video width="400" height="240" controls>
  					<source src="<%= vidpath %>" type="video/mp4">
					</video>
				</td>
	            <td style="border: 1px solid #ccc; padding: 8px; text-align: left;">
	            	<object data="<%= notespath %>" type="application/pdf" width="400" height="240" style="border: 1px solid #000;">
					<p>This browser does not support PDFs. Please download the PDF to view it: <a href="<%= notespath  %>">Download PDF</a></p>
					</object>
				</td>
	            <td style="border: 1px solid #ccc; padding: 8px; text-align: left;">
	            	<form method="post" action="UpdateLessonById" style="display: inline;">
	            		<input type="hidden" name="lessonId" value="<%= id %>">
	            		<button type="submit" style="background: none; border: box; cursor: pointer; padding: 5px 10px;"><i class="fas fa-pencil-alt"></i></button>
	            	</form>
	                <form method="post" action="DeleteLessonById"  style="display: inline;">
	                	<input type="hidden" name="lessonId" value="<%= id %>">
	                	<button type="submit" style="background: none; border: none; cursor: pointer; padding: 5px 10px;"><i class="fas fa-trash-alt"></i></button>
	                </form>
	            </td>
	        </tr>
	        <%
	            }
	        %>
	    </tbody>
	</table>
<%
        } else {
            out.println("No lesson data found.");
        }
    } else {
        out.println("No lesson data retrieved.");
    }
%>          	
            	
	<%
    	    } else {
	%>
    	        <p>No course data available.</p>
	<%
    	    }
    	} else {
	%>
	        <p>No course data available.</p>
	<%
	    }
	%>  
    
    <%
    	if(courseId!=null)
    	{
    %>

    <form action="AddLesson.jsp" style="display: inline; margin: 7px;">
    	<button type="submit" style="background-color: #FF0000; color: #000; border: 2px solid black; border-radius: 15%; cursor: pointer; padding: 15px 20px; position: fixed; right: 50px; bottom: 50px;">
    		<i class="fa fa-plus"></i>
    	</button>
    </form>
    
    <% 		
    	}
    
    %>
    
    
    <footer>
        <div class="footer-container">
            <div class="social-icons">
                <a href="#"><i class="fa-brands fa-facebook"></i></a> <a href="#"><i
                    class="fa-brands fa-instagram"></i></a> <a href="#"><i
                    class="fa-brands fa-twitter"></i></a> <a href="#"><i
                    class="fa-brands fa-youtube"></i></a>
            </div>
        </div>
        <div class="footer-bottom">
            <p>
                Copyright &copy;2023 Designed by <span class="designer">Yash
                    Singh</span>
            </p>
        </div>
    </footer>
</body>
</html>
