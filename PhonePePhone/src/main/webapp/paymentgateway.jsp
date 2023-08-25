<%@page import="java.sql.PreparedStatement"%>
<%@page import="java.sql.ResultSet"%>
<%@page import="com.mysql.cj.xdevapi.Result"%>
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
<script src="https://unpkg.com/sweetalert/dist/sweetalert.min.js"></script>

<link rel = "stylesheet" href = css/paymentgateway.css>
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
	<div class = "container-wrapper">
     <div class="payment-container">
        <h2>Payment Details</h2>
        <form id="paymentForm" action = "paymentAction.jsp" method = "post">
            <div class="form-group">
            	<input type = "hidden" name = "paymentmethod" value="card">
                <label for="card-number">Card Number</label>
                <input type="text" id="cardNumber" name="cardNumber" onkeypress="allowOnlyNumbers(event)" oninput="formatCardNumber(this)" 
                 placeholder="1234 5678 9012 3456" maxlength="19" tabindex="1" inputmode="numeric" autocomplete="off" required>
          		<span id="cardNumberError" class="error-message"></span>
            </div>
            <div class="form-group">
                <label for="card-name">Cardholder Name</label>
                <input type="text" id="cardName" name="cardName" placeholder="Name" autocomplete="off" required tabindex="2">
            </div>
            <div class="form-row">
                <div class="form-group">
                    <label for="expiry-date">Expiry Date</label>
                    <input type="text" id="expiryDate" name="expiryDate" placeholder="MM/YY" onkeypress="allowOnlyNumbers(event); formatExpiryDate(event);" maxlength="5" required tabindex="3">
                	<span id="expiryDateError" class="error-message"></span>
                </div>
                <div class="form-group">
                    <label for="cvv">CVV</label>
                    <input type="text" onkeypress="allowOnlyNumbers(event)" id="cvv" name="cvv" placeholder="123" maxlength = "3" pattern = "[0-9]{3}" required tabindex="4">
                	<span id="cvvError" class="error-message"></span>
                </div>
            </div>
            <button class ="payment-button" id="paymentCardButton" type="submit">Pay Now</button><b class = "or" style = "padding-left: 190px">Or</b>
        </form>
        <form action="paymentAction.jsp" method="post">
        <input type = "hidden" name = "paymentmethod" value="cod">
         <button class ="payment-button"onclick="callAlert()">COD</button>
         </form>
    </div>
 <% 
	 String email = session.getAttribute("email").toString();
    try
    {
    	int total = 0;
    	int quantity = 0;
    	Connection con = Connection_Provider.getCon();
    	Statement stmt = con.createStatement();
    	PreparedStatement pstmt = con.prepareStatement("select * from orderdetails.details where email = ? and status is null");
    	pstmt.setString(1, email);
    	ResultSet rs = pstmt.executeQuery();
    	while(rs.next())
    	{
    		quantity = quantity + Integer.parseInt(rs.getString(5));
    		total = total + Integer.parseInt(rs.getString(4))*Integer.parseInt(rs.getString(5));
    	}
    %>
    <div class = "cart-container">
    <div class="cart-summary">
				<h3 class="summarty-title">ORDER SUMMARY</h3>
				<div class="summary-item">
					<span><b>Subtotal:&nbsp;</b></span> <span><%=total%></span>
				</div>
				<div class="summary-item">
					<span><b>No of items:&nbsp;</b></span> <span><%=quantity%></span>
				</div>
				<div class="summary-item">
					<span><b>Estimated Shipping:</b></span> <span>100</span>
				</div>

				<div class="summary-item" style="font-weight: 500; font-size: 24px;">
					<span>Total:</span> <span><%=total%></span>
				</div>
				
	</div>
	</div>
	</div>
	<%
    }catch(Exception e)
    {
    	e.printStackTrace();
    } %>
</body>
<script type="text/javascript">
if(window.history.forward(1)!=null)
	{
		window.history.forward(1);
	}
function callAlert() {
    swal({
        title: "Confirm Order",
        text: "Are you sure you want to place the COD order?",
        icon: "info",
        buttons: true,
        dangerMode: false,
    })
    .then((confirmed) => {
        if (confirmed) {
            window.location.href = "index.jsp"; 
        }
    });
}
    function allowOnlyNumbers(event) {
        const key = event.keyCode || event.which;
        const keyChar = String.fromCharCode(key);
        const pattern = /^\d+$/;

        if (!pattern.test(keyChar)) {
            event.preventDefault();
        }
    }

    function formatExpiryDate(event) {
        const input = event.target;
        const inputValue = input.value;

        if (inputValue.length === 2 && inputValue.indexOf("/") === -1) {
            input.value = inputValue + "/";
        }
    }
    function validateFields() {
        var cardNumber = document.getElementById('cardNumber').value;
        var expiryDate = document.getElementById('expiryDate').value;
        var cvv = document.getElementById('cvv').value;

        var cardNumberError = document.getElementById('cardNumberError');
        var expiryDateError = document.getElementById('expiryDateError');
        var cvvError = document.getElementById('cvvError');

        var isValid = true;
        // Validate card number and update error message
        if (!validateCardNumber(cardNumber)) {
            isValid = false;
            cardNumberError.textContent = 'Card number must be 16 digits';
        } else {
            cardNumberError.textContent = '';
        }

        // Validate expiry date and update error message
        if (!validateExpiryDate(expiryDate)) {
            isValid = false;
            expiryDateError.textContent = 'Please enter a valid expiration date';
        } else {
            expiryDateError.textContent = '';
        }

        // Validate CVV and update error message
        if (!validateCVV(cvv)) {
            isValid = false;
            cvvError.textContent = 'CVV must be 3 digits';
        } else {
            cvvError.textContent = '';
        }

        return isValid;
    }

    document.addEventListener('DOMContentLoaded', function () {
        document.getElementById('paymentForm').addEventListener('submit', function (event) {
            event.preventDefault();

            if (validateFields()) {
            	if(confirm('Are you sure you want to proceed with Debit Card?')){
            		document.getElementById('paymentForm').submit();	
            	}
            }
        });
    });

    function validateCardNumber(cardNumber) {
        return cardNumber.length === 19;
    }

    function validateExpiryDate(expiryDate) {
        var parts = expiryDate.split('/');
        var enteredMonth = parseInt(parts[0], 10);
        var enteredYear = parseInt(parts[1], 10);

        var today = new Date();
        var currentMonth = today.getMonth() + 1;
        var currentYear = today.getFullYear() % 100;

        
        return (
            enteredMonth >= 1 && enteredMonth <= 12 &&
            enteredYear >= currentYear && (enteredYear > currentYear || enteredMonth >= currentMonth)
        );
    }

    function validateCVV(cvv) {
        return cvv.length === 3;
    }
    function formatCardNumber(input) {
        // Remove any spaces from the current value
        let value = input.value.replace(/\s/g, '');

        // Create an array to store the formatted groups
        let groups = [];

        // Split the value into groups of 4 characters each
        for (let i = 0; i < value.length; i += 4) {
            groups.push(value.substr(i, 4));
        }

        // Join the groups with spaces and set the formatted value in the input
        input.value = groups.join(' ');
    }


</script>
</html>

