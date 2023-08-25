package com.project.servlet;

import java.io.FileOutputStream;
import java.io.IOException;
import java.io.InputStream;
import java.sql.Connection;
import java.sql.Statement;

import javax.servlet.ServletException;
import javax.servlet.annotation.MultipartConfig;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.Part;

import project.Connection_Provider;
@MultipartConfig
@WebServlet("/editproduct")
public class EditproductServlet extends HttpServlet{
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
		
		try
		{
			Connection con = Connection_Provider.getCon();
			Statement stmt = con.createStatement();
			int res = stmt.executeUpdate("update productdetails.details set name='"+name+"',details='" +details+"',price='"+price+"',type='"+type+"',image='"+imgFileName+"' where id = '" +id +"'");
			if(res >0) {
				response.sendRedirect("adminproduct.jsp?msg=done");
			}else {
				response.sendRedirect("edit.jsp?msg=wrong");
			}
			
		}catch(Exception e)
		{
			e.printStackTrace();
		}
	}
}
