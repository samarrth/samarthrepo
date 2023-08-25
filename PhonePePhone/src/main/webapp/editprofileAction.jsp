<%@page import="java.sql.Connection"%>
<%@page import="java.sql.PreparedStatement"%>
<%@page import="java.sql.ResultSet"%>
<%@page import="project.Connection_Provider"%>
<%
String oldPass = request.getParameter("currentPassword");
String newPass = request.getParameter("newPassword");
String confirmPass = request.getParameter("confirmPassword");
String email = request.getParameter("email");
String password = null;

Connection conn = null;
PreparedStatement pstmt = null,pstmt1=null;
ResultSet rs = null;
try {
	conn = Connection_Provider.getCon();
	pstmt = conn.prepareStatement("Select password from signupdetails.details where email = ?");
	pstmt.setString(1, email);
	rs = pstmt.executeQuery();
	if(rs.next()) {
		password = rs.getString("password");
	}
	if(newPass.equals(confirmPass)) {
		if(oldPass.equals(password)) {
			try {
				
				pstmt1 = conn.prepareStatement("Update signupdetails.details set password=? where email=?");
				pstmt1.setString(1, newPass);
				pstmt1.setString(2, email);
				pstmt1.executeUpdate();
				response.sendRedirect("editprofile.jsp?msg=success");
			} catch (Exception e) {
				e.printStackTrace();
			}
		}else {
			response.sendRedirect("editprofile.jsp?msg=error");
		}
	}else {
		response.sendRedirect("editprofile.jsp?msg=cancel");
	}
} catch (Exception e) {
	e.printStackTrace();
}

%>