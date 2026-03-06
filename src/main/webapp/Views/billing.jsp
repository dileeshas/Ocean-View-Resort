<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="com.OceanViewResort.Model.Reservation" %>
<%@ page import="com.OceanViewResort.Model.Guest" %>

<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Ocean View Resort Management System - Billing & Print</title>
    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css">
    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.10.5/font/bootstrap-icons.css">
    <style>
		.content {
		    margin-left: 250px;
		    padding: 30px !important;
		}
		
		@media(max-width:992px){
		    .content {
		        margin-left: 0;
		        padding: 15px !important;
		    }
		}
        @media print {
            .no-print { display: none !important; }
            .print-area { border: none !important; }
        }

    </style>
</head>
<body>
    <div class="container-fluid">
        <div class="row">
            <jsp:include page="sidebar.jsp" />

            <div class="col-md-10 p-4 content">
                <h2 class="no-print">Billing & Print</h2>
                <hr class="no-print">

                <% 
                    String error = (String) request.getAttribute("error");
                    if (error != null) { 
                %>
                    <div class="alert alert-danger no-print"><%= error %></div>
                <% } %>

                <%
                    String checkoutSuccess = (String) request.getAttribute("checkoutSuccess");
                    if (checkoutSuccess != null) {
                %>
                    <div class="alert alert-success no-print"><%= checkoutSuccess %></div>
                <% } %>

                <!-- Search Reservation -->
                <div class="no-print">
                    <form action="billing" method="post" class="row g-3 mb-4">
                        <input type="hidden" name="action" value="search">
                        <div class="col-md-4">
                            <label class="form-label">Enter Reservation ID</label>
                            <input type="number" name="reservationId" class="form-control" 
                                   placeholder="e.g., 1" required>
                        </div>
                        <div class="col-md-2 d-flex align-items-end">
                            <button type="submit" class="btn btn-primary">Search</button>
                        </div>
                    </form>
                </div>

                <!-- Invoice Display -->
                <%
                    Reservation reservation = (Reservation) request.getAttribute("reservation");
                    Guest guest = (Guest) request.getAttribute("guest");
                    Long nights = (Long) request.getAttribute("nights");
                    if (reservation != null && guest != null) {
                %>
                    <div class="card print-area" id="invoice">
                        <div class="card-header text-center bg-dark text-white">
                            <h3>Ocean View Resort Management System</h3>
                            <p class="mb-0">Invoice / Bill</p>
                        </div>
                        <div class="card-body">
                            <div class="row mb-3">
                                <div class="col-md-6">
                                    <h5>Guest Information</h5>
                                    <p><strong>Name:</strong> <%= guest.getName() %></p>
                                    <p><strong>Address:</strong> <%= guest.getAddress() %></p>
                                    <p><strong>Contact:</strong> <%= guest.getContactNumber() %></p>
                                </div>

                            <table class="table table-bordered">
                                <thead class="table-light">
                                    <tr>
                                        <th>Description</th>
                                        <th>Check-in</th>
                                        <th>Check-out</th>
                                        <th>Nights</th>
                                        <th>Rate/Night</th>
                                        <th>Total</th>
                                    </tr>
                                </thead>
                                <tbody>
                                    <tr>
                                        <td>Room <%= reservation.getRoomNumber() %> (<%= reservation.getRoomType() %>)</td>
                                        <td><%= reservation.getCheckInDate() %></td>
                                        <td><%= reservation.getCheckOutDate() %></td>
                                        <td><%= nights != null ? nights : 0 %></td>
                                        <td>$<%= (nights != null && nights > 0) ? String.format("%.2f", reservation.getTotalAmount() / nights) : "0.00" %></td>
                                        <td><strong>$<%= String.format("%.2f", reservation.getTotalAmount()) %></strong></td>
                                    </tr>
                                </tbody>
                            </table>

                            <div class="text-center mt-3">
                                <p><em>Thank you for staying with us!</em></p>
                            </div>
                        </div>
                    </div>
                    
                    <c:if test="${not empty emailSuccess}">
					    <div class="alert alert-success">
					        ${emailSuccess}
					    </div>
					</c:if>

                    <!-- Action Buttons -->
					<div class="mt-3 d-flex justify-content-end gap-2">
						<div class="no-print">
					    <button onclick="window.print()" class="btn btn-primary btn-lg">
					        <i class="bi bi-printer"></i> Print Invoice
					    </button>
					    
					    
					    <form action="billing" method="post" style="display:inline;">
						    <input type="hidden" name="action" value="sendInvoice">
						    <input type="hidden" name="reservationId" value="<%= reservation.getReservationId() %>">
						    <button type="submit" class="btn btn-primary btn-lg">
						        <i class="bi bi-envelope"></i> Email Invoice
						    </button>
						</form>
					
					    <% if ("Active".equals(reservation.getStatus())) { %>
					        <form action="billing" method="post" style="display:inline;">
					            <input type="hidden" name="action" value="checkout">
					            <input type="hidden" name="reservationId" value="<%= reservation.getReservationId() %>">
					            <button type="submit" class="btn btn-warning btn-lg"
					                    onclick="return confirm('Check out this guest and free up the room?')">
					                <i class="bi bi-door-open"></i> Check Out Guest
					            </button>
					        </form>
					    <% } %>
					</div>
                <% } %>
                </div>
            </div>
        </div>
    </div>
</body>
</html>