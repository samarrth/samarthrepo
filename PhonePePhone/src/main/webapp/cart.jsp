<%@page import="java.io.InputStream"%>
<%@page import="java.io.FileOutputStream"%>
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
<link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css" 
 integrity="sha512-iecdLmaskl7CVkqkXNQ/ZH/XLlvWZOJyj7Yy7tcenmpD1ypASozpmT/E0iPtmFIB46ZmdtAc9eNBvH0H/ZpiBw==" crossorigin="anonymous" referrerpolicy="no-referrer" />
<link rel="stylesheet" href=css/cart.css>
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
	<div class="cart-wrapper">
		<h1>YOUR CART</h1>
		<div class="cart-top">
			<a href = index.jsp><button class = "cart-button">CONTINUE SHOPPING</button></a>
			<button class = "cart-button">CHECKOUT</button>
		</div>
		<div class="cart-bottom">
			<div class="cart-info">
				<%
				int subtotal = 0;
				String email = session.getAttribute("email").toString();
				String productid = request.getParameter("id");
				try {

					
					Connection con = Connection_Provider.getCon();
					Statement stmt = con.createStatement();
					ResultSet rs1 = stmt.executeQuery("select * from cartdetails.details where email = '" + email + "'");
					while (rs1.next()) {

						Statement stmt2 = con.createStatement();
						ResultSet rs2 = stmt2.executeQuery("select name,image,id from productdetails.details where id = '" + rs1.getInt(1) + "'");
						if (rs2.next()) {
					subtotal = subtotal + Integer.parseInt(rs1.getString(5));
					String productName = rs2.getString("name");
					String uploadPath = rs2.getString(2);
					System.out.print(uploadPath);
				%>
				<div class="cart-product">
					<div class="product-details">
						<img src="images/<%=uploadPath%>" alt=""></img>
						<div class="heading">
							<span><b> Product: </b><%=productName%> </span><br><br><span class = "quantity"><b>
							Quantity: </b> <a href = "incdecquantityAction.jsp?id=<%=rs1.getString(1)%>&quantity=inc"><i class="fa-solid fa-plus"></i></a>&nbsp;<%=rs1.getString(2)%>&nbsp;<a href = "incdecquantityAction.jsp?id=<%=rs1.getString(1)%>&quantity=dec"><i class="fa-solid fa-minus"></i></a></span>
						</div>
						<div class="product-price">
						<b>Price:</b><%=rs1.getString(3)%>
						<div class="remove-btn">
							<a href="removecart.jsp?id=<%=rs1.getInt(1)%>"><button>Remove</button></a>
						</div>
					</div>
					</div>
					
				</div>
				<hr>
				<%
				}
				}
				} catch (Exception e) {
				e.printStackTrace();
				}
				%>	
			</div>
			<div class="cart-summary">
				<h3 class="summarty-title">ORDER SUMMARY</h3>
				<div class="summary-item">
					<span>Subtotal:</span> <span><%=subtotal%></span>
				</div>
				<div class="summary-item">
					<span>Estimated Shipping:</span> <span>100</span>
				</div>

				<div class="summary-item" style="font-weight: 500; font-size: 24px;">
					<span>Total:</span> <span><%=subtotal%></span>

					<%
						try
					{
						Connection con = Connection_Provider.getCon();
						PreparedStatement pstmt = con.prepareStatement("select * from cartdetails.details");
						
					%>
					
				</div>
				<%}catch(Exception e)
					{
						e.printStackTrace();
					}%>
				<a href = "deliverydetails.jsp?&action=checkout"><button>CHECKOUT NOW</button></a>
				
			</div>
		</div>

	</div>
<jsp:include page="footer.jsp"></jsp:include>

</body>
</html>