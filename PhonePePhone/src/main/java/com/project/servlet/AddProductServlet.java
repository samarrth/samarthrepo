package com.project.servlet;


import java.io.FileOutputStream;
import java.io.IOException;
import java.io.InputStream;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.SQLException;

import javax.servlet.ServletException;
import javax.servlet.annotation.MultipartConfig;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.Part;

import project.Connection_Provider;

@MultipartConfig
@WebServlet("/addproduct")
public class AddProductServlet extends HttpServlet{
	@Override
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {

		String id = request.getParameter("id");
		String name = request.getParameter("pname");
		String details = request.getParameter("pdetails");
		String price = request.getParameter("pprice");
		String type = request.getParameter("ptype");
		Part imgPart = request.getPart("pimage");
		
		String imgFileName = imgPart.getSubmittedFileName();
		String uploadPath = "D:/project/PhonePePhone/src/main/webapp/images/"+ imgFileName;
		System.out.println(imgFileName);
		System.out.println(uploadPath);
		
		try {
		FileOutputStream outputStream = new FileOutputStream(uploadPath);
		InputStream inputStream = imgPart.getInputStream();
		
		byte[] bs = new byte[inputStream.available()];
		inputStream.read(bs);
		outputStream.write(bs);
		outputStream.close();
		inputStream.close();
		
		
		}catch(Exception e) {
			e.printStackTrace();
		}
		
		
		Connection con= null;
		PreparedStatement pstmt = null;
		try {
			con = Connection_Provider.getCon();
			pstmt = con.prepareStatement("insert into productdetails.details value(?,?,?,?,?,?)");
			pstmt.setString(1, id);
			pstmt.setString(2, name);
			pstmt.setString(3, details);
			pstmt.setString(4, price);
			pstmt.setString(5, type);
			pstmt.setString(6, imgFileName);
			int res = pstmt.executeUpdate();
			if(res >0) {
				response.sendRedirect("allProductandEditproduct.jsp?msg=done");
			}else {
				response.sendRedirect("product.jsp?msg=wrong");
			}
			
		} catch (Exception e) {
			System.out.println(e);
			response.sendRedirect("product.jsp?msg=wrong");
		}  
	}
}