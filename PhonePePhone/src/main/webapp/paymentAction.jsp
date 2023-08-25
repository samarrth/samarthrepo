<%@page import="java.sql.PreparedStatement"%>
<%@page import="project.Connection_Provider"%>
<%@page import="java.sql.Connection"%>
<%
    String email = session.getAttribute("email").toString();
    String paymentmethod = request.getParameter("paymentmethod");
    String status = "buynow";
    String transactionid = null;
    int z = 0;
    try {
        Connection con = Connection_Provider.getCon();
        if ("card".equals(paymentmethod)) {
            transactionid = Connection_Provider.generateTransactionId();
            PreparedStatement pstmt = con.prepareStatement("UPDATE orderdetails.details SET orderdate=now(), deliverydate=DATE_ADD(orderdate, INTERVAL 4 DAY), paymentmethod=?, status=?, transactionid=? WHERE email = ? and status is null");
            pstmt.setString(1, paymentmethod);
            pstmt.setString(2, status);
            pstmt.setString(3, transactionid);
            pstmt.setString(4, email);
            z = pstmt.executeUpdate();
        } else if ("cod".equals(paymentmethod)) {
            transactionid = "";
            PreparedStatement pstmt = con.prepareStatement("UPDATE orderdetails.details SET orderdate=now(), deliverydate=DATE_ADD(orderdate, INTERVAL 4 DAY), paymentmethod=?, status=?, transactionid=? WHERE email = ? and status is null");
            pstmt.setString(1, paymentmethod);
            pstmt.setString(2, status);
            pstmt.setString(3, transactionid);
            pstmt.setString(4, email);
            z = pstmt.executeUpdate();
        }
        if (z >= 1) {
            PreparedStatement pstmt2 = con.prepareStatement("DELETE FROM cartdetails.details WHERE email = ?");
            pstmt2.setString(1, email);
            pstmt2.executeUpdate();
        }
        response.sendRedirect("invoice.jsp");
    } catch (Exception e) {
        e.printStackTrace();
    }
%>
