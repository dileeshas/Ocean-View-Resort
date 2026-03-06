<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="en">
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<title>Ocean View Resort Management System</title>

<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/css/bootstrap.min.css" rel="stylesheet">
<link href="https://fonts.googleapis.com/css2?family=Poppins:wght@300;400;500;600&display=swap" rel="stylesheet">
<link href="https://fonts.googleapis.com/icon?family=Material+Icons" rel="stylesheet">


<style>
:root{
--primary:#99c9db;
--primary-dark:#1e71a8;
--bg:#f4f8fc;
--text:#2c3e50;
}

body{
font-family:Poppins,sans-serif;
background:var(--bg);
color:var(--text);
margin:0;
}

/*logo*/
.logo-box{
display:flex;
justify-content:center;
align-items:center;
padding:10px 0 20px;
}

.logo{
width:150px;
height:100px;
}


/* Sidebar */
.sidebar{
height:100vh;
background:linear-gradient(180deg,var(--primary),var(--primary-dark));
color:white;
position:fixed;
width:250px;
top:0;
left:0;
transition:.3s;
text:white;
}

.sidebar .nav-link{
color:#eaf6ff;
padding:12px 18px;
border-radius:10px;
margin:4px 8px;
display:flex;
align-items:center;
transition:.2s;
text-decoration:none;
color: white !important; 
}

.sidebar .nav-link:hover{
background:rgba(255,255,255,.15);
transform:translateX(4px);
}

.sidebar .nav-link.active{
color:var(--primary);
font-weight:500;
}

/* Content */
.content{
margin-left:250px;
padding:20px;
}

/* Mobile */
@media(max-width:992px){
.sidebar{
left:-260px;
}
.sidebar.show{
left:0;
}
.content{
margin-left:0;
}
}
</style>

</head>

<body>

<!-- Sidebar -->
<div class="sidebar d-flex flex-column p-3" id="slidebar" >

<div class="logo-box">
    <img src="<%= request.getContextPath() %>/images/logo1.png" alt="Resort Logo" class="logo">
  </div>
  
	<nav class="nav flex-column"> </nav>
		<a class="nav-link active" href="<%= request.getContextPath() %>/dashboard">
			<span class="material-icons me-3">dashboard</span>Dashboard
		</a>
		
		<a class="nav-link active" href="<%= request.getContextPath() %>/checkAvailability">
			<span class="material-icons me-3">search</span>Check Availability
		</a>
		
		<a class="nav-link active" href="<%= request.getContextPath() %>/newReservation">
			<span class="material-icons me-3">event_available</span>New Reservation
		</a>
		
		<a class="nav-link active" href="<%= request.getContextPath() %>/manageReservation">
			<span class="material-icons me-3">manage_search</span>Manage Reservation
		</a>
		
		<a class="nav-link active" href="<%= request.getContextPath() %>/manageRooms">
			<span class="material-icons me-3">meeting_room</span>Manage Rooms
		</a>
		
		<a class="nav-link active" href="<%= request.getContextPath() %>/billing">
			<span class="material-icons me-3">receipt_long</span>Billing and Check Out
		</a>
		
		<a class="nav-link active" href="<%= request.getContextPath() %>/Views/help.jsp">
			<span class="material-icons me-3">help</span>Help
		</a>
		
		<a class="nav-link active" href="<%= request.getContextPath() %>/logout">
			<span class="material-icons me-3">logout</span>Logout
		</a>
		
</div>

</body>
</html>