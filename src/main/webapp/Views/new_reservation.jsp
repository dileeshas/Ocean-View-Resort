<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="com.OceanViewResort.Model.Room" %>

<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Ocean View Resort Management System - New Reservation</title>
    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css">
    
    <style>
		.content {
		    margin-left: 250px;
		    padding: 30px !important;
		}
		
		.form-control::placeholder {
		    color: #9ca3af; 
		    font-size: 0.9rem; 
		    opacity: 1;
		}
		
		@media(max-width:992px){
		    .content {
		        margin-left: 0;
		        padding: 15px !important;
		    }
		}
	</style>
    
</head>
<body>
    <div class="container-fluid">
        <div class="row">
            <jsp:include page="sidebar.jsp" />

            <div class="col-md-10 p-4 content">
                <h2>New Reservation</h2>
                <hr>

                <% if (request.getAttribute("success") != null) { %>
                    <div class="alert alert-success">
                        <h4><%= request.getAttribute("success") %></h4>
                        <p><strong>Reservation ID:</strong> #${reservationId}</p>
                        <p><strong>Guest:</strong> ${guestName}</p>
                        <p><strong>Room:</strong> ${roomNumber} (${roomType})</p>
                        <p><strong>Check-in:</strong> ${checkIn} | <strong>Check-out:</strong> ${checkOut}</p>
                        <p><strong>Nights:</strong> ${nights} | <strong>Total:</strong> $${totalAmount}</p>
                        <a href="dashboard" class="btn btn-primary">Back to Dashboard</a>
                        <a href="newReservation" class="btn btn-success">New Reservation</a>
                    </div>
                <% } else { %>

                    <%
                        Room selectedRoom = (Room) request.getAttribute("selectedRoom");
                    %>

                    <form action="newReservation" method="post" class="row g-3">
                        <h5>Guest Details</h5>
                        <div class="col-md-4">
                            <label class="form-label">Guest Name</label>
                            <input type="text" name="guestName" class="form-control" required placeholder="Guest Name">
                        </div>
                        <div class="col-md-4">
                            <label class="form-label">Address</label>
                            <input type="text" name="address" class="form-control" required placeholder="Address">
                        </div>
                        <div class="col-md-4">
						    <label class="form-label">Contact Number</label>
						    <input type="text" name="contactNumber" class="form-control"
						           required
						           placeholder="+94 XX XXX XXXX"
						           pattern="(\+94|0)[0-9]{9}"
						           title="Enter a valid Sri Lankan phone number (e.g., 0771234567 or +94771234567)">
						</div>   
                        <div class="col-md-4">
						    <label class="form-label">E-mail</label>
						    <input type="email" name="email" class="form-control"
						           required
						           placeholder="example@email.com"
						           pattern="[a-z0-9._%+-]+@[a-z0-9.-]+\.[a-z]{2,}$"
						           title="Enter a valid email address">
						</div>             

                        <h5 class="mt-3">Room & Stay Details</h5>

                        <% if (selectedRoom != null) { %>
                            <input type="hidden" name="roomId" value="<%= selectedRoom.getRoomId() %>">
                            <div class="col-md-3">
                                <label class="form-label">Room</label>
                                <input type="text" class="form-control" 
                                       value="<%= selectedRoom.getRoomNumber() %> (<%= selectedRoom.getRoomType() %>)" readonly>
                            </div>
                            <div class="col-md-3">
                                <label class="form-label">Price/Night</label>
                                <input type="text" class="form-control" 
                                       value="$<%= String.format("%.2f", selectedRoom.getPricePerNight()) %>" readonly>
                            </div>
                            <div class="col-md-3">
                                <label class="form-label">Check-in Date</label>
                                <input type="date" name="checkIn" class="form-control" value="${checkIn}" required>
                            </div>
                            <div class="col-md-3">
                                <label class="form-label">Check-out Date</label>
                                <input type="date" name="checkOut" class="form-control" value="${checkOut}" required>
                            </div>

                            <% if (request.getAttribute("nights") != null) { %>
                                <div class="col-md-3">
                                    <label class="form-label">Nights</label>
                                    <input type="text" class="form-control" value="${nights}" readonly>
                                </div>
                                <div class="col-md-3">
                                    <label class="form-label">Total Amount</label>
                                    <input type="text" class="form-control" value="$${totalAmount}" readonly>
                                </div>
                            <% } %>
                        <% } else { %>
                            <div class="col-12">
                                <div class="alert alert-info">
                                    Please <a href="checkAvailability">check availability</a> first to select a room.
                                </div>
                            </div>
                        <% } %>

                        <%{ %>
                            <div class="col-12 mt-3">
                                <button type="submit" class="btn btn-success btn-lg">Confirm Reservation</button>
                                <a href="checkAvailability" class="btn btn-secondary btn-lg ms-2">Back</a>
                            </div>
                        <% } %>
                    </form>
                <% } %>
            </div>
        </div>
    </div>
</body>
</html>
