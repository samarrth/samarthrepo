<%@page import = "project.Connection_Provider"%>
<%@page import = "java.sql.*" %>
<%
	String name = request.getParameter("fname");
	String lname = request.getParameter("lname");
	String mno = request.getParameter("mobileno");
	String email = request.getParameter("email");
	String pwd = request.getParameter("password");
	String question = request.getParameter("question");
	String answer = request.getParameter("Answer");
	
	try{
	Connection con = Connection_Provider.getCon();
	PreparedStatement pstmt = con.prepareStatement("Insert into signupdetails.details values(?,?,?,?,?,?,?)");
	pstmt.setString(1, name);
	pstmt.setString(2, lname);
	pstmt.setString(3, mno);
	pstmt.setString(4, email);
	pstmt.setString(5, pwd);
	pstmt.setString(6, question);
	pstmt.setString(7, answer);
	pstmt.executeUpdate();
	response.sendRedirect("register.jsp?msg=valid");
	}catch(Exception e)
	{
		response.sendRedirect("register.jsp?msg=invalid");
		
	}
	
	
%>


