<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<link rel="stylesheet" href="styles.css">
<link rel="stylesheet"
	href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.2/css/all.min.css"
	integrity="sha512-z3gLpd7yknf1YoNbCzqRKc4qyor8gaKU1qmn+CShxbuBusANI9QpRohGBreCFkKxLhei6S9CQXFEbbKuqLg0DA=="
	crossorigin="anonymous" referrerpolicy="no-referrer" />
<title>learnIt - Login</title>
</head>
<body>
	<header style="padding-left: 50px; padding-right: 50px;">
		<img class="logo" src="Images/logo.png" alt="logo" style=" margin-left: 10px; margin-right: 10px;">
		<nav>
			<ul class="nav-links">
				<li><a href="index.html">Home</a></li>
				<li><a href="courses.jsp">Courses</a></li>
				<li><a href="#">Contact Us</a></li>
				<li><a href="#">About</a></li>
			</ul>
		</nav>
		<a class="cta" href="Treg.jsp"><button>Sign up</button></a>
	</header>
	
	<div class="content">
		<form class="login-form" action="TLogin" method="POST">
			<h3 class="form-title">Instructors's Sign In</h3>
			<input class="form-control" type="email" placeholder="Email" name="email" required> 
			<input class="form-control" type="password" placeholder="Password" name="password" required minlength="8">
			<div class="form-actions" style="width: 400px;">
				<a class="cta" href="login.html"><button>Login</button></a>
				<a class="forget-password" href="#forgetPassword" style="display: block;">Forget Password?</a>

			</div>
			<p>
				Don't have an Account? <a href="Treg.jsp">Signup</a>
			</p>
		</form>
	</div>
	
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
					<li><a href="index.html">Home</a></li>
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