package com.learnit.controller;

import org.json.JSONObject;

import com.learnit.db.DBConnect;
import com.razorpay.Order;
import com.razorpay.RazorpayClient;

import java.io.IOException;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

@WebServlet("/payservlet")
public class payservlet extends HttpServlet {
	private static final long serialVersionUID = 1L;

    public payservlet() {
        super();
    }

	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		
	}

	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
//		try {
//			RazorpayClient razorpay = new RazorpayClient("rzp_test_p35m7G8SlMZ8cs", "5FGPtaJyBIwDLzNobq3a05ug");
//			
//			String courseId = request.getParameter("cId");
//			String customerEmail = request.getParameter("customerEmail");
//			String price = request.getParameter("discountedPriceInString");
//			double priceInRupees = Double.parseDouble(price); // Parse the price as a double
//			int priceInRupeesInt = (int) priceInRupees; // Convert the double to an integer
//
//			JSONObject orderRequest = new JSONObject();
//		    orderRequest.put("amount", priceInRupeesInt * 100); // Amount in paise
//		    orderRequest.put("currency", "INR");
//		    orderRequest.put("receipt", "order_rcptid_11");
//
//		    Order order = razorpay.orders.create(orderRequest);
//		    System.out.println(order);
//		    String razorpayOrderId = order.get("id").toString();
//
//		} catch (Exception e) {
//			// Handle the exception, for example, log the error and show an error page to
//			// the user.
//			System.out.println("Error occurred: " + e);
//			response.sendRedirect("error.jsp");
//		}
	}

}
