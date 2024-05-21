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

<style>
    .video-and-table-container {
        display: flex;
        width: 100%;
    }

    .watch-video {
        width: 70%;
        justify-content: center;
    	align-items: center; 
        
    }

    .lesson-table {
        width: 30%;
        margin: 10px;
    }
    
    .down-notes-and-book-session{
    	display: flex;
        width: 70%;
        justify-content: space-between;
        align-items: center;
    }
    
    .down-notes {
    	flex: 1; 
	}

	.book-session {
    	margin-right: 10px; 
    	justify-content: center;
    	align-items: center; 
	}
	.book-session-button {
	    font-size: 16px; /* Adjust the font size as needed */
	    background-color: #007BFF; /* Change the background color */
	    color: #fff; /* Text color */
	    border: none;
	    padding: 10px 20px; /* Adjust padding as needed */
	    border-radius: 5px; /* Rounded corners */
	    cursor: pointer;
	    transition: background-color 0.3s;
	}
	
	.book-session-button:hover {
	    background-color: #0056b3; /* Darker background color on hover */
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
        <div class="video-and-table-container">
        	<div class="watch-video">
        		<video id="lesson-video" src="" controls style="width: 100%;"></video>
        	</div>	
        	
	<%
	if (lessonData != null) {
		MongoCursor<Document> cursor = lessonData.iterator();
		if (cursor.hasNext()) {
	%>
			<div class="lesson-table">
				<table style="border-collapse: collapse; width: 100%;">
				    <thead>
				        <tr>
				            <th style="background-color: #f2f2f2; border: 1px solid #ccc; padding: 8px; text-align: left;">Lesson</th>
				        </tr>
				    </thead>
				    <tbody>
					<%
						while (cursor.hasNext()) {
					        Document lesson = cursor.next();
			                String epno = lesson.getString("epno");
							String eptitle = lesson.getString("eptitle");
							String epvidpath = lesson.getString("relativePathvid");
							String epnotespath = lesson.getString("relativePathpdf");
							epvidpath = epvidpath.replace("\\", "/");
							epnotespath = epnotespath.replace("\\", "/");
					%>
						<tr>
				            <td style="border: 1px solid #ccc; padding: 8px; text-align: left;">
								<a href="javascript:void(0);" onclick="loadVideoAndNotes('<%= epvidpath %>', '<%= epnotespath %>')"><%= epno %>. <%= eptitle %></a>
							</td>
				        </tr>
					<%
						}
					%>
				 	</tbody>
				</table>
			</div>
		</div>
		<div class="down-notes-and-book-session">
			<div class="down-notes">
				<h4>Download Notes: <a id="download-notes-link" href="" target="_blank">Download PDF</a></h4>
			</div>
			<div class="book-session">
				<form action="BookAppointmentServlet" method="post">
					<input type="submit" value="Book Doubt Session" class="book-session-button">
				</form>
			</div>
		</div>
		<script>
		    function loadVideoAndNotes(videoSrc, notesSrc) {
		    	console.log("Loading video with src: " + videoSrc);
		        var videoElement = document.getElementById('lesson-video');
		        console.log("Video element: ", videoElement); 
		        videoElement.src = videoSrc;
		        videoElement.load();
		        
		        var downloadNotesLink = document.getElementById('download-notes-link');
		        downloadNotesLink.href = notesSrc;
		    }
		</script>
	<%
        } else {
            out.println("No lesson data found.");
        }
    } else {
        out.println("No lesson data retrieved.");
    }
	%>       
        	
        	
        	        	
        	<div class="course-data-view" style="margin: 10px; display: flex; align-items: center; justify-content: space-between;">
			    <div style="display: flex; align-items: flex-start;">
			        <!-- <img src="<%= imagepath %>" style="max-width: 200px; margin-right: 20px;">  -->
			        <div>
			            <h5 style="font-size: 18px; margin: 5px;">Course Name: <%= cName %></h5>
			            <p style="font-size: 16px; margin: 5px;">Description: <%= cDescription %></p>
			            <p style="font-size: 16px; margin: 5px">Duration: <%= cDuration %> Hours</p>
			         </div>
			    </div>	
			</div>
   	
	<%
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