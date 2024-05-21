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

<script src="https://checkout.razorpay.com/v1/checkout.js"></script>


<style>
    .checkout-info {
        background-color: #f4f4f4; /* Off white background color */
        border: 1px solid #ccc; /* Border for the box */
        border-radius: 10px; /* Rounded corners */
        padding: 20px; /* Add padding inside the box */
        width: 60%; /* Set the width of the box */
        margin: 0 auto; /* Center the box horizontally */
        text-align: center; /* Center the content inside the box */
    }
    .info {
        margin-bottom: 10px; /* Add spacing between each label and its content */
        text-align: center; /* Align labels and content to the center*/
    }
</style>

<title>CheckOut</title>
</head>
<body>
    <h1 align="center">Payment Page</h1>

	<%
        String userEmail = (String) session.getAttribute("userEmail");
        // Access other user-specific data if needed
        if(userEmail==null){
        	response.sendRedirect("login.html");
        }

		Document courseData = (Document) request.getAttribute("courseData");
		Document stdData = (Document) request.getAttribute("stdData");
		String customerEmail = (String) request.getAttribute("userEmail");
		String coursePrice = (String) request.getAttribute("price");
		
	
		if (courseData != null && stdData != null) {
			ObjectId cId = courseData.getObjectId("_id");
			String email = courseData.getString("instructorEmail");
			String cName = courseData.getString("courseName");
			String cDescription = courseData.getString("courseDescription");
			String cDuration = courseData.getString("courseDuration");
			String cPrice = courseData.getString("coursePrice");
			String cDiscount = courseData.getString("discount");
			String imagepath = courseData.getString("courseImage");
			
			ObjectId stdId = stdData.getObjectId("_id");
			String fName = stdData.getString("FirstName");
			String LName = stdData.getString("LastName");
			String Name = fName + "_" + LName; 

			double originalPrice = Double.parseDouble(cPrice);
		    double discountPercentage = Double.parseDouble(cDiscount);
		    double discountedPrice = originalPrice - (originalPrice * discountPercentage / 100);
		    String discountedPriceAsString = String.format("%.0f", discountedPrice);
		    	
			int priceInRupeesInt = (int) discountedPrice; // Convert the double to an integer
		
			String orderID = (String) request.getAttribute("orderId");
			
		    String razorpayOrderId = (String) request.getAttribute("razorpayOrderId");
		
	%>
          
     <script>
    
     var amount = <%= priceInRupeesInt * 100 %>;
     var cName = "<%= cName %>";
     var Name = "<%= Name %>";
     var customerEmail = "<%= customerEmail %>";
     var razorpayOrderId = "<%= razorpayOrderId %>";
     
     </script>   
       
<div class="checkout-info">
	<form>
        <!-- Customer Information -->
        <h2>Customer Information</h2>
        <div class="info">
        <label for="name">Name:</label>
        <label><b><%= Name %></b></label>
        <input type="hidden" name="customerName" value="<%= Name %>">
        </div>
        
        <div class="info">
        <label for="email">Email:</label>
        <label for="email"><b><%= customerEmail %></b></label>
        <input type="hidden" name="customerEmail" value="<%= customerEmail %>">
        <input type="hidden" name="stdId" value="<%= stdId %>">
        </div>

        <!-- Course Information -->
        <h2>Course Information</h2>
        <div class="info">
        <label for="cName">Course Name:</label>
        <label for="cName"><b><%= cName %></b></label>
        <input type="hidden" name="courseName" value="<%= cName %>">
        <input type="hidden" name="cId" value="<%= cId %>">
        </div>
        
        <div class="info">
        <label for="cPrice">Price:</label>
        <label for="cPrice"><b>₹<%= discountedPriceAsString %></b></label>
        <input type="hidden" name="discountedPriceInString" value="<%= discountedPriceAsString %>">
		</div>
		
		<!-- Order summary -->
		<h2>Order Summary</h2>
		<div class="info">
        <label for="OID">Order ID:</label>
        <label for="OID"><b><%= orderID %></b></label>
        <input type="hidden" name="orderID" value="<%= orderID %>">
		</div>

        <!-- Submit Button -->
        <input type="submit" id="rzp-button1" value="Pay Now" style="padding: 10px 20px; font-size: 16px; background-color: #007bff; color: #fff; border: none; border-radius: 5px; cursor: pointer;">
	</form>
</div>   
    <%
		}
    %>
    
    
    
 	<script>
    var options = {
        "key": "rzp_test_p35m7G8SlMZ8cs",
        "amount": amount,
        "currency": "INR",
        "name": "LearnIt Corp.",
        "description": "Course" + cName,
        "image": "https://ibb.co/9YVHPT0",
        "order_id": razorpayOrderId,
        "callback_url": "PaymentSuccessServlet",
        "prefill": {
            "name": Name,
            "email": customerEmail,
            "contact": ""
        },
        "notes": {
            "address": "Razorpay Corporate Office"
        },
        "theme": {
            "color": "#3399cc"
        }
    };
    var rzp1 = new Razorpay(options);
    document.getElementById('rzp-button1').onclick = function(e){
        rzp1.open();
        e.preventDefault();
    }
	</script>   
</body>
</html>