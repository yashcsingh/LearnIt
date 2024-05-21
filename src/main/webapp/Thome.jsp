<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
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
<title>Welcome to LearnIt</title>
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
				<li><a href="#">Home</a></li>
				<li><a href="Upcourses.jsp">My Courses</a></li>
				<li><a href="#">Contact Us</a></li>
				<li><a href="#">About</a></li>
			</ul>
		</nav>
		<form action="TProfileinfo"><a class="cta" href="Tprofile.jsp"><button>Profile</button></a></form>
	</header>
	
	
	<p>Welcome ${userEmail}!</p>
	<form action="Logout">
   		<input type="Submit" value="Logout">
  	</form>
	
	
	
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