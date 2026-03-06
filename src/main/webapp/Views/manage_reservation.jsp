<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.util.List" %>
<%@ page import="com.OceanViewResort.Model.Reservation" %>


<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Ocean View Resort Management System - Manage Reservations</title>
    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css">
    
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
	</style>
    
</head>
<body>
    <div class="container-fluid">
        <div class="row">
            <jsp:include page="sidebar.jsp" />

            <div class="col-md-10 p-4 content">
                <h2>Manage Reservations</h2>
                <hr>

                <% if (request.getAttribute("message") != null) { %>
                    <div class="alert alert-success">${message}</div>
                <% } %>

                <!-- Search -->
                <form action="manageReservation" method="post" class="row g-3 mb-4">
                    <div class="col-md-4">
                        <input type="text" name="searchTerm" class="form-control" 
                               placeholder="Search by Reservation ID" 
                               value="${searchTerm}">
                    </div>
                    <div class="col-md-2">
                        <button type="submit" class="btn btn-primary">Search</button>
                        <a href="manageReservation" class="btn btn-secondary">Reset</a>
                    </div>
                </form>

                <!-- View Reservation Detail -->
                <%
                    Reservation viewRes = (Reservation) request.getAttribute("viewReservation");
                    if (viewRes != null) {
                %>
                    <div class="card mb-4">
                        <div class="card-header bg-info text-white">
                            <h5>Reservation #<%= viewRes.getReservationId() %> Details</h5>
                        </div>
                        <div class="card-body">
                            <div class="row">
                                <div class="col-md-6">
                                    <p><strong>Guest:</strong> <%= viewRes.getGuestName() %></p>
                                    <p><strong>Room:</strong> <%= viewRes.getRoomNumber() %> (<%= viewRes.getRoomType() %>)</p>
                                    <p><strong>Check-in:</strong> <%= viewRes.getCheckInDate() %></p>
                                </div>
                                <div class="col-md-6">
                                    <p><strong>Check-out:</strong> <%= viewRes.getCheckOutDate() %></p>
                                    <p><strong>Total Amount:</strong> $<%= String.format("%.2f", viewRes.getTotalAmount()) %></p>
                                    <p><strong>Status:</strong> 
                                        <span class="badge <%= "Active".equals(viewRes.getStatus()) ? "bg-success" : 
                                                              "Checked-Out".equals(viewRes.getStatus()) ? "bg-secondary" : "bg-danger" %>">
                                            <%= viewRes.getStatus() %>
                                        </span>
                                    </p>
                                </div>
                            </div>
                        </div>
                    </div>
                <% } %>

                <!-- Reservations Table -->
                <table class="table table-bordered table-striped">
                    <thead class="table-dark">
                        <tr>
                            <th>Res. ID</th>
                            <th>Guest Name</th>
                            <th>Room</th>
                            <th>Check-in</th>
                            <th>Check-out</th>
                            <th>Amount</th>
                            <th>Status</th>
                            <th>Actions</th>
                        </tr>
                    </thead>
                    <tbody>
                        <%
                            List<Reservation> reservations = (List<Reservation>) request.getAttribute("reservations");
                            if (reservations != null && !reservations.isEmpty()) {
                                for (Reservation r : reservations) {
                        %>
                            <tr>
                                <td>#<%= r.getReservationId() %></td>
                                <td><%= r.getGuestName() %></td>
                                <td><%= r.getRoomNumber() %> (<%= r.getRoomType() %>)</td>
                                <td><%= r.getCheckInDate() %></td>
                                <td><%= r.getCheckOutDate() %></td>
                                <td>$<%= String.format("%.2f", r.getTotalAmount()) %></td>
                                <td>
                                    <span class="badge <%= "Active".equals(r.getStatus()) ? "bg-success" : 
                                                          "Checked-Out".equals(r.getStatus()) ? "bg-secondary" : "bg-danger" %>">
                                        <%= r.getStatus() %>
                                    </span>
                                </td>
                                <td>
                                    <a href="manageReservation?action=view&id=<%= r.getReservationId() %>" 
                                       class="btn btn-sm btn-info">View</a>
                                    <% if ("Active".equals(r.getStatus())) { %>
                                        <a href="manageReservation?action=cancel&id=<%= r.getReservationId() %>" 
                                           class="btn btn-sm btn-danger"
                                           onclick="return confirm('Cancel this reservation?')">Cancel</a>
                                    <% } %>
                                </td>
                            </tr>
                        <%
                                }
                            } else {
                        %>
                            <tr><td colspan="8" class="text-center">No reservations found.</td></tr>
                        <% } %>
                    </tbody>
                </table>
            </div>
        </div>
    </div>
</body>
</html>
