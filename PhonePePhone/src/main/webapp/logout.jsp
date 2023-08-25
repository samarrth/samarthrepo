<%
if(session != null) {
	session.removeAttribute("email");
	session.invalidate();
}
		response.sendRedirect("loginjsp.jsp");
%>