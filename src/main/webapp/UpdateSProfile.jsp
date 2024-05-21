<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
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
    <title>LearnIt - Update Profile</title>
</head>
<body>
    <header style="padding-left: 50px; padding-right: 50px;">
		<img class="logo" src="Images\logo.png" alt="logo" style=" margin-left: 10px; margin-right: 10px;">
		<nav>
			<ul class="nav-links">
				<li><a href="#">Home</a></li>
				<li><a href="courses.jsp">Courses</a></li>
				<li><a href="#">Contact Us</a></li>
				<li><a href="#">About</a></li>
			</ul>
		</nav>
		<form action="Profileinfo"><a class="cta" href="profile.jsp"><button>Profile</button></a></form>
	</header>

	<%
        String userEmail = (String) session.getAttribute("userEmail");
        // Access other user-specific data if needed
        if(userEmail==null){
        	response.sendRedirect("login.html");
        }
    %>
    
    <h2 align="center">Update Profile</h2>

    <p>Welcome ${userEmail}!</p>

    <div class="content">
        <h3 align="center">Update Your Profile</h3>
        <form class="login-form" action="UpdateSProfile" method="post">
            <label for="firstName">First Name:</label>
            <input type="text" name="firstName" id="firstName" value=""><br>

            <label for="lastName">Last Name:</label>
            <input type="text" name="lastName" id="lastName" value=""><br>

            <input type="submit" value="Update Profile">
            <a href="changePassword.jsp">Change Password</a>
        </form>
    </div>

    <footer>
        <!-- Footer content goes here -->
    </footer>
</body>
</html>
