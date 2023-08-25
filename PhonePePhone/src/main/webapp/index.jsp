<%@page import="java.sql.PreparedStatement"%>
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
    <title>Document</title>
    <link rel="stylesheet" href="css/style.css">
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
<%
String msg = request.getParameter("msg");
if("done".equals(msg))
{
%>
<h2 class = "alert">Product added successfully</h2>
<%} %>

    <section class="content">
        <h1 class="head">New Smartphones</h1>
        <p>Best Smartphones</p>
       
    </section>

    <h1 class="phead">Our Latest SmartPhones</h1>

    <section class="section">
    
        <div class="phones">

            <!-- start -->
                 <%
                String id = request.getParameter("id");
				try{
					Connection con = Connection_Provider.getCon();
					Statement stmt = con.createStatement();
					PreparedStatement pstmt = con.prepareStatement("select * from productdetails.details");
					
					ResultSet rs = pstmt.executeQuery();
					while(rs.next())
				{
			
			%>
			
           <div class = "card">
           
                <div class="img"><a href = "details.jsp?id=<%= rs.getString(1) %>" ><img src="images/<%=rs.getString(6)%>" alt = ""></a></div>
                <div class = "desc"><%=rs.getString(5) %></div>
            
                <div class="title"><%=rs.getString(2) %></div>
             
                <div class="box">
                    <div class="price">Rs- <%=rs.getString(4) %></div>
                      
                </div>
                
            </div >
                    <%
				}
					//rs.close();
					pstmt.close();
				
				}catch(Exception e)
          	  {
					e.printStackTrace();
          	  }
                
                %>
            
            
              
        </div>
        
    </section>
<jsp:include page="footer.jsp"></jsp:include>
</body>
</html>
       