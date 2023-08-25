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
<style>
  <style>
  body {
    font-family: Arial, sans-serif;
    background-color: #f0f0f0;
    margin: 0;
    padding: 0;
    display: flex;
    justify-content: center;
    align-items: center;
    height: 100vh;
  }
  .user-card {
    background-color: #fff;
    border-radius: 10px;
    box-shadow: 0 2px 5px rgba(0, 0, 0, 0.1);
    padding: 20px;
    width: 300px;
    text-align: center;
  }
  .user-card h2 {
    margin-bottom: 10px;
  }
  .user-detail {
    margin: 30px;
  }
  .edit-btn {
    background-color: #007bff;
    color: #fff;
    border: none;
    border-radius: 5px;
    padding: 8px 16px;
    cursor: pointer;
    transition: background-color 0.3s ease;
  }
  .edit-btn:hover {
    background-color: #0056b3;
  }
</style>
<link rel = "stylesheet" href = "css/newstyle.css">
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

 <div class="admin-container">
  <div class="sidebar">
            <div class="sidebarWrapper">
                <div class="sidebarMenu">
                    <h3 class="sidebarTitle">Dashboard</h3>
                    <ul class="sidebarList">
                        <li class="sidebarListItem">
                            <a href = "admin.jsp"><i class="fa-solid fa-user"></i>Users
                       </a></li>
                        <li class="sidebarListItem">
                            <a href = "orderdetails.jsp"><i class="fa-solid fa-box-open"></i>Order details
                        </a></li>
                        
                    </ul>
                </div>
            </div>
        </div>
    <div class="otherpages">
    <%
    String email = session.getAttribute("email").toString();
    try
    {
    	Connection con = Connection_Provider.getCon();
    	PreparedStatement pstmt = con.prepareStatement("select * from signupdetails.details where email = ?");
    	pstmt.setString(1, email);
    	ResultSet rs = pstmt.executeQuery();
    	if(rs.next())
    	{
    		
    
    %>
    	<div class="user-card">
    <h2>User Details</h2>
    <div class="user-detail">
      <strong>Name:</strong><br> <%=rs.getString(1) %>
    </div>
    <div class="user-detail">
      <strong>lastName:</strong><br> <%=rs.getString(2) %>
    </div>
    <div class="user-detail">
      <strong>Email:</strong><br> <%=rs.getString(4) %>
    </div>
    <div class="user-detail">
      <strong>Mobile No:</strong><br><%=rs.getString(3) %>
    </div>
    <div class="user-detail">
      <strong>Security question:</strong><br><%=rs.getString(6) %>
    </div>
  
    <a href = "userdetails.jsp"><button class="edit-btn">Edit Details</button></a>
  </div>
    </div>
    	<% }
    	
    }catch(Exception e)
    {
    	e.printStackTrace();
    }%> 
</div>
 
     
      
</body>
</html>