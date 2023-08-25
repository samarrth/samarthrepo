<%@page import="java.sql.PreparedStatement"%>
<%@page import="project.Connection_Provider"%>
<%@page import="java.sql.Connection"%>
<%
	String email = request.getParameter("email");
	String password = request.getParameter("password");
	String firstname = request.getParameter("firstName");
	String lastname = request.getParameter("lastName");
	String mobileno = request.getParameter("mobileNo");
	String answer = request.getParameter("answer");
	String question = request.getParameter("question");
	int z = 0;
	try{
		System.out.print(email);
		System.out.print(password);
		
			
		
		Connection con = Connection_Provider.getCon();
		PreparedStatement pstmt = con.prepareStatement("update signupdetails.details set fname = ?,lname = ?,mno = ?, questions = ?, answer = ? where email = ? and password = ?");
		pstmt.setString(1, firstname);
		pstmt.setString(2, lastname);
		pstmt.setString(3, mobileno);
		pstmt.setString(4, question);
		pstmt.setString(5, answer);
		pstmt.setString(6, email);
		pstmt.setString(7, password);
		z=pstmt.executeUpdate();
		if(z>0){
			response.sendRedirect("profiledetails.jsp?msg=editedsucessfully");
		}
		else
		{
			response.sendRedirect("userdetails.jsp?msg=incorrectpassword");
			
		}
		
	}catch(Exception e)
{
		e.printStackTrace();
}
%>