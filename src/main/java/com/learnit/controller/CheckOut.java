package com.learnit.controller;

import java.io.IOException;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.bson.Document;
import org.bson.types.ObjectId;

import com.learnit.db.DBConnect;

import com.razorpay.RazorpayClient;
import com.razorpay.Order;
import org.json.JSONObject;

@WebServlet("/CheckOut")
public class CheckOut extends HttpServlet {
	private static final long serialVersionUID = 1L;

	public CheckOut() {
		super();
	}

	protected void doGet(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {

	}

	protected void doPost(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		try {
			String courseId = request.getParameter("course_id");
			String email = request.getParameter("userEmail");
			String price = request.getParameter("price");
			
			DBConnect dbConnect = new DBConnect();
			Document courseData = dbConnect.retrieveCourseDataById(courseId);
			Document stdData = dbConnect.retriveUserDataByEmail(email);
	
			if (courseData != null && stdData != null) {
				ObjectId cId = courseData.getObjectId("_id");
				String Instructoremail = courseData.getString("instructorEmail");
				String cName = courseData.getString("courseName");
				String cPrice = courseData.getString("coursePrice");
				String cDiscount = courseData.getString("discount");
				
				ObjectId stdId = stdData.getObjectId("_id");
				String fName = stdData.getString("FirstName");
				String LName = stdData.getString("LastName");
				String Name = fName + "_" + LName; 
				
				RazorpayClient razorpay = new RazorpayClient("rzp_test_p35m7G8SlMZ8cs", "5FGPtaJyBIwDLzNobq3a05ug");
				
				double discountedPrice = Double.parseDouble(price);
			    	
				int priceInRupeesInt = (int) discountedPrice; // Convert the double to an integer
				
				JSONObject orderRequest = new JSONObject();
			    orderRequest.put("amount", priceInRupeesInt * 100); // Amount in paise
			    orderRequest.put("currency", "INR");
			    orderRequest.put("receipt", "order_rcptid_11");
			
			    Order order = razorpay.orders.create(orderRequest);
			    System.out.println(order);
			    
			    String status = null;
			    String razorpayOrderId = order.get("id").toString();
			    if(razorpayOrderId != null) {
			    	status = "created";
			    }
			    
			    String orderID = String.format("OID%07d", new java.util.Random().nextInt(10000000));
			    
			    
			    //Storing the Payment Record in the Payment_Info collection
				dbConnect.PaymentInfo(orderID, razorpayOrderId, stdId, Name, email, cId, cName, cPrice, cDiscount, price, status);
			    
			    request.setAttribute("orderId", orderID);
				request.setAttribute("razorpayOrderId", razorpayOrderId);
				request.setAttribute("courseData", courseData);
				request.setAttribute("stdData", stdData);
				request.setAttribute("price", price);
				request.setAttribute("userEmail", email);
				RequestDispatcher dispatcher = request.getRequestDispatcher("checkout.jsp");
				dispatcher.forward(request, response);
			} else {
				System.out.println("Unable to retrive course data.");
			}
		} catch (Exception e) {
			// Handle the exception, for example, log the error and show an error page to
			// the user.
			System.out.println("Error occurred: " + e);
			response.sendRedirect("error.jsp");
		}
	}

}
