<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="ISO-8859-1">
<title>Insert title here</title>
<link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css" 
    integrity="sha512-iecdLmaskl7CVkqkXNQ/ZH/XLlvWZOJyj7Yy7tcenmpD1ypASozpmT/E0iPtmFIB46ZmdtAc9eNBvH0H/ZpiBw==" crossorigin="anonymous" referrerpolicy="no-referrer" />
   
<link rel= "stylesheet" href = "css/style.css">
  <script>
    // JavaScript to toggle dropdown on click
    document.addEventListener("DOMContentLoaded", function () {
        const dropdowns = document.querySelectorAll(".dropdown");
        dropdowns.forEach((dropdown) => {
            const toggle = dropdown.querySelector("a");
            const menu = dropdown.querySelector("ul");
            toggle.addEventListener("click", (e) => {
                e.preventDefault();
                menu.classList.toggle("show");
            });
        });

        // Close dropdowns when clicking outside
        window.addEventListener("click", (e) => {
            dropdowns.forEach((dropdown) => {
                if (!dropdown.contains(e.target)) {
                    const menu = dropdown.querySelector("ul");
                    menu.classList.remove("show");
                }
            });
        });
    });
</script>
</head>
<body>
	<nav class="navbar">
        <div class="logo">Phone pe Phone</div>
        <ul class="menu">
       		<li class="dropdown">
                <a href="#">My Profile <i class="fas fa-caret-down"></i></a>
                <ul>
                    <li><a href="profiledetails.jsp">View Profile</a></li>
                    <li><a href="editprofile.jsp">Edit Password</a></li>
                    <!-- Add more dropdown items as needed -->
                </ul>
            </li>
            <li><a href = "index.jsp" class="active">Home</a></li>
            <li><a href = "">About us</a></li>
            <li><a href = "logout.jsp">Logout</a></li>
            <li><a href = "cart.jsp"><i class="fa-solid fa-cart-shopping"></i></a></li>
        </ul> 
        <div class="menu-btn">
            <i class="fa fa-bars"></i>
        </div>
    </nav>
  
</body>
</html>