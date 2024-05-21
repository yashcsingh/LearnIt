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
<title>Upload Courses</title>
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
	
    <form action="#" style="display: inline; margin: 7px;">
        <input type="submit" value="Add Course" style="padding: 5px 10px; font-size: 14px;">
    </form>

    <form action="UploadLessons.jsp" style="display: inline; margin: 7px;">
        <input type="submit" value="Add Lesson" style="padding: 5px 10px; font-size: 14px;">
    </form>

</div>


    
    <h2 align="center">Add New Course</h2>
    <form action="UploadCourse" method="post" enctype="multipart/form-data">
        <table align="center" border="0">
            <tr>
                <td><label for="playlistName">Course Name:</label></td>
                <td><input type="text" name="playlistName" required></td>
            </tr>
            <tr>
                <td><label for="courseDescription">Course Description:</label></td>
                <td><textarea name="courseDescription" rows="2" required></textarea></td>
            </tr>
            <tr>
                <td><label for="courseDuration">Course Duration (in hours):</label></td>
                <td><input type="number" name="courseDuration" required></td>
            </tr>
            <tr>
                <td><label for="coursePrice">Course Price:</label></td>
                <td><input type="number" name="coursePrice" required></td>
            </tr>
            <tr>
                <td><label for="discount">Discount (%):</label></td>
                <td><input type="number" name="discount" required></td>
            </tr>
            <tr>
                <td><label for="courseImage">Course Image:</label></td>
                <td><input type="file" name="courseImage" accept="image/*" required></td>
            </tr>
            <tr>
                <td  colspan="2" align="center"><button type="submit">Add Course</button></td>
            </tr>
        </table>
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
