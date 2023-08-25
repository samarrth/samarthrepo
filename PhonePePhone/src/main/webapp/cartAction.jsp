<%@page import="java.io.InputStream"%>
<%@page import="java.io.FileOutputStream"%>
<%@page import="javax.lang.model.element.QualifiedNameable"%>
<%@page import="project.Connection_Provider"%>
<%@page import="java.sql.*"%>
<% 

int quantity = 1;
int productprice = 0;
int subtotal = 0;
int shipping = 0;
int total = 0;
int z = 0;
String email = session.getAttribute("email").toString();
String productid = request.getParameter("id");
try
{
    Connection con = Connection_Provider.getCon();
    PreparedStatement pstmt = con.prepareStatement("SELECT * FROM productdetails.details WHERE id = ?");
    pstmt.setString(1, productid);
    ResultSet rs = pstmt.executeQuery();
    while (rs.next())
    {
        productprice = rs.getInt(4);
        subtotal = productprice;
        total = productprice;
    }

    PreparedStatement pstmt1 = con.prepareStatement("SELECT * FROM cartdetails.details WHERE productid = ? AND email = ?");
    pstmt1.setString(1, productid);
    pstmt1.setString(2, email);
    ResultSet rs1 = pstmt1.executeQuery();
    while (rs1.next())
    {
        quantity = rs1.getInt(2);
        quantity = quantity + 1;
        z = 1;
        total = subtotal * quantity;
    }
    if (z == 1)
    {
        System.out.println("update");
        PreparedStatement updateStmt = con.prepareStatement("UPDATE cartdetails.details SET total = ?, quantity = ? WHERE productid = ? AND email = ?");
        updateStmt.setInt(1, total);
        updateStmt.setInt(2, quantity);
        updateStmt.setString(3, productid);
        updateStmt.setString(4, email);
        updateStmt.executeUpdate();
        response.sendRedirect("cart.jsp?msg=exist");
    }

    if (z == 0)
    {
        System.out.println("insert");
        PreparedStatement insertStmt = con.prepareStatement("INSERT INTO cartdetails.details (productid, quantity, subtotal, shipping, total, email) VALUES (?, ?, ?, ?, ?, ?)");
        insertStmt.setString(1, productid);
        insertStmt.setInt(2, quantity);
        insertStmt.setInt(3, subtotal);
        insertStmt.setInt(4, shipping);
        insertStmt.setInt(5, total);
        insertStmt.setString(6, email);
        insertStmt.executeUpdate();
        response.sendRedirect("cart.jsp?msg=added");
    }

    // Close the resources
    rs.close();
    pstmt.close();
    rs1.close();
    pstmt1.close();
    con.close();
}
catch (Exception e)
{
    e.printStackTrace();
}
%>
