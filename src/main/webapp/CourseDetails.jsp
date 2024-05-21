<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="com.mongodb.client.FindIterable" %>
<%@ page import="org.bson.Document" %>
<%@ page import="com.mongodb.client.MongoCursor" %>
<%@ page import="org.bson.types.ObjectId" %> 
    
    
    
<!DOCTYPE html>
<html lang=en> 
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
<title>Welcome to LearnIt</title>
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

		Object userData = request.getAttribute("userData");
		Document courseData = (Document) request.getAttribute("courseData");
		FindIterable<Document> lessonData = (FindIterable<Document>) request.getAttribute("lessonData");
	
		if (courseData != null) {
			ObjectId id = courseData.getObjectId("_id");
			String email = courseData.getString("instructorEmail");
			String cName = courseData.getString("courseName");
			String cDescription = courseData.getString("courseDescription");
			String cDuration = courseData.getString("courseDuration");
			String cPrice = courseData.getString("coursePrice");
			String cDiscount = courseData.getString("discount");
			String imagepath = courseData.getString("courseImage");
			
			double originalPrice = Double.parseDouble(cPrice);
		    double discountPercentage = Double.parseDouble(cDiscount);
		    double discountedPrice = originalPrice - (originalPrice * discountPercentage / 100);
		    String discountedPriceAsString = "" + discountedPrice;
        %>
        	
        	
        	<div class="course-data-view" style="margin: 10px; display: flex; align-items: center; justify-content: space-between;">
			    <div style="display: flex; align-items: flex-start;">
			        <img src="<%= imagepath %>" style="max-width: 200px; margin-right: 20px;">
			        <div>
			            <h5 style="font-size: 18px; margin: 5px;">Course Name: <%= cName %></h5>
			            <p style="font-size: 16px; margin: 5px;">Description: <%= cDescription %></p>
			            <p style="font-size: 16px; margin: 5px">Duration: <%= cDuration %> Hours</p>
			            <p style="font-size: 16px; margin: 5px;">Original Price:<s>₹ <%= cPrice %></s> <b><big>₹<%= String.format("%.0f", discountedPrice) %></big></b>(<%= cDiscount %>% Discount)</p>
			        </div>
			    </div>
			    <form action="CheckOut" method="post">
			    	<input type="hidden" name="userEmail" value="<%= userEmail %>">
			    	<input type="hidden" name="course_id" value="<%= id %>">
		        	<input type="hidden" name="price" value="<%= discountedPriceAsString %>">
			    	<button style="font-size: 16px; padding: 5px 10px; background-color: #007bff; color: #fff; border: none; cursor: pointer;">Buy Now</button>
				</form>		
			</div>

        	
        	
	<%
		} else {
        out.println("No course data retrieved.");
    	}
		if (lessonData != null) {
			MongoCursor<Document> cursor = lessonData.iterator();
			if (cursor.hasNext()) {
	%>
	<table style="margin: 20px; border-collapse: collapse; width: 80%;">
	    <thead>
	        <tr>
	            <th style="background-color: #f2f2f2; border: 1px solid #ccc; padding: 8px; text-align: left;">Ep.No.</th>
	            <th style="background-color: #f2f2f2; border: 1px solid #ccc; padding: 8px; text-align: left;">Ep. Title</th>
	        </tr>
	    </thead>
	    <tbody>
		<%
			while (cursor.hasNext()) {
		        Document lesson = cursor.next();
	            ObjectId id = lesson.getObjectId("_id");
                String epno = lesson.getString("epno");
				String eptitle = lesson.getString("eptitle");
		%>
			<tr>
	        	<td style="border: 1px solid #ccc; padding: 8px; text-align: left;"><%= epno %></td>   <!--.toHexString()-->
	            <td style="border: 1px solid #ccc; padding: 8px; text-align: left;"><%= eptitle %></td>
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
					<li><a href="#">Home</a></li>
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