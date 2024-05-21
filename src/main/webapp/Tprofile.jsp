<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    
<%@ page import="com.mongodb.client.FindIterable" %>
<%@ page import="org.bson.Document" %>


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
	
	<!-- Include jQuery library -->
    <script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
    <!-- Include jQuery UI library -->
    <link rel="stylesheet" href="https://code.jquery.com/ui/1.12.1/themes/base/jquery-ui.css">
    <script src="https://code.jquery.com/ui/1.12.1/jquery-ui.js"></script>
    <!-- Include date range picker library -->
    <script src="https://cdn.jsdelivr.net/momentjs/latest/moment.min.js"></script>
    <script src="https://cdn.jsdelivr.net/npm/daterangepicker/daterangepicker.js"></script>
    <link rel="stylesheet" type="text/css" href="https://cdn.jsdelivr.net/npm/daterangepicker/daterangepicker.css">
    <!-- Include timepicker.js library -->
    <script src="https://cdnjs.cloudflare.com/ajax/libs/timepicker/1.3.5/jquery.timepicker.min.js"></script>
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/timepicker/1.3.5/jquery.timepicker.min.css">
	
    <title>LearnIt - Profile</title>
</head>
<body>
	<header style="padding-left: 50px; padding-right: 50px;">
		<img class="logo" src="Images/logo.png" alt="logo" style=" margin-left: 10px; margin-right: 10px;">
		<nav>
			<ul class="nav-links">
				<li><a href="Thome.jsp">Home</a></li>
				<li><a href="Upcourses.jsp">My Courses</a></li>
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
        	response.sendRedirect("TLogin.jsp");
        }
     %>
     
     
    <nav style="width: 150px; background-color: #fff; position: fixed; height: 100%; overflow: auto; border-right: 1px solid #eee;">
	   	<ul style="list-style-type: none; padding: 0;">
	        <li style="text-align: left; padding: 10px 20px;">
	            <a href="TProfileinfo" style="text-decoration: none; color: #333; display: block;">Profile Info</a>
	        </li>
	        <li style="text-align: left; padding: 10px 20px;">
	            <a href="#" style="text-decoration: none; color: #333; display: block;">Enrolled Students</a>
	        </li>
	        <li style="text-align: left; padding: 10px 20px;">
	            <a href="#" style="text-decoration: none; color: #333; display: block;">Feedback</a>
	        </li>
	        <li style="text-align: left; padding: 10px 20px;">
	            <a href="InstructorAppointmentServlet" style="text-decoration: none; color: #333; display: block;">Appointment</a>
	        </li>
	    </ul>
	</nav>
     
     
     	<%   
        FindIterable<Document> userData = (FindIterable<Document>) request.getAttribute("userData");
     	String appointmentData = (String) request.getAttribute("appointmentData");
        
        if (userData != null) {
            for (Document userDocument : userData) {
                String firstName = userDocument.getString("FirstName");
                String lastName = userDocument.getString("LastName");
                String email = userDocument.getString("Email");
                String qualification = userDocument.getString("Qualification");
		%>
             <div class="content">
		        <h3>Instructor's Profile</h3>
		        <p>Welcome to your profile page. Here are your details:</p>
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
		                <th>Qualification:</th>
		                <td><%= qualification %></td>
		            </tr>
		        </table>
		    </div>
    <%    
            }
        } else if(appointmentData != null){
    %>
    	
    	
    	
    	<div style="text-align: center;">
			<form action="" style="display: inline; margin: 7px;">
		        <input type="submit" value="Schedule Appointment" style="padding: 5px 10px; font-size: 14px;">
		    </form>
		    
		    <form action="#" style="display: inline; margin: 7px;">
		        <input type="submit" value="View Appointment" style="padding: 5px 10px; font-size: 14px;">
		    </form>
		</div>
		
		
	<table style="border-collapse: collapse; width: 80%; margin-left:200px; margin-right:200px;margin-top:50px">
        <thead>
            <tr>
                <th style="border: 1px solid black; padding: 8px; text-align: center; background-color: #f2f2f2;">Student ID</th>
                <th style="border: 1px solid black; padding: 8px; text-align: center; background-color: #f2f2f2;">Student Name</th>
                <th style="border: 1px solid black; padding: 8px; text-align: center; background-color: #f2f2f2;">Course</th>
                <th style="border: 1px solid black; padding: 8px; text-align: center; background-color: #f2f2f2;">Appointment Date</th>
                <th style="border: 1px solid black; padding: 8px; text-align: center; background-color: #f2f2f2;">Appointment Time</th>
                <th style="border: 1px solid black; padding: 8px; text-align: center; background-color: #f2f2f2;">Action</th>
            </tr>
        </thead>
        <tbody>
            <tr>
                <td style="border: 1px solid black; padding: 8px; text-align: center;">1</td>
                <td style="border: 1px solid black; padding: 8px; text-align: center;">John Doe</td>
                <td style="border: 1px solid black; padding: 8px; text-align: center;">Mathematics</td>
                <td style="border: 1px solid black; padding: 8px; text-align: center;">2023-11-15</td>
                <td style="border: 1px solid black; padding: 8px; text-align: center;">10:00 AM</td>
                <td style="border: 1px solid black; padding: 8px; text-align: center;">
                    <button style="background-color: #4CAF50; color: white; border: none; padding: 8px 12px; cursor: pointer;" onclick="sendEmail('john@example.com')">Send Email</button>
                </td>
        </tbody>
    </table>
    
    
    
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