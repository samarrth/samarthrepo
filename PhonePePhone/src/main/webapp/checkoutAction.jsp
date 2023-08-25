<%@page import="project.Connection_Provider"%>
<%@page import="java.sql.PreparedStatement"%>
<%@page import="java.sql.Connection"%>
<%
    String email = session.getAttribute("email").toString();
    String status = request.getParameter("buynow");
    String checkout = request.getParameter("checkout");
    
    if ("checkout".equals(checkout)) { // Check if checkout action was performed
        status = "bill";
        try {
            Connection con = Connection_Provider.getCon();
            PreparedStatement pstmt = con.prepareStatement("UPDATE orderdetails.details SET status = 'bill' WHERE email = ?");
            pstmt.setString(1, email);
            int rowsAffected = pstmt.executeUpdate();
            
            if (rowsAffected > 0) {
                out.println("Status changed to 'bill' for email: " + email);
                response.sendRedirect("index.jsp");
            } else {
                out.println("Status not changed for email: " + email);
            }
            
            pstmt.close();
            con.close();
        } catch (Exception e) {
            e.printStackTrace();
            
        }
        
    }
%>
