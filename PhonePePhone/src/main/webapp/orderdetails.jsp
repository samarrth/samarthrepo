<!DOCTYPE html>
<%@page import="java.sql.ResultSet"%>
<%@page import="java.sql.PreparedStatement"%>
<%@page import="project.Connection_Provider"%>
<%@page import="java.sql.Connection"%>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>User Order Details</title>
    <style>
    body {
    font-family: Arial, sans-serif;
    margin: 0;
    padding: 0;
    background-color: #f0f0f0;
}

.order-details-container {
    width:75%;
    margin: 50px auto;
    padding: 20px;
    background-color: #ffffff;
    box-shadow: 0px 0px 10px rgba(0, 0, 0, 0.1);
}
.otherpages
{
	overflow: auto;
}
h2 {
    margin-bottom: 20px;
    color: #333;
}

.order-item {
    border: 1px solid #ddd;
    padding: 20px;
    margin-bottom: 20px;
    background-color: #f9f9f9;
    display: flex;
    justify-content: space-between;
    align-items: center;
}

.order-item-details h3 {
    margin-top: 0;
    color: #333;
}

.order-item-details p {
    margin: 5px 0;
}

.order-item-actions button {
    padding: 8px 16px;
    margin-left: 10px;
    cursor: pointer;
}
.order-action-form{
	padding: 8px 16px;
    margin-left: 10px;
    cursor: pointer;
    width: 0;
}

.download-btn {
    background-color: #00aaff;
    color: #ffffff;
    border: none;
}

.cancel-btn {
    background-color: #ff5555;
    color: #ffffff;
    border: none;
}
    </style>
    <link rel = "stylesheet" href = "css/newstyle.css">
</head>
<body>
<jsp:include page="navbar.jsp"></jsp:include>

 <div class="admin-container">
  <div class="sidebar">
            <div class="sidebarWrapper">
                <div class="sidebarMenu">
                    <h3 class="sidebarTitle">Dashboard</h3>
                    <ul class="sidebarList">
                        <li class="sidebarListItem">
                            <a href = "profiledetails.jsp"><i class="fa-solid fa-user"></i>Users
                       </a></li>
                        <li class="sidebarListItem">
                            <a href = "orderdetails.jsp"><i class="fa-solid fa-box-open"></i>Order details
                        </a></li>
                        
                    </ul>
                </div>
            </div>
        </div>
        
     <div class="otherpages">
    <div class="order-details-container">
        <h2>User Order Details</h2>
         <%
        String email = session.getAttribute("email").toString();
        try
        {
        	Connection con = Connection_Provider.getCon();
        	PreparedStatement pstmt = con.prepareStatement("select * from orderdetails.details where email = ?");
        	pstmt.setString(1, email);
        	ResultSet rs = pstmt.executeQuery();
        	while(rs.next())
        	{
        		
        %>
        <div class="order-item">
       
            <div class="order-item-details">
                <h3>Product Name: <%=rs.getString(2) %></h3>
                <p>Name: <%=rs.getString(6) %>
                <p>Status: <%=rs.getString(17) %></p>
                <p>Price: <%=rs.getString(4) %></p>
                <p>Quantity: <%=rs.getString(5) %></p>
            </div>
            <div class="order-item-actions">
                <button class="download-btn" onclick="window.location.href='Userinvoice.jsp?orderid=<%=rs.getString(19)%>'">Download</button>
                <%
                	if("bill".equals(rs.getString(17)))
                	{
                %>
                <form action="adminorderaction.jsp" method = "post" class="order-action-form">
						<input type = "hidden" name = "id" value = "<%=rs.getInt(19)%>">
						<input type = "hidden" name = "email" value = "<%=rs.getString(14)%>">
						<input type = "hidden" name = "status" value = "Cancelled">
						<input type="hidden" name="sourcePage" value="<%= request.getRequestURI() %>">
						<button  type = "submit" class="cancel-btn">Cancel</button>
						</form>
                
                <% }%>
            </div>
        </div>

        	
       <%}}catch(Exception e)
        {
        	e.printStackTrace();
        }
        %>
        <!-- Add more order-item divs for other order details -->
    </div>
    </div>
    </div>
</body>
</html>
