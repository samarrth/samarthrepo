<%@page import="java.io.FileOutputStream"%>
<%@page import="java.io.File"%>
<%@page import="java.io.InputStream"%>
<%@page import="javax.print.DocFlavor.INPUT_STREAM"%>
<%@page import = "project.Connection_Provider"%>
<%@page import = "java.sql.*"%>
<%@page import="com.mysql.cj.xdevapi.Result"%>
<%@page import="java.sql.ResultSet"%>

<%@page
    import="java.io.FileOutputStream, java.io.File, java.io.InputStream, javax.print.DocFlavor.INPUT_STREAM, project.Connection_Provider, java.sql.*, com.mysql.cj.xdevapi.Result, java.sql.ResultSet"
  %>
<%@ page 
    import="javax.servlet.http.Part"
    %>




<%
/*
	String id = request.getParameter("id");
	String name = request.getParameter("pname");
	String details = request.getParameter("pdetails");
	String price = request.getParameter("pprice");
	String type = request.getParameter("ptype");
	Part image = request.getPart("pimage");
	
	System.out.println(image);
	
	String imageFilename = image.getSubmittedFileName();
	String uploadpath = "D:/project/PhonePePhone/images/"+ image;
	
	try{
		FileOutputStream outputStream = new FileOutputStream(uploadpath); 
		InputStream imStream = image.getInputStream();
		byte[] bs = new byte[imStream.available()];
		imStream.read(bs);
		outputStream.write(bs);
		outputStream.close();
		imStream.close();
	}catch(Exception e){
		e.printStackTrace();	
	}
	try
	{
		Connection con = Connection_Provider.getCon();
		PreparedStatement pstmt = con.prepareStatement("insert into productdetails.details values(?,?,?,?,?,?) ");
		pstmt.setString(1, id);
		pstmt.setString(2, name);
		pstmt.setString(3, details);
		pstmt.setString(4, price);
		pstmt.setString(5, type);
		//pstmt.setString(6, imStream);
		pstmt.setString(6, imageFilename);
		pstmt.executeUpdate();

		response.sendRedirect("product.jsp?msg=done");
	}catch(Exception e)
	{
		response.sendRedirect("product.jsp?msg=done");
		
		
	}*/
	
	
	
	String id = request.getParameter("id");
	String name = request.getParameter("pname");
	String details = request.getParameter("pdetails");
	String price = request.getParameter("pprice");
	String type = request.getParameter("ptype");
	Part imgPart = request.getPart("pimage");
	
	String imgFileName = imgPart.getSubmittedFileName();
	String uploadPath = "D:/project/PhonePePhone/images/"+ imgFileName;
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
			response.sendRedirect("product.jsp?msg=done");
		}else {
			response.sendRedirect("product.jsp?msg=wrong");
		}
		
	} catch (Exception e) {
		System.out.println(e);
		response.sendRedirect("product.jsp?msg=wrong");
	} 
	
%> 

 