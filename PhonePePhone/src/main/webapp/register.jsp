<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="ISO-8859-1">
<title>Insert title here</title>
<link rel = "stylesheet" href = "css/style.css">
</head>
<body>

	 <div class="signup-box">
      <div class="form signup">
        <h1>Signup</h1>
        <form action = "signAction.jsp" method = "post">
        	<label></label>
            <input type = "text" name = "fname" placeholder="First Name">
            <label></label>
            <input type = "text" name = "lname" placeholder="Last Name">
            <label></label>
            <select name = "question">
            <option value = "your favourite car">your favourite car?</option>
            <option value = "your favourite bike">your favourite bike?</option>
            <option value = "your favourite color">your favourite color?</option>
            </select>
            <label></label>
            <input type = "text" name = "Answer" placeholder="Answer" required>
            <label></label>
            <input type = "text" name = "mobileno" placeholder="Mobile no">
            <label></label>
            <input type = "email" name = "email" placeholder="Email">
            <label></label>
            <input type = "password" name = "password" placeholder="Password"><br>
            <label></label>
            <input type = "submit" value="Submit"> 
            <div class="form-link">
                <span>Already have an account?</span> <a href="loginjsp.jsp" class = "Login-link">Login</a>
             </div> 
        </form>
           <div class = "whysign">
    <%
    String msg = request.getParameter("msg");
    if("valid".equals(msg))
    {
    %>	
    <span>Successfully Registered</span>
    <%
    }
    %>
    <%
    if("invalid".equals(msg))
    {
    %>	
    <span>Some thing went wrong!Try again</span>
    <%} %>
    </div>
      </div>
    </div>
   
   
    
</body>
</html>