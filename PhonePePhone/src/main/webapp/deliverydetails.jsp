<!DOCTYPE html>
<html>
<head>
    <title>Delivery Details</title>
    <link rel="stylesheet" href="css/style.css">
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
<%
int productid = 0;
String action = request.getParameter("action");
System.out.println(action);
if (action.equals("buynow")){
    productid = Integer.parseInt(request.getParameter("id"));
}
%>
    <div class="container-details">
        <h2>Delivery Details</h2>
        <form action="<%= (action.equals("buynow") ? "detailsAction.jsp" : "checkout.jsp") %>" method="post">
            <div class="form-group">
                <label for="fullname">Full Name</label>
                <input type = "hidden" name = "id" value = <%=productid %>>
                 <input type = "hidden" name = "action" value = <%=action %>>
                <input type="text" id="fullname" name="fullname" required>
            </div>
            <div class="form-group">
                <label for="address">Address</label>
                <textarea id="address" name="address" required></textarea>
            </div>
            <div class="form-group">
            	<label for="mobileno">Mobile No</label>
            	<input type="text" name = "mobileno" required>
            </div>
            <div class="form-row">
                <div class="form-group">
                    <label for="city">City</label>
                    <input type="text" id="city" name="city" required>
                </div>
                <div class="form-group2">
                    <label for="pincode">Pincode</label>
                    <input type="text" name="pincode" required>
                </div>
            </div>
            <div class="form-row">
                <div class="form-group">
                    <label for="State">State</label>
                    <input type="text" name="state" required>
                </div>
                <div class="form-group2">
                     <label for="country">Country</label>
                <select id="country" name="country" required>
                    <option value="" selected disabled>Select Country</option>
                    <option value="INDIA">India</option>
                    <!-- Add more countries as needed -->
                </select>
                </div>
            </div>
            <button class= "proceed-payment" type="submit">Proceed to Payment</button>
        </form>
    </div>
</body>
</html>
