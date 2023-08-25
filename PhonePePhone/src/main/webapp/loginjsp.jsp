<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
	pageEncoding="ISO-8859-1"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="ISO-8859-1">
<title>Insert title here</title>
<link rel="stylesheet" href="css/style.css">
</head>
<body>

	<section class="container forms">
		<div class="form login">
			<div class="form-content">
				<header>Login</header>
				<form action="loginAction.jsp" method="post">
					<div class="field input-field">
						<input type="email" placeholder="Email" name="email" class="input" autocomplete="off">
					</div>
					<div class="field input-field">
						<input type="password" placeholder="Password" name="password"
							class="password" autocomplete="off"> 
					</div>
					<div class="form-link">
						<a href="signin.jsp" class="forgot-pass">Forgot password?</a>
					</div>
					<div class="field button-field">
						<input type="submit" value="login">
					</div>
				</form>

				<div class="form-link">
					<span>Don't have an account?<a href="register.jsp"
						class="signup-link">Signup</a></span>
				</div>
				 <%
                String msg = request.getParameter("msg");
                if("notexist".equals(msg))
                {
                %>
                <span class="incorrect-login">Incorrect Username or Password</span>
                <%} %>
                <%if("invalid".equals(msg)) 
                {
                %>
                <h1>Something went wrong</h1>
               <% }%>
			</div>
		</div>







	</section>
</body>
</html>