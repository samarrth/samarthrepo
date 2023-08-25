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
	<section class="container-form">
        <div class="form-signup">
            <div class="form-content">
                <header>Reset password</header>
                <form action="signinAction.jsp" method = "post">
                    <div class="field input-field">
                        <input type = "email" placeholder="Email" name = "email" class = "input">
                    </div>
                    <div class="field input-field">
                        <select name = "question">
                        <option value = "your favourite car">your favourite car?</option>
                        <option value = "your favourite bike">your favourite bike?</option>
                        <option value = "your favourite color">your favourite color?</option>
                        </select>
                    </div>
                     <div class = "field input-field">
                        <input type = "text" name = "Answer"placeholder="Answer" required>
                    </div>
                    <div class = "field input-field">
                        <input type = "password" placeholder="Enter new password" name = "password" class = "password">
                    </div>
                    <div class="field input-field">
                        <input type="password" placeholder="Confirm password" name = "conpass" class="password">
                    </div>
              
                    <div class="form-link">
                       <span>Go back to Login page:-</span> <a href="loginjsp.jsp" class = "Login-link">Login</a>
                    </div>
                    <div class="field button-field">
                        <input type = "submit" value = "save">
                    </div>
                </form>
            </div>
            <%
            String msg = request.getParameter("msg");
            if("done".equals(msg))
            {
            %>
            <h1>Password Changed Successfully</h1>
            <%} 
            %>
            <%
            if("invalid".equals(msg))
            {
            %>
            <h2>Something went wrong</h2>
            <%
            }
            %>

        </div>
    </section>
</body>
</html>