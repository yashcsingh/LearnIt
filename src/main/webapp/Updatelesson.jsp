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
<title>Update Courses</title>
</head>
<body>
    <%
        String userEmail = (String) session.getAttribute("userEmail");
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

	<%
		Document lessonData = (Document) request.getAttribute("lessonData"); // Corrected the type
	
		// Check if courseData is not null
		if (lessonData != null) {
			ObjectId id = lessonData.getObjectId("_id");
		    String courseName = lessonData.getString("courseName");
		    String epno = lessonData.getString("epno");
		    String eptitle = lessonData.getString("eptitle");
		    String epdesc = lessonData.getString("epdesc");
		    String relativePathvid = lessonData.getString("relativePathvid");
		    String relativePathpdf = lessonData.getString("relativePathpdf");
    %>
    
    <h2 align="center">Update Lesson</h2>
	<form action="UpdateLesson" method="post" enctype="multipart/form-data">
	    <table align="center" border="0">
	        <tr>
	            <td><label for="LessonID">Lesson ID:</label></td>
	            <td><input type="text" name="id" value="<%= id %>" readonly></td>
	        </tr>
	        <tr>
	            <td><label for="courseName">Course Name:</label></td>
	            <td><input type="text" name="courseName" value="<%= courseName %>" readonly></td>
	        </tr>
	        <tr>
	            <td><label for="epno">Episode Number:</label></td>
	            <td><input type="text" name="epno" value="<%= epno %>" readonly></td>
	        </tr>
	        <tr>
	            <td><label for="eptitle">Episode Title:</label></td>
	            <td><input type="text" name="eptitle" value="<%= eptitle %>" required></td>
	        </tr>
	        <tr>
	            <td><label for="epdesc">Episode Description:</label></td>
	            <td><textarea name="epdesc" rows="2" required><%= epdesc %></textarea></td>
	        </tr>
	        <tr>
                <td><label for="lessonVideo">Ep. Video:</label></td>
                <td><input type="file" name="lessonVideo" accept="video/*" value="" required></td>
                <td>
        			<video src="<%= relativePathvid %>" style="max-width: 200px; max-height: 200px;">Lesson Video</video>
    			</td>
            </tr>
	       	<tr>
                <td><label for="lessonNotes">Notes:</label></td>
                <td><input type="file" name="lessonNotes" accept=".pdf" value="" required></td>
                <td>
        			<object data="<%= relativePathpdf %>" type="application/pdf" width="200" height="200" style="border: 1px solid #000;"></object>
    			</td>
            </tr>
	        <tr>
	            <td colspan="2" align="center"><button type="submit">Update Lesson</button></td>
	        </tr>
	    </table>
	</form>
    
<%
	} else {
	    out.println("No course data found.yash");
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
