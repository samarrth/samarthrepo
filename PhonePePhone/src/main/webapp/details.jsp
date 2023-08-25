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
<link rel="stylesheet" href=css/style.css>
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
	<jsp:include page="navbar.jsp"></jsp:include>
	<div class="detail-container">
		
		<%
			String id = request.getParameter("id");
			try
			{
				Connection con = Connection_Provider.getCon();
				Statement stmt = con.createStatement();
				ResultSet rs = stmt.executeQuery("select * from productdetails.details where id = '" + id + "'");
				while(rs.next())
				{
					
			%>
			<div class="img-container">
			<img src="images/<%=rs.getString(6)%>" alt="">
		</div>
		<div class="product-details">
		
			
			<h2>Details</h2>
			<h1><%=rs.getString(2)%></h1>
			<p><%=rs.getString(3)%></p>
			<span>Rs- <%=rs.getString(4)%></span>
			
		
			
			<div class="details-btn">
				<a href = "cartAction.jsp?id=<%=rs.getInt(1)%>"><input type="Submit" value = "Add to cart"></a>
				<a href = "deliverydetails.jsp?id=<%=rs.getString(1) %>&action=buynow"><input type="submit" value="Buy now"></a>
			</div>
		</div>
			<%
			}
				
			}catch(Exception e)
			{
				e.printStackTrace();
			}
			
			%>
	</div>
	<jsp:include page="footer.jsp"></jsp:include>
</body>
</html>