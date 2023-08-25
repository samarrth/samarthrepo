<%@page import="java.sql.ResultSet"%>
<%@page import="com.mysql.cj.xdevapi.Result"%>
<%@page import="java.sql.Statement"%>
<%@page import="project.Connection_Provider"%>
<%@page import="java.sql.Connection"%>
<%@page import="java.sql.*"%>
<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
	pageEncoding="ISO-8859-1"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="ISO-8859-1">
<title>Insert title here</title>
<link rel="stylesheet" href="css/product.css">
</head>
<body>
	<%
String msg = request.getParameter("msg");
if("done".equals(msg))
{
%>
	<h2 class="alert">Product added successfully</h2>
	<%} %>
<% 
int id = 0;
try
{
	Connection con = Connection_Provider.getCon();
	Statement stmt = con.createStatement();
	ResultSet rs = stmt.executeQuery("select max(id) from productdetails.details");
	while(rs.next())
	{
		id = rs.getInt(1);
		id = id + 1;


%>
	<div class="container-product">
		<div class="title">Product</div>
		<form action="addproduct" method="post" enctype="multipart/form-data">
			<h3>
				Product id:<%out.print(id); %>
			</h3>
			<input type="hidden" name="id" value="<%out.print(id);%>">
			<div class="user-details">
				<div class="input-box">
					<span class="details">Product name</span> <input type="text"
						name="pname" placeholder="smartphone">
				</div>
				<div class="input-box">
					<span class="details">Product details</span> <input type="text"
						name="pdetails" placeholder="smartphone">
				</div>
				<div class="input-box">
					<span class="details">Product price</span> <input type="text"
						name="pprice" placeholder="smartphone">
				</div>
				<div class="input-box">
					<span class="details">Product type</span> <input type="text"
						name="ptype" placeholder="smartphone">
				</div>
				<div class = "input-box2">
				<span class = "details">Product image</span><br> <input type = "file" 
					name ="pimage" placeholder = "smartphone">
				
				</div>
			</div>
			
				
			
			<div class="button">
			
				<a href = "adminproduct.jsp"><input type="submit" value="Update"></a>
				
			</div>
		</form>
	</div>
	<%
	}
}catch(Exception e)
{
	e.printStackTrace();
}
%>
</body>
</html>