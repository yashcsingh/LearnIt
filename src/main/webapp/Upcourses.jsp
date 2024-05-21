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
    
    <style>
    	table {
            width: 100%;
            border-collapse: collapse;
        }

        table, th, td {
            border: 1px solid #ccc;
        }

        th, td {
            padding: 8px;
            text-align: left;
        }
    </style>
    
<title>My Courses</title>
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


    
    <h2 align="center">Your Course</h2>


<%
    FindIterable<Document> courseData = (FindIterable<Document>) request.getAttribute("courseData");

    if (courseData != null) {
        MongoCursor<Document> cursor = courseData.iterator();

        if (cursor.hasNext()) {
%>
	<table border="1">
    <thead>
        <tr>
            <th>ID</th>
            <th>Course-Name</th>
            <th>Duration</th>
            <th>MRP</th>
            <th>Discount</th>
        </tr>
    </thead>
    <tbody>
        <%
            while (cursor.hasNext()) {
                Document course = cursor.next();
                ObjectId id = course.getObjectId("_id");
                String email = course.getString("instructorEmail");
                String cName = course.getString("courseName");
                String cDuration = course.getString("courseDuration");
                String cPrice = course.getString("coursePrice");
                String cDiscount = course.getString("discount");
        %>
        <tr>
        	<td><%= id %></td>   <!--.toHexString()-->
            <td><%= cName %></td>
            <td><%= cDuration %></td>
            <td><%= cPrice %></td>
            <td><%= cDiscount %></td>
            <td>
            	<form method="post" action="UpdateCourseById" style="display: inline;">
            		<input type="hidden" name="course_id" value="<%= id %>">
            		<button type="submit" style="background: none; border: box; cursor: pointer; padding: 5px 10px;"><i class="fas fa-pencil-alt"></i></button>
            	</form>
                <form method="post" action="DeleteCourseById"  style="display: inline;">
                	<input type="hidden" name="course_id" value="<%= id %>">
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
            out.println("No course data found.");
        }
    } else {
        out.println("No course data retrieved.");
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
