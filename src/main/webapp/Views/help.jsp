<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Ocean View Resort Management System - Staff Help Guide</title>

	<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/css/bootstrap.min.css" rel="stylesheet">
	<link href="https://fonts.googleapis.com/css2?family=Poppins:wght@300;400;500;600&display=swap" rel="stylesheet">
	<link href="https://fonts.googleapis.com/icon?family=Material+Icons" rel="stylesheet">

	<style>
		
		/* Content */
		.content{
		margin-left:250px;
		padding:30px;
		transition:.3s;
		}
		
		/* Topbar */
		.topbar{
		background:var(--card);
		border-radius:14px;
		padding:18px 25px;
		box-shadow:0 6px 18px rgba(0,0,0,0.08);
		}
		
		/* Help Cards */
		.help-card{
		background:white;
		border-radius:16px;
		padding:35px;
		box-shadow:0 8px 20px rgba(0,0,0,0.07);
		margin-bottom:20px;
		transition:.2s;
		}
		
		.help-card:hover{
		transform:translateY(-2px);
		box-shadow:0 12px 25px rgba(0,0,0,0.12);
		}
		
		.help-card h5{
		display:flex;
		align-items:center;
		gap:15px;
		font-weight:600;
		}
		
		.help-card p{
		margin-top:10px;
		color:#555;
		line-height:1.6;
		}
		
		/* Steps List */
		.steps-list{
		list-style-type: decimal;
		padding-left:20px;
		}
		
		.steps-list li{
		margin-bottom:10px;
		}

	</style>

</head>
<body>
	<div class="content">
		<div class="row">
            <jsp:include page="sidebar.jsp" />
		<!-- Topbar -->
		  <div class="topbar d-flex justify-content-between align-items-center mb-4">
		    <h4 class="mb-0">Staff Help Guide</h4>
		    <div class="text-muted d-flex align-items-center">
		       <span class="material-icons me-2">support_agent</span>
		       Admin Support
		    </div>
		  </div>
		
		  <!-- Help Sections -->
		
		  <!-- Login Section -->
		  <div class="help-card">
		    <h5><span class="material-icons">login</span>Login</h5>
		    <p>
		      Enter your valid staff credentials to access the system. 
		      Make sure your username and password are kept confidential. 
		      If you enter incorrect credentials, the system will deny access.
		    </p>
		  </div>
		
		  <!-- Check Availability -->
		  <div class="help-card">
		    <h5><span class="material-icons">search</span>Check Room Availability</h5>
		    <p>Before booking any room, verify availability by selecting:
		      <ul class="steps-list">
		        <li>Check-in date</li>
		        <li>Check-out date</li>
		        <li>Room type (Single, Double, Deluxe, Suite)</li>
		      </ul>
		      Click the "Check" button to view available rooms. 
		      This helps prevent double-booking and conflicts.
		    </p>
		  </div>
		
		  <!-- New Reservation -->
		  <div class="help-card">
		    <h5><span class="material-icons">event_available</span>Create New Reservation</h5>
		    <p>
		      Once availability is confirmed, fill in the reservation form:
		      <ul class="steps-list">
		        <li>Guest Name</li>
		        <li>Address</li>
		        <li>Contact Number</li>
		        <li>Check-in & Check-out Dates</li>
		        <li>Room Number (from available rooms)</li>
		      </ul>
		      Click "Confirm Reservation" to save the booking.
		    </p>
		  </div>
		
		  <!-- Search Reservation -->
		  <div class="help-card">
		    <h5><span class="material-icons">manage_search</span>Search Reservation</h5>
		    <p>
		      To view or verify any existing booking:
		      <ul class="steps-list">
		        <li>Enter the Reservation Number</li>
		        <li>Click "Search"</li>
		      </ul>
		      You can check booking details before checkout or updates.
		    </p>
		  </div>
		
		  <!-- Checkout -->
		  <div class="help-card">
		    <h5><span class="material-icons">receipt_long</span>Checkout & Billing</h5>
		    <p>
		      After the guest's stay:
		      <ul class="steps-list">
		        <li>Enter the reservation number</li>
		        <li>Click "Generate Bill"</li>
		        <li>Confirm the billing and complete checkout</li>
		      </ul>
		      Make sure all room charges and services are correctly billed.
		    </p>
		  </div>
		
		  <!-- Manage Rooms -->
		  <div class="help-card">
		    <h5><span class="material-icons">meeting_room</span>Manage Rooms</h5>
		    <p>
		      View all rooms and monitor their status:
		      <ul class="steps-list">
		        <li>Check which rooms are Available or Occupied</li>
		        <li>Update room status if necessary</li>
		        <li>Ensure records are always accurate</li>
		      </ul>
		    </p>
		  </div>
		
		  <!-- Tips Section -->
		  <div class="help-card">
		    <h5><span class="material-icons">tips_and_updates</span>Tips for New Staff</h5>
		    <ul class="steps-list">
		      <li>Always check room availability before creating a reservation.</li>
		      <li>Double-check dates and room numbers to avoid conflicts.</li>
		      <li>Use search to verify existing reservations before checkout.</li>
		      <li>Update room status promptly after checkout.</li>
		      <li>Keep guest information accurate and confidential.</li>
		    </ul>
		  </div>
		
		</div>
</div>
</body>
</html>