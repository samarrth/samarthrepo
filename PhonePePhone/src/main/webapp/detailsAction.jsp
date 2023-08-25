<%@page import="java.sql.ResultSet"%>
<%@page import="java.sql.PreparedStatement"%>
<%@page import="project.Connection_Provider"%>
<%@page import="java.sql.Connection"%>
<%
String productname = null;
String productprice = null;
String category = null;
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

int z = 0;
try {
	Connection con = Connection_Provider.getCon();

		PreparedStatement pstmt = con.prepareStatement("select * from productdetails.details where id = ?");
		pstmt.setInt(1, productid);
		quantity = 1;
		ResultSet rs = pstmt.executeQuery();
		if (rs.next()) {
	// Get product details
	productname = rs.getString(2);
	productprice = rs.getString(4);
	category = rs.getString(5);
		}

		// Check if an order with the same product and user already exists
		PreparedStatement checkOrderStmt = con
		.prepareStatement("SELECT * FROM orderdetails.details WHERE productid = ? AND email = ? AND name= ?");
		checkOrderStmt.setInt(1, productid);
		checkOrderStmt.setString(2, email);
		checkOrderStmt.setString(3, name);
		ResultSet existingOrderResult = checkOrderStmt.executeQuery();

		if (existingOrderResult.next()) {
	// Order already exists, update the address and other details
	PreparedStatement updateOrderStmt = con.prepareStatement(
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

	int updateResult = updateOrderStmt.executeUpdate();

	if (updateResult > 0) {
		response.sendRedirect("paymentgateway.jsp?msg=done");
	} else {
		response.sendRedirect("deliverydetails.jsp?msg=wrong");
	}
		} else {
	// Order doesn't exist, insert a new order
	PreparedStatement pstmt2 = con.prepareStatement(
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
	int res = pstmt2.executeUpdate();
	if (res > 0) {
		response.sendRedirect("paymentgateway.jsp?msg=done&action='"+action+"'");
	} else {
		System.out.println("wrong this buynow");
	}
}

	

	

} catch (Exception e) {
	e.printStackTrace();
}
%>