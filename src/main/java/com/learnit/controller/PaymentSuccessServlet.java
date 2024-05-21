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

import com.codingerror.model.Product;
import com.learnit.db.DBConnect;
import java.time.LocalDateTime;
import java.time.format.DateTimeFormatter;
import java.util.ArrayList;
import java.util.List;

@WebServlet("/PaymentSuccessServlet")
public class PaymentSuccessServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;

    public PaymentSuccessServlet() {
        super();
        // TODO Auto-generated constructor stub
    }

	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		
	}

	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		DBConnect dbConnect = new DBConnect();
		
		String paymentId = request.getParameter("razorpay_payment_id");
	    String orderId = request.getParameter("razorpay_order_id");
	    String signature = request.getParameter("razorpay_signature");
	    
	    System.out.println("Payment ID: " + paymentId);
	    System.out.println("orderId :" + orderId);
	    System.out.println("signature: " + signature);
	    
	    // Get the current date and time
	    LocalDateTime currentDateTime = LocalDateTime.now();

	    // Define a custom date and time format
	    DateTimeFormatter formatter = DateTimeFormatter.ofPattern("yyyy-MM-dd HH:mm:ss");

	    // Format the current date and time as a string
	    String formattedDateTime = currentDateTime.format(formatter);
	    
	    dbConnect.UpdatePaymentInfo(orderId, paymentId, formattedDateTime);
	    
	    Document paymentInfo = dbConnect.RetrivePaymentInfo(orderId);
		
	    request.setAttribute("paymentInfo", paymentInfo);
	    RequestDispatcher dispatcher = request.getRequestDispatcher("SuccessfulPayment.jsp");
		dispatcher.forward(request, response);
	}

}
