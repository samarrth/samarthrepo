<%@page import="java.sql.PreparedStatement"%>
<%@page import="java.sql.ResultSet"%>
<%@page import="java.sql.Statement"%>
<%@page import="project.Connection_Provider"%>
<%@page import="java.sql.Connection"%>
<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
	pageEncoding="ISO-8859-1"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="ISO-8859-1">
<title>Insert title here</title>
<link rel="stylesheet" href="css/edit.css">
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
 String id = request.getParameter("id");
 
  try
  {
  	Connection con = Connection_Provider.getCon();
  	Statement stmt = con.createStatement();
  	
  	ResultSet rs = stmt.executeQuery("select * from productdetails.details where id = '"+ id +"'");
  	while(rs.next())
  	{
  	
  	

 %>
	
	<div class="container-productt">
	<form action = "editproduct" method = "post" enctype="multipart/form-data">
		<div class="titlee">Product
		
			<h3>
				Product id:<%out.print(id); %>
			</h3>
			<input type="hidden" name="id" value="<%out.print(id);%>">
			<div class="user-detailss">
				<div class="input-boxx">
					<span class="detailss">Product name</span> <input type="text"
						name=pname value = "<%=rs.getString(2) %>" placeholder="smartphone">
				</div>
				<div class="input-boxx">
					<span class="detailss">Product details</span> <input type="text"
						name=pdetails value = "<%=rs.getString(3) %>" placeholder="smartphone">
				</div>
				<div class="input-boxx">
					<span class="detailss">Product price</span> <input type="text"
						name=pprice value = "<%=rs.getString(4) %>" placeholder="smartphone">
				</div>
				<div class="input-boxx">
					<span class="detailss">Product type</span> <input type="text"
						name=ptype value = "<%=rs.getString(5) %>" placeholder="smartphone">

				</div>
				<div class = "input-box2">
				<span class = "details">Product image</span><br> <input type = "file" 
					name ="pimage" placeholder = "smartphone">
				
				</div>
			</div>
	
			<div class="buttonn">
				<input type="submit" value="save">
			</div>
	</div>
	</form>
	
	
	</div>
	
	
 	<% 
  	}
  	if(con !=null)
  	{
  		con.close();
  	}
  }catch(Exception e)
  {
	  
  }
  
 	%>
 
</body>
</html>