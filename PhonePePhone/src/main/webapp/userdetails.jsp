<%@page import="java.sql.ResultSet"%>
<%@page import="java.sql.PreparedStatement"%>
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
.edit-details-container {
	width: 40%;
	margin: 0 auto;
	padding: 20px;
	border: 1px solid #ccc;
	box-shadow: 0 0 10px rgba(0, 0, 0, 0.1);
	background-color: #f7f7f7;
}
.otherpages{
	overflow: auto;
}
.edit-details-form {
	display: flex;
	flex-direction: column;
	
}

.input-group {
	margin-bottom: 15px;
}

.input-group label {
	font-weight: bold;
}

.input-group input{
	padding: 8px;
	border: 1px solid #ccc;
	border-radius: 4px;
	width: 100%;
}
.input-group select{
	padding: 8px;
	border: 1px solid #ccc;
	border-radius: 4px;
	width: 100%;
}

.btn-group {
	margin-top: 20px;
	text-align: right;
}

.done-btn {
	padding: 10px 20px;
	background-color: #007bff;
	color: #fff;
	border: none;
	border-radius: 4px;
	cursor: pointer;
}

.done-btn:hover {
	background-color: #0056b3;
}
</style>
<link rel="stylesheet" href="css/style.css">
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
	<jsp:include page="navbar.jsp"></jsp:include>

	<div class="admin-container">

		<div class="sidebar">
			<div class="sidebarWrapper">
				<div class="sidebarMenu">
					<h3 class="sidebarTitle">Dashboard</h3>
					<ul class="sidebarList">
						<li class="sidebarListItem"><a href="profiledetails.jsp"><i
								class="fa-solid fa-user"></i>Users </a></li>
						<li class="sidebarListItem"><a href="orderdetails.jsp"><i
								class="fa-solid fa-box-open"></i>Order details </a></li>

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
			<div class="edit-details-container">
				
				<h2>Edit Details</h2>
				<form class="edit-details-form" action="userdetailsAction.jsp"
					method="post">
					<input type = "hidden" name = "email" value = "<%=email %>">
					<div class="input-group">
						<label for="firstName">First Name:</label> <input type="text"
							id="firstName" name="firstName" value="<%=rs.getString(1)%>">
					</div>

					<div class="input-group">
						<label for="lastName">Last Name:</label> <input type="text"
							id="lastName" name="lastName" value="<%=rs.getString(2)%>">
					</div>

					<div class="input-group">
						<label for="mobileNo">Mobile No:</label> <input type="text"
							id="mobileNo" name="mobileNo" value="<%=rs.getString(3)%>">
					</div>
					
					<div class="input-group">
						<label for="securityQuestion">Security Question:</label> 
						 
							<select name = "question">
            		   	 <option value = "your favourite car" <%=(rs.getString(6).equals("your favourite car"))?"selected":" " %>>your favourite car?</option>
          				 <option value = "your favourite bike" <%=(rs.getString(6).equals("your favourite bike"))?"selected":" " %>>your favourite bike?</option>
           				 <option value = "your favourite color" <%=(rs.getString(6).equals("your favourite color"))?"selected":" " %>>your favourite color?</option>
            			</select>
							
					</div>
					<div class="input-group">
						<label for="Answer">Answer:</label> <input type="text"
							id="answer" name="answer"value="<%=rs.getString(7)%>" >
					</div>
					
					
					
					<div class="input-group">
						<label for="password">password: (For confirmation)</label><input type="password" id="password"
							name="password" autocomplete="off" required>
					</div>

					<div class="btn-group">
						<button class="done-btn" type="submit">Done</button>
					</div>
				</form>
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