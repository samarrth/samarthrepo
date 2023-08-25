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
				<a href="product.jsp"><button>Add record</button></a>
				<div class="table-container">
					<table>
						<thead>
							<tr>
								<th>Id</th>
								<th>Name</th>
								<th>Details</th>
								<th>Price</th>
								<th>Type</th>
								<th>Image</th>
								<th>Action</th>

							</tr>
						</thead>
						<tbody>
							<%
							try {
								Connection con = Connection_Provider.getCon();
								Statement stmt = con.createStatement();
								ResultSet rs = stmt.executeQuery("SELECT * FROM productdetails.details");
								while (rs.next()) {
							%>
							<tr>
								<td><%=rs.getString("id")%></td>
								<td><%=rs.getString("name")%></td>
								<td><%=rs.getString("details")%></td>
								<td><%=rs.getString("price")%></td>
								<td><%=rs.getString("type")%></td>
								<td><%=rs.getString("image")%></td>
								<td><a href="edit.jsp?id=<%=rs.getString(1)%>"><span
										class="updateicon"><i class="fa-solid fa-pen-to-square"></i></span>
								</a> <a href="removeproducts.jsp?id=<%=rs.getString(1)%>"><span
										class="deleteicon"><i class="fa-solid fa-trash"
											class="deleteicon"></i></span></a></td>
							</tr>
							<%
							}

							rs.close();
							stmt.close();
							con.close();
							%>
							<%
							} catch (Exception e) {
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