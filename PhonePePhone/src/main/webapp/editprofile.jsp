<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<!DOCTYPE html>
<html>
<head>
    <title>Change Password</title>
    <style>
        body {
            font-family: Arial, sans-serif;
            background-color: #f1f1f1;
        }
        .change-password-container {
            width: 400px;
            height:500px;
            margin: 0 auto;
            background-color: white;
            padding: 20px;
            border-radius: 5px;
            box-shadow: 0 0 10px rgba(0, 0, 0, 0.1);
        }
        .change-password-container h2 {
            text-align: center;
            margin-bottom: 20px;
        }
        .input-group {
            margin: 45px 0;
            position: relative;
        }
        .input-group label {
            display: block;
            margin-bottom: 5px;
            font-weight: bold;
        }
        .input-group input {
            width: 90%;
            padding: 10px;
            border: 1px solid #ccc;
            border-radius: 3px;
        }
        .input-group .eye-icon {
            display: inline;
            position: absolute;
            top: 65%;
            right: 28px;
            transform: translateY(-50%);
            cursor: pointer;
        }
        .btn-group {
            text-align: center;
        }
        .btn-group button {
            padding: 10px 20px;
            background-color: #007bff;
            color: white;
            border: none;
            border-radius: 3px;
            cursor: pointer;
        }
        .btn-group button.cancel {
            background-color: red;
            margin-left: 10px;
            
        }
        .change-password-container .valid , .change-password-container .invalid
        {
        	color: green;
        	font-weight: bold;
        	margin: 20px;
        	display: flex;
        	justify-content: center;
        }
        .change-password-container .invalid
        {
        	color: red;
        }
    </style>
</head>
<body>
	<%
		String email = session.getAttribute("email").toString();
	%>
    <div class="change-password-container">
        <h2>Change Password</h2>
        <form action="editprofileAction.jsp" method="post">
            <div class="input-group">
            <input type = "hidden" name = "email" value = <%=email%>>
                <label for="currentPassword">Current Password:</label>
                <input type="password" id="currentPassword" name="currentPassword" required>
                <span class="eye-icon" id="currentPasswordEye">&#128065;</span>
            </div>
            <div class="input-group">
                <label for="newPassword">New Password:</label>
                <input type="password" id="newPassword" name="newPassword" required>
                <span class="eye-icon" id="newPasswordEye">&#128065;</span>
            </div>
            <div class="input-group">
                <label for="confirmPassword">Confirm Password:</label>
                <input type="password" id="confirmPassword" name="confirmPassword" required>
                <span class="eye-icon" id="confirmPasswordEye">&#128065;</span>
            </div>
            <div class="btn-group">
                <button type="submit">Change Password</button>
                <button type="button" class="cancel" onclick="window.location.href='index.jsp'">Cancel</button>
            </div>
        </form>
         <%
    String msg = request.getParameter("msg");
    if("success".equals(msg))
    {
    %>	
    <span class = "valid">Password changed successfully</span>
    <%
    }
    %>
    <%
    if("error".equals(msg))
    {
    %>	
    <span class = "invalid">incorrect current password</span>
    <%} 
     if("cancel".equals(msg))
    {
    %>	
    <span class = "invalid">new password and confirm password doesn't match</span>
    <%} %>
    </div>
    <script>
        const eyeIcons = document.querySelectorAll('.eye-icon');
        eyeIcons.forEach(icon => {
            icon.addEventListener('click', () => {
                const inputField = icon.previousElementSibling;
                if (inputField.type === 'password') {
                    inputField.type = 'text';
                    icon.innerHTML = '&#128064;';
                } else {
                    inputField.type = 'password';
                    icon.innerHTML = '&#128065;';
                }
            });
        });
    </script>
</body>
</html>
