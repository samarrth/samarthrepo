<%@page import="java.sql.PreparedStatement"%>
<%@page import="java.sql.ResultSet"%>
<%@page import="project.Connection_Provider"%>
<%@page import="java.sql.Connection"%>
<html>
<head>
    <title>Receipt</title>
    <style>
        body {
            font-family: Arial, sans-serif;
        }
        .invoice-container {
            width: 80%;
            margin: 0 auto;
            padding: 20px;
            border: 1px solid #ccc;
            box-shadow: 0 0 10px rgba(0, 0, 0, 0.1);
        }
        .invoice-header {
            text-align: center;
            margin-bottom: 20px;
        }
        .invoice-details {
            display: flex;
            justify-content: space-between;
            margin-bottom: 20px;
        }
        .invoice-address {
            width: 48%;
        }
        .invoice-products {
            width: 100%;
            border-collapse: collapse;
            margin-top: 20px;
        }
        .invoice-products th, .invoice-products td {
            border: 1px solid #ccc;
            padding: 8px;
            text-align: left;
        }
        .checkout-btn button {
           font-size: 15px;
           color: #f63e4e;
           margin-top: 20px;
           padding:10px;
           border-radius: 15px;
           border: 1px solid #f63e4e;
        }
         .checkout-btn button:hover
        {
       	 cursor: pointer;
   		 background-color: #f63e4e;
  		 color: white;
        }
        .checkout-btn
        {
          display: flex;
          justify-content: space-between;
          
        }
        
    </style>
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
    <div class="invoice-container">
        <div class="invoice-header">
            <h1>Receipt</h1>
        </div>
        <%
        String email = session.getAttribute("email").toString();
        double total = 0;
        try
        {
            Connection con = Connection_Provider.getCon();
            PreparedStatement pstmt = con.prepareStatement("select * from orderdetails.details where email = ? and status = 'buynow'");
            pstmt.setString(1, email);
            ResultSet rs = pstmt.executeQuery();
            if (rs.next())
            {
                
                
        %>
        <div class="invoice-details">
            <div class="invoice-address">
                <p><strong>Bill To:</strong></p>
                <p>Name: <%=rs.getString(6) %></p>
                <p>Mobile No: <%=rs.getString(15) %></p>
                <p>Email: <%=rs.getString(14) %></p>
                <p>Address: <%=rs.getString(7) %></p>
            </div>
            <div class="invoice-payment">
                <p><strong>Payment Details:</strong></p>
                <p>Order Date: <%=rs.getString(12) %></p>
                <p>Payment Method: <%=rs.getString(18) %></p>
                <p>Transaction ID: <%=rs.getString(16) %></p>
                <p>Status: <%=rs.getString(17) %></p>
            </div>
        </div>
    <% } %>
   <b> Note </b>- This is your order confirmation and receipt please keep this for your reference
        <table class="invoice-products">
            <thead>
            
                <tr>
                    <th>Product Name</th>
                    <th>Category</th>
                    <th>Price</th>
                    <th>Quantity</th>
                    <th>Subtotal</th>
                </tr>
            </thead>
            <tbody>
           		<%
           	 		PreparedStatement pstmt2 = con.prepareStatement("select * from orderdetails.details where email = ? and status = 'buynow'");
                	pstmt2.setString(1, email);
                	ResultSet rs2 = pstmt2.executeQuery();
            		while(rs2.next())
            		{
           		%>
                <tr>
                
                    <td><%=rs2.getString(2) %></td>
                    <td><%=rs2.getString(3) %></td>
                    <td><%=rs2.getInt(4) %></td>
                    <td><%=rs2.getInt(5) %></td>
                    <%total = total + rs2.getInt(4)*rs2.getInt(5); %>
                    <td><%= rs2.getInt(4)*rs2.getInt(5) %> </td>
                </tr>
                <%
            		}%>
          
            </tbody>
            <tfoot>
                <tr>
                    <td colspan="4" style="text-align: right;"><strong>Total</strong></td>
                    <td><%=total %></td>
                </tr>
            </tfoot>
        </table>
       <%
            rs.close();
            pstmt.close();
        }catch (Exception e) {
            e.printStackTrace();
        }
        %>
        <div class="checkout-btn">
    <form action="checkoutAction.jsp" method = "post">
       <button name = "checkout" value = "checkout">checkout</button>
       </form>
        <button name = "print" onclick="window.print()">print</button>
    </div> 
    </div>
    
   
    
     
</body>
</html>
