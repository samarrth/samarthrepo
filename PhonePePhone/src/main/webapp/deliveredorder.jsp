<%@page import="java.sql.ResultSet"%>
<%@page import="java.sql.Statement"%>
<%@page import="project.Connection_Provider"%>
<%@page import="java.sql.Connection"%>
<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
	pageEncoding="ISO-8859-1"%>
<!DOCTYPE html>
<html lang="en">
<head>
<meta charset="UTF-8">
<meta http-equiv="X-UA-Compatible" content="IE=edge">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<title>Alpha admin</title>
<link rel="stylesheet"
	href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css"
	integrity="sha512-iecdLmaskl7CVkqkXNQ/ZH/XLlvWZOJyj7Yy7tcenmpD1ypASozpmT/E0iPtmFIB46ZmdtAc9eNBvH0H/ZpiBw=="
	crossorigin="anonymous" referrerpolicy="no-referrer" />
<script
	src="https://cdnjs.cloudflare.com/ajax/libs/jquery/3.7.0/jquery.min.js"
	integrity="sha512-3gJwYpMe3QewGELv8k/BX9vcqhryRdzRMxVfq6ngyWXwo03GFEzjsUm8Q7RZcHPHksttq7/GFoxjCVUjkjvPdw=="
	crossorigin="anonymous" referrerpolicy="no-referrer"></script>
<link rel="stylesheet" href="css/newstyle.css">
</head>
<body>
<%
response.setHeader("Cache-Control", "no-cache, no-store, must-revalidate");
response.setHeader("Pragma", "no-cache");
response.setHeader("Expires", "0");


if(session.getAttribute("email")==null){
	response.sendRedirect("loginjsp.jsp");
}
%>
	<jsp:include page="topbar.jsp"></jsp:include>
	<div class="admin-container">
	<jsp:include page="sidebar.jsp"></jsp:include>


		<div class="otherpages">
			<h1>All records</h1>
			<div class="records">
				<%
				String msg = request.getParameter("msg");
				if ("deleted".equals(msg)) {
				%>
				<span>product deleted successfully</span><br>
				<%
				}
				if ("error".equals(msg)) {
				%>
				<span>product deleted unsuccessfully</span><br>

				<%
				}
				%>
				
				<div class="table-container">
					<table>
						<thead>
							<tr>
								<th>productname</th>
								<th>category</th>
								<th>productprice</th>
								<th>quantity</th>
								<th>name</th>
								<th>address</th>
								<th>city</th>
								<th>state</th>
								<th>pincode</th>
								<th>country</th>
								<th>orderdate</th>
								<th>deliverydate</th>
								<th>email</th>
								<th>mobileno</th>
								<th>transactionid</th>
								<th>status</th>
								<th>paymentmethod</th>
								
							</tr>
						</thead>
						<tbody>
						<%
						try {
							Connection con = Connection_Provider.getCon();
							Statement stmt = con.createStatement();
							ResultSet rs = stmt.executeQuery("SELECT * FROM orderdetails.details where status = 'Delivered'");
							while (rs.next()) {
						%>
						<tr>
						
						<td><%=rs.getString(2) %></td>
						<td><%=rs.getString(3) %></td>
						<td><%=rs.getString(4) %></td>
						<td><%=rs.getString(5) %></td>
						<td><%=rs.getString(6) %></td>
						<td><%=rs.getString(7) %></td>
						<td><%=rs.getString(8) %></td>
						<td><%=rs.getString(9) %></td>
						<td><%=rs.getString(10) %></td>
						<td><%=rs.getString(11) %></td>
						<td><%=rs.getString(12) %></td>
						<td><%=rs.getString(13) %></td>
						<td><%=rs.getString(14) %></td>
						<td><%=rs.getString(15) %></td>
						<td><%=rs.getString(16) %></td>
						<td><%=rs.getString(17) %></td>
						<td><%=rs.getString(18) %></td>
						
						</tr>
						<%}
							}catch(Exception e){
								e.printStackTrace();
							}
							%>
						</tbody>
					</table>
				</div>
			</div>
		</div>
	</div>
</body>
</html>
