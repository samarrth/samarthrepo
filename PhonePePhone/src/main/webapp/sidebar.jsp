<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="ISO-8859-1">
<title>Insert title here</title>
   <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css" 
    integrity="sha512-iecdLmaskl7CVkqkXNQ/ZH/XLlvWZOJyj7Yy7tcenmpD1ypASozpmT/E0iPtmFIB46ZmdtAc9eNBvH0H/ZpiBw==" crossorigin="anonymous" referrerpolicy="no-referrer" />
    <script src="https://cdnjs.cloudflare.com/ajax/libs/jquery/3.7.0/jquery.min.js" 
    integrity="sha512-3gJwYpMe3QewGELv8k/BX9vcqhryRdzRMxVfq6ngyWXwo03GFEzjsUm8Q7RZcHPHksttq7/GFoxjCVUjkjvPdw==" crossorigin="anonymous" referrerpolicy="no-referrer"></script>
    <link rel="stylesheet" href="css/newstyle.css">
</head>
<body>
	 <div class="sidebar">
            <div class="sidebarWrapper">
                <div class="sidebarMenu">
                    <h3 class="sidebarTitle">Dashboard</h3>
                    <ul class="sidebarList">
                        <li class="sidebarListItem">
                            <a href = "admin.jsp"><i class="fa-solid fa-user"></i>Users
                       </a></li>
                        <li class="sidebarListItem">
                            <a href = "adminproduct.jsp"><i class="fa-solid fa-box-open"></i>Products
                        </a></li>
                        <li class="sidebarListItem">
                            <a href = "adminorders.jsp"><i class="fa-solid fa-bag-shopping"></i> Orders
                       	</a> </li>
                        <li class="sidebarListItem">
                            <a href = "deliveredorder.jsp"><i class="fa-solid fa-truck"></i>Orders delivered
                       	</a> </li>
                        <li class="sidebarListItem">
                            <a href = "canceledorder.jsp"><i class="fa-solid fa-ban"></i> Orders cancelled
                       	</a> </li>

                    </ul>
                </div>
            </div>
        </div>
</body>
</html>