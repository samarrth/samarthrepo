<%@page import="java.sql.ResultSet"%>
<%@page import="java.sql.PreparedStatement"%>
<%@page import="project.Connection_Provider"%>
<%@page import="java.sql.Connection"%>
<%
String productname = null;
String productprice = null;
String category = null;
int updateResult =0;
int quantity = 0;
String action = request.getParameter("action");
String name = request.getParameter("fullname");
String address = request.getParameter("address");
String city = request.getParameter("city");
String state = request.getParameter("state");
String pincode = request.getParameter("pincode");
String country = request.getParameter("country");
int productid = Integer.parseInt(request.getParameter("id"));
String email = session.getAttribute("email").toString();
long mobileno = Long.parseLong(request.getParameter("mobileno"));
System.out.println(action);
System.out.println(action);
try
{
Connection con1 = Connection_Provider.getCon();
PreparedStatement pstmt1 = con1.prepareStatement("Select * from cartdetails.details where email=?");
pstmt1.setString(1, email);
ResultSet rs1 = pstmt1.executeQuery();
while (rs1.next()) {
	productid = rs1.getInt(1);

	PreparedStatement pstmt3 = con1.prepareStatement("Select name,type from productdetails.details where id=?");
	pstmt3.setInt(1, productid);
	ResultSet rs2 = pstmt3.executeQuery();
	if (rs2.next()) {
		productname = rs2.getString(1);
		category = rs2.getString(2);
	}
	quantity = rs1.getInt(2);
	productprice = rs1.getString(3);

	PreparedStatement checkOrderStmt = con1
	.prepareStatement("SELECT * FROM orderdetails.details WHERE productid = ? AND email = ? AND name= ?");
	checkOrderStmt.setInt(1, productid);
	checkOrderStmt.setString(2, email);
	checkOrderStmt.setString(3, name);
	ResultSet existingOrderResult = checkOrderStmt.executeQuery();
	if (existingOrderResult.next()) {
		// Order already exists, update the address and other details
		PreparedStatement updateOrderStmt = con1.prepareStatement(
		"UPDATE orderdetails.details SET name = ?, address = ?, city = ?, state = ?, pincode = ?, country = ?, productname = ?, productid = ?, quantity = ?, category = ? WHERE productid = ? AND email = ? AND status is null");
		updateOrderStmt.setString(1, name);
		updateOrderStmt.setString(2, address);
		updateOrderStmt.setString(3, city);
		updateOrderStmt.setString(4, state);
		updateOrderStmt.setString(5, pincode);
		updateOrderStmt.setString(6, country);
		updateOrderStmt.setString(7, productname);
		updateOrderStmt.setInt(8, productid);
		updateOrderStmt.setInt(9, quantity);
		updateOrderStmt.setString(10, category);
		updateOrderStmt.setInt(11, productid);
		updateOrderStmt.setString(12, email);

		updateResult = updateOrderStmt.executeUpdate();

	} else {
		// Order doesn't exist, insert a new order
		PreparedStatement pstmt2 = con1.prepareStatement(
		"insert into orderdetails.details(productid,productname,productprice,quantity,name,address,city,pincode,country,email,mobileno,category,state) values(?,?,?,?,?,?,?,?,?,?,?,?,?)");
		pstmt2.setInt(1, productid);
		pstmt2.setString(2, productname);
		pstmt2.setString(3, productprice);
		pstmt2.setInt(4, quantity);
		pstmt2.setString(5, name);
		pstmt2.setString(6, address);
		pstmt2.setString(7, city);
		pstmt2.setString(8, pincode);
		pstmt2.setString(9, country);
		pstmt2.setString(10, email);
		pstmt2.setLong(11, mobileno);
		pstmt2.setString(12, category);
		pstmt2.setString(13, state);
		updateResult = pstmt2.executeUpdate();
	}
}
if (updateResult > 0) {
	response.sendRedirect("paymentgateway.jsp?msg=done&action='"+action+"'");
		} else {
	System.out.println("wrong this checkout");

		}
}catch(Exception e)
{
	e.printStackTrace();
}
%>