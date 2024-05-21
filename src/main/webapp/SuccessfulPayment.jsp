<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="com.mongodb.client.FindIterable" %>
<%@ page import="org.bson.Document" %>
<%@ page import="com.mongodb.client.MongoCursor" %>
<%@ page import="org.bson.types.ObjectId" %> 
<%@ page import="java.util.Random" %>   
<%@ page import="com.razorpay.RazorpayClient" %>
<%@ page import="com.razorpay.Order" %>
<%@ page import="org.json.JSONObject" %>
    
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">

    <style>
        body {
            font-family: Arial, sans-serif;
            background-color: #f5f5f5;
            text-align: center;
            margin: 0;
            padding: 0;
        }

        h3 {
            color: #333;
        }

        p {
            font-size: 18px;
            color: #555;
            max-width: 600px;
            margin: 0 auto;
        }

        form {
            margin-top: 20px;
        }

        input[type="button"] {
            background-color: #007bff;
            color: #fff;
            padding: 10px 20px;
            border: none;
            cursor: pointer;
        }

        input[type="submit"] {
            background-color: #28a745;
            color: #fff;
            padding: 10px 20px;
            border: none;
            cursor: pointer;
        }

        input[type="button"]:hover,
        input[type="submit"]:hover {
            background-color: #0056b3;
        }

        /* Add more styles as needed */
    </style>

<title>LearnIt - Payment Successful</title>
</head>
<body>
	<%
	String userEmail = (String) session.getAttribute("userEmail");
    // Access other user-specific data if needed
    if(userEmail==null){
    	response.sendRedirect("login.html");
    }

	Document paymentInfo = (Document) request.getAttribute("paymentInfo");
	
	if(paymentInfo != null){
		String cName = paymentInfo.getString("courseName");
		String price = paymentInfo.getString("DiscountedPrice");
		String razorpayOrderid = paymentInfo.getString("razorpayId");
	%>
	<h3>Payment Successful</h3>
	<p>Your payment of <b>₹<%= price %></b> for the Course <b><%= cName %></b> is completed click the button below to view the course.</p>
	<form action="Profileinfo" method="post">
		<input type="submit" value="Click Here">
	</form>
	<br>
	<form action="PrintRecieptServlet" method="post">
		<input type="hidden" name="razorpayorderid" value="<%= razorpayOrderid %>"> 
		<input type="submit" value="Download Reciept">
	</form>
	<%
	} else {
	%>
	<p>Info not found</p>
	<%
	}
	%>
</body>
</html>