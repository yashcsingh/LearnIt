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
    <title>Admin Panel</title>
    <style>
    
    	#header {
		    position: fixed;
		    top: 0;
		    left: 0;
		    width: 100%;
		    background-color: #333;
		    color: white;
		    padding: 5px 0;
		    text-align: center;
		    z-index: 1; /* Ensure it's above other content */
		}
    	
    	
        body {
            font-family: Arial, sans-serif;
            margin: 0;
            padding: 0;
            background-color: #f2f2f2;
        }

        header {
            background-color: #333;
            color: white;
            padding: 5px 0;
            text-align: center;
        }

        nav {
            background-color: #444;
            color: white;
            width: 150px;
            padding: 20px 10px;
            position: fixed;
            height: 100%;
            top: 75px;
        }

        nav ul {
            list-style-type: none;
            padding: 0;
        }

        nav li {
            margin: 10px 0;
        }

        nav a {
            text-decoration: none;
            color: white;
        }

        .content {
            margin-left: 200px;
            padding: 20px;
        }

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

        tr:nth-child(even) {
            background-color: #f2f2f2;
        }

        .button {
            display: inline-block;
            width: 24px;
            height: 24px;
            background-color: #337ab7;
            color: white;
            text-align: center;
            font-size: 16px;
            border: none;
            cursor: pointer;
        }

        .button:hover {
            background-color: #235a99;
        }
    </style>
</head>
<body>
    <header id="header">
        <h2>AdminPanel - Learnit</h2>
    </header>

    <nav>
        <ul>
            <li><a href="AdminStudentDataServlet">Students</a></li>
            <li><a href="AdminInstructorDataServlet">Instructors</a></li>
            <li><a href="AdminCourseDataServlet">Courses</a></li>
            <li><a href="#">Logout</a></li>
        </ul>
    </nav>

    <div class="content">
        <h3 style="margin-top: 85px;">Course Data</h3>
<%
    FindIterable<Document> instructorData = (FindIterable<Document>) request.getAttribute("userData");

    if (instructorData != null) {
        MongoCursor<Document> cursor = instructorData.iterator();

        if (cursor.hasNext()) {
%>
<table>
    <thead>
        <tr>
            <th>ID</th>
            <th>Email</th>
            <th>Course-Name</th>
            <th>Duration</th>
            <th>MRP</th>
            <th>Discount</th>
        </tr>
    </thead>
    <tbody>
        <%
            while (cursor.hasNext()) {
                Document instructor = cursor.next();
                ObjectId id = instructor.getObjectId("_id");
                String email = instructor.getString("instructorEmail");
                String cName = instructor.getString("courseName");
                String cDuration = instructor.getString("courseDuration");
                String cPrice = instructor.getString("coursePrice");
                String cDiscount = instructor.getString("discount");
        %>
        <tr>
        	<td><%= id %></td>   <!--.toHexString()-->
            <td><%= email %></td>
            <td><%= cName %></td>
            <td><%= cDuration %></td>
            <td><%= cPrice %></td>
            <td><%= cDiscount %></td>
            <td>
            	<button class="button" title="Update">U</button>
                <button class="button" title="Delete">D</button>
            </td>
        </tr>
        <%
            }
        %>
    </tbody>
</table>
<%
        } else {
            out.println("No instructor data found.");
        }
    } else {
        out.println("No instructor data retrieved.");
    }
%>
    </div>
</body>
</html>
