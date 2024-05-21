<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    
<%@ page import="com.mongodb.client.FindIterable" %>
<%@ page import="org.bson.Document" %>
<%@ page import="com.mongodb.client.MongoCursor" %>
<%@ page import="org.bson.types.ObjectId" %> 


<!DOCTYPE html>
<html lang="en"> 
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
    <link rel="stylesheet" href="styles.css">
<link rel="stylesheet"
	href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.2/css/all.min.css"
	integrity="sha512-z3gLpd7yknf1YoNbCzqRKc4qyor8gaKU1qmn+CShxbuBusANI9QpRohGBreCFkKxLhei6S9CQXFEbbKuqLg0DA=="
	crossorigin="anonymous" referrerpolicy="no-referrer" />
	
	
	<style type="text/css"> 
	/* Define styles for the course grid container */
	.course-grid {
	    display: flex;
	    flex-wrap: wrap;
	    justify-content: center;
	    padding-left: 100px;
	    margin: 15px; /* Add some margin to space the cards */
	}
	
	/* Define styles for each card */
	.card {
	    width: calc(33.33% - 20px);
	    height: 400px;
	    border: 1px solid #ccc;
	    margin: 500px;
	    box-shadow: 0 4px 8px 0 rgba(0,0,0,0.2);
	   	overflow: hidden; /* Hide overflowing content */
	}

	</style>
	
	
	
    <title>LearnIt - Profile</title>
</head>
<body>
	<header style="padding-left: 50px; padding-right: 50px;">
		<img class="logo" src="Images/logo.png" alt="logo" style=" margin-left: 10px; margin-right: 10px;">
		<nav>
			<ul class="nav-links">
				<li><a href="home.jsp">Home</a></li>
				<li><a href="AllCourses">Courses</a></li>
				<li><a href="#">Contact Us</a></li>
				<li><a href="#">About</a></li>
			</ul>
		</nav>
		<form action="Logout"><a class="cta" href="login.html"><button>Logout</button></a></form>
	</header>
	
	<%
        String userEmail = (String) session.getAttribute("userEmail");
        // Access other user-specific data if needed
        if(userEmail==null){
        	response.sendRedirect("login.html");
        }
	%>
	
<nav style="width: 150px; background-color: #fff; position: fixed; height: 100%; overflow: auto; border-right: 1px solid #eee;">
    <ul style="list-style-type: none; padding: 0;">
        <li style="text-align: left; padding: 10px 20px;">
            <a href="Profileinfo" style="text-decoration: none; color: #333; display: block;">Profile Info</a>
        </li>
        <li style="text-align: left; padding: 10px 20px;">
            <a href="stdCourses" style="text-decoration: none; color: #333; display: block;">Courses</a>
        </li>
        <li style="text-align: left; padding: 10px 20px;">
            <a href="#" style="text-decoration: none; color: #333; display: block;">Feedback</a>
        </li>
        <li style="text-align: left; padding: 10px 20px;">
            <a href="#" style="text-decoration: none; color: #333; display: block;">Appointment</a>
        </li>
    </ul>
</nav>
	
    <%    
        FindIterable<Document> userData = (FindIterable<Document>) request.getAttribute("userData");
        FindIterable<Document> courseData = (FindIterable<Document>) request.getAttribute("courseData");
        
        if (userData != null) {
            for (Document userDocument : userData) {
                String firstName = userDocument.getString("FirstName");
                String lastName = userDocument.getString("LastName");
                String email = userDocument.getString("Email");
                // Process and display data
                
                %>
	<div class="content">
        <h3 align="center">User Profile</h3>
        <p align="center">Welcome to your profile page. Here are your details:</p>
        <table>
            <tr>
                <th>First Name:</th>
                <td><%= firstName %></td>
            </tr>
            <tr>
                <th>Last Name:</th>
                <td><%= lastName %></td>
            </tr>
            <tr>
                <th>Email:</th>
                <td><%= email %></td>
            </tr>
            <tr>
                <th></th>
                <td></td>
            </tr>
            <tr>
                <td><a class="cta" href="UpdateSProfile.jsp"><button>Update Profile</button></a></td>
                <td><form action="#"><a class="cta" href="#"><button>Change Password</button></a></form></td>
            </tr>
        </table>
    </div>
    <%    
            }
        } else if (courseData != null) {
        	    MongoCursor<Document> cursor = courseData.iterator();
        	
        	    if (cursor.hasNext()) {
	%>
        	        <div class="course-grid">
        		<%
                    while (cursor.hasNext()) {
                        Document course = cursor.next();
                        ObjectId id = course.getObjectId("_id");
                        String email = course.getString("instructorEmail");
                        String cName = course.getString("courseName");
                        String cDescription = course.getString("courseDescription");
                        String cPrice = course.getString("coursePrice");
                        String cDiscount = course.getString("discount");
                        String imagepath = course.getString("courseImage");
                        System.out.println(imagepath);
                %>
        			<div class="card" style="width: 17rem; border: 1px solid #ccc; margin: 10px; box-shadow: 0 4px 8px 0 rgba(0,0,0,0.2); position: relative; display: flex; flex-direction: column;">
        		    <img src="<%= imagepath %>" alt="Card image cap" style="max-width: 100%; max-height: 240px">
        		    <div class="card-body" style="padding: 20px;">
        		        <h5 class="card-title" style="font-size: 20px; font-weight: bold; clear: both; margin: 0px; margin-left: 5px;"><%= cName %></h5>
        		        <p class="card-text" style="font-size: 16px; clear: both; margin-top: 10px; margin-bottom: 0px;"><%= cDescription %></p>
        		    </div>
        		        <form method="post" action="WatchCourseServlet">
        		        	<input type="hidden" name="course_id" value="<%= id %>">
        		        	<input type="hidden" name="email" value="<%= email %>">
        		        	<button style="background-color: #007bff; color: #fff; text-decoration: none; padding: 10px 20px; font-size: 16px; position: absolute; bottom: 5px; right: 5px;">Start Learning</button>
        		        </form>

        		</div>

         		<%
                    }
                %>
                    </div>
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
			<div class="footer-nav">
				<ul>
					<li><a href="home.jsp">Home</a></li>
					<li><a href="#">Courses</a></li>
					<li><a href="#">Contact Us</a></li>
					<li><a href="#">About</a></li>
				</ul>
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