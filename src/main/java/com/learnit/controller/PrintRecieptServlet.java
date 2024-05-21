package com.learnit.controller;

import com.codingerror.model.*;
import com.codingerror.service.CodingErrorPdfInvoiceCreator;

import com.learnit.db.DBConnect;

import java.io.IOException;
import javax.servlet.ServletException;
import javax.servlet.ServletOutputStream;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.bson.Document;

import java.util.ArrayList;
import java.util.List;
import java.time.LocalDate;
import java.time.format.DateTimeFormatter;

import java.io.*;

@WebServlet("/PrintRecieptServlet")
public class PrintRecieptServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;

    public PrintRecieptServlet() {
        super();
    }

	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		
	}

	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		System.out.println("Request received");
		DBConnect dbConnect = new DBConnect();
		
	    String orderId = request.getParameter("razorpayorderid");
	    
	    Document paymentInfo = dbConnect.RetrivePaymentInfo(orderId);
	    
			String cName = paymentInfo.getString("courseName");
			String price = paymentInfo.getString("DiscountedPrice");
			double priceinDouble = Double.parseDouble(price);
			String name = paymentInfo.getString("StudentName");
			
		
        String pdfName= "C:\\Users\\Yash\\eclipse-workspace\\Project_V_New\\src\\main\\webapp\\Invoice\\" + orderId + "_" + cName+ "_"+ name + ".pdf";
        CodingErrorPdfInvoiceCreator cepdf=new CodingErrorPdfInvoiceCreator(pdfName);
        cepdf.createDocument();

        //Create Header start
        HeaderDetails header=new HeaderDetails();
        header.setInvoiceNo("RK35623").setInvoiceDate(LocalDate.now().format(DateTimeFormatter.ofPattern("dd-MM-yyyy"))).build();
        cepdf.createHeader(header);
        //Header End

        //Create Address start
        AddressDetails addressDetails=new AddressDetails();
        addressDetails
                .setBillingCompany("LearnIt Inc.")
                .setBillingName("LearnIt Edu.")
                .setBillingAddress("Mumbai, Maharashtra \n India")
                .setBillingEmail("learnit@gmail.com")
                .setShippingName(name)
                .setShippingAddressText(" ")
                .setShippingAddress(" ")
                .build();

        cepdf.createAddress(addressDetails);
        //Address end

        //Product Start
        ProductTableHeader productTableHeader=new ProductTableHeader();
        productTableHeader.setQuantity(" ");
        cepdf.createTableHeader(productTableHeader);
        List<Product> productList=new ArrayList<>();
        productList.add(new Product(cName,1,(float) priceinDouble));
        productList=cepdf.modifyProductList(productList);
        cepdf.createProduct(productList);
        //Product End

        //Term and Condition Start
        List<String> TncList=new ArrayList<>();
        TncList.add("1. The Seller shall not be liable to the Buyer directly or indirectly for any loss or damage suffered by the Buyer.");
        TncList.add("2. The Seller warrants the product for one (1) year from the date of shipment");
        String imagePath="/Project_V_New/src/main/webapp/Images/logo.png";
        cepdf.createTnc(TncList,true,imagePath);
        // Term and condition end
        System.out.println("pdf genrated");

        // Set the content type and header fields for the response
        response.setContentType("application/pdf");
        //response.setHeader("Content-Disposition", "attachment; filename=\"" + pdfName + "\"");
        response.setHeader("Content-Disposition", "attachment; filename=\"" + orderId + "_" + cName + "_" + name + ".pdf\"");
        
        try {
            // Get the output stream of the response
            ServletOutputStream out = response.getOutputStream();
            
            // Read the PDF file and write it to the response output stream
            FileInputStream fis = new FileInputStream(pdfName);
            byte[] buffer = new byte[4096];
            int bytesRead;
            while ((bytesRead = fis.read(buffer)) != -1) {
                out.write(buffer, 0, bytesRead);
            }
            
            // Close the input stream and output stream
            fis.close();
            out.close();
        } catch (IOException e) {
            e.printStackTrace();
        }

        // Optional: You can delete the file after sending it
         File pdfFile = new File(pdfName);
         pdfFile.delete();

	}

}
