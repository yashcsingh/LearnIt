<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
 
<%@ page import="com.mongodb.client.FindIterable" %>
<%@ page import="org.bson.Document" %>
<%@ page import="com.mongodb.client.MongoCursor" %>

 
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
            padding: 10px 0;
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
            margin-left: 270px;
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
    <header  id="header">
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
        <h3 style="margin-top: 85px;">Student Data</h3>
<%-- Check if userData is not null --%>
<% 
    FindIterable<Document> userData = (FindIterable<Document>) request.getAttribute("userData");

    if (userData != null) {
        MongoCursor<Document> cursor = userData.iterator();

        if (cursor.hasNext()) {
%>
<table>
    <thead>
        <tr>
            <th>First Name</th>
            <th>Last Name</th>
            <th>Email</th>
            <th>Password</th>
            <th>Action</th>
        </tr>
    </thead>
    <tbody>
        <%
            while (cursor.hasNext()) {
                Document student = cursor.next();
                String firstName = student.getString("FirstName");
                String lastName = student.getString("LastName");
                String email = student.getString("Email");
                String password = student.getString("Password");
        %>
        <tr>
            <td><%= firstName %></td>
            <td><%= lastName %></td>
            <td><%= email %></td>
            <td><%= password %></td>
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
            // Handle the case where no data is retrieved
            out.println("No user data found.");
        }
    } else {
        // Handle the case where userData is null
        out.println("No user data retrieved.");
    }
%>

    </div>
</body>
</html>
