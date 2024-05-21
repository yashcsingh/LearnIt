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
<title>learnIt - Sign Up</title>
</head>
<body>
	<header style="padding-left: 50px; padding-right: 50px;">
		<img class="logo" src="Images/logo.png" alt="logo" style=" margin-left: 10px; margin-right: 10px;">
		<nav>
			<ul class="nav-links">
				<li><a href="index.jsp">Home</a></li>
				<li><a href="#">Courses</a></li>
				<li><a href="#">Contact Us</a></li>
				<li><a href="#">About</a></li>
			</ul>
		</nav>
		<a class="cta" href="TLogin.jsp"><button>Login</button></a>
	</header>
	
	<div class="content">
		<form class="login-form" action="Treg" method="POST">
			<h3 class="form-title">Instructor's Sign Up</h3>
			<p style="color: #8290a3;">Enter your personal details below:</p>
			<input class="form-control" type="text" placeholder="First Name" name="firstName" required> 
			<input class="form-control" type="text" placeholder="Last Name" name="lastName" required>
			<input class="form-control" type="email" placeholder="Email" name="email" required> 
			<input class="form-control" type="text" placeholder="Qualification" name="qualification" required> 
			<input class="form-control" type="password" placeholder="Password" name="password" required minlength="8">
			<input class="form-control" type="password" placeholder="Re-type Your Password" name="retypedPassword" required minlength="8">
			<div class="form-actions">
				<input type="checkbox" id="TandC" name="TandC" required> 
				<label style="color: #8290a3;" for="TandC"> By signing up, you agree to our 
					<span style="color: rgb(0, 135, 201);"> 
						<a href="#terms" style="text-decoration: none;">Terms</a>
					</span> and 
					<span style="color: rgb(0, 135, 201);"> 
						<a href="#privacyPolicy" style="text-decoration: none;">Privacy Policy &nbsp;</a>
					</span>
				</label>
			</div>
			<a class="cta" href="#"><button id="signupButton" disabled>Signup</button></a>
		</form>
	</div>
	
	<script>
        function validateForm() {
            var checkbox = document.getElementById("TandC");
            var signupButton = document.getElementById("signupButton");

            if (checkbox.checked) {
                // The checkbox is checked, allow form submission
                alert("Registration successful");
                return true;
            } else {
                // The checkbox is not checked, prevent form submission
                alert("Please agree to the Terms and Privacy Policy.");
                return false;
            }
        }

        // Add an event listener to enable the "Signup" button when the checkbox is checked
        document.getElementById("TandC").addEventListener("change", function () {
            var checkbox = document.getElementById("TandC");
            var signupButton = document.getElementById("signupButton");

            signupButton.disabled = !checkbox.checked;
        });
    </script>
	
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