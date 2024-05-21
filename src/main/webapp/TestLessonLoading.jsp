<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ page import="org.bson.Document" %>
<%@ page import="com.mongodb.client.FindIterable" %>

<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Lesson Data</title>
</head> 
<body>
<h1>Lesson Data</h1>

<%
    // Get the lesson data from the request attribute
    FindIterable<Document> lessonData = (FindIterable<Document>) request.getAttribute("lessonData");

    if (lessonData != null) {
        %>
        <table border="1">
            <thead>
                <tr>
                    <th>Ep.No.</th>
                    <th>Ep. Title</th>
                    <th>Ep. Description</th>
                    <th>Video Path</th>
                    <th>PDF Path</th>
                </tr>
            </thead>
            <tbody>
                <%
                for (Document document : lessonData) {
                    String epno = document.getString("epno");
                    String eptitle = document.getString("eptitle");
                    String epdesc = document.getString("epdesc");
                    String relativePathvid = document.getString("relativePathvid");
                    String relativePathpdf = document.getString("relativePathpdf");
                    System.out.println(epno+eptitle);
                %>
                    <tr>
                        <td><%= epno %></td>
                        <td><%= eptitle %></td>
                        <td><%= epdesc %></td>
                        <td><%= relativePathvid %></td>
                        <td><%= relativePathpdf %></td>
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
%>
</body>
</html>
