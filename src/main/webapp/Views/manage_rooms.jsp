<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.util.List"%>
<%@ page import="com.OceanViewResort.Model.Room" %>

<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Ocean View Resort Management System - Manage Rooms</title>
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
                <h2>Manage Rooms</h2>
                <hr>

                <% if (request.getAttribute("message") != null) { %>
                    <div class="alert alert-success">${message}</div>
                <% } %>

                <!-- Add/Edit Room Form -->
                <%
                    Room editRoom = (Room) request.getAttribute("editRoom");
                %>
                <div class="card mb-4">
                    <div class="card-header bg-dark text-white">
                        <h5><%= editRoom != null ? "Edit Room" : "Add New Room" %></h5>
                    </div>
                    <div class="card-body">
                        <form action="manageRooms" method="post" class="row g-3">
                            <% if (editRoom != null) { %>
                                <input type="hidden" name="roomId" value="<%= editRoom.getRoomId() %>">
                            <% } %>

                            <div class="col-md-3">
                                <label class="form-label">Room Number</label>
                                <input type="text" name="roomNumber" class="form-control" 
                                       value="<%= editRoom != null ? editRoom.getRoomNumber() : "" %>" required>
                            </div>
                            <div class="col-md-3">
                                <label class="form-label">Room Type</label>
                                <select name="roomType" class="form-select" required>
                                    <option value="Single" <%= editRoom != null && "Single".equals(editRoom.getRoomType()) ? "selected" : "" %>>Single</option>
                                    <option value="Double" <%= editRoom != null && "Double".equals(editRoom.getRoomType()) ? "selected" : "" %>>Double</option>
                                    <option value="Suite" <%= editRoom != null && "Suite".equals(editRoom.getRoomType()) ? "selected" : "" %>>Suite</option>
                                    <option value="Deluxe" <%= editRoom != null && "Deluxe".equals(editRoom.getRoomType()) ? "selected" : "" %>>Deluxe</option>
                                </select>
                            </div>
                            <div class="col-md-3">
                                <label class="form-label">Price/Night ($)</label>
                                <input type="number" step="0.01" name="pricePerNight" class="form-control" 
                                       value="<%= editRoom != null ? editRoom.getPricePerNight() : "" %>" required>
                            </div>
                            <div class="col-md-3">
                                <label class="form-label">Status</label>
                                <select name="status" class="form-select" required>
                                    <option value="Available" <%= editRoom != null && "Available".equals(editRoom.getStatus()) ? "selected" : "" %>>Available</option>
                                    <option value="Occupied" <%= editRoom != null && "Occupied".equals(editRoom.getStatus()) ? "selected" : "" %>>Occupied</option>
                                    <option value="Maintenance" <%= editRoom != null && "Maintenance".equals(editRoom.getStatus()) ? "selected" : "" %>>Maintenance</option>
                                </select>
                            </div>
                            <div class="col-12">
                                <button type="submit" class="btn btn-success">
                                    <%= editRoom != null ? "Update Room" : "Add Room" %>
                                </button>
                                <% if (editRoom != null) { %>
                                    <a href="manageRooms" class="btn btn-secondary">Cancel</a>
                                <% } %>
                            </div>
                        </form>
                    </div>
                </div>

                <!-- Rooms Table -->
                <table class="table table-bordered table-striped">
                    <thead class="table-dark">
                        <tr>
                            <th>ID</th>
                            <th>Room No.</th>
                            <th>Type</th>
                            <th>Price/Night</th>
                            <th>Status</th>
                            <th>Actions</th>
                        </tr>
                    </thead>
                    <tbody>
                        <%
                            List<Room> rooms = (List<Room>) request.getAttribute("rooms");
                            if (rooms != null) {
                                for (Room room : rooms) {
                        %>
                            <tr>
                                <td><%= room.getRoomId() %></td>
                                <td><%= room.getRoomNumber() %></td>
                                <td><%= room.getRoomType() %></td>
                                <td>$<%= String.format("%.2f", room.getPricePerNight()) %></td>
                                <td>
                                    <span class="badge <%= "Available".equals(room.getStatus()) ? "bg-success" : 
                                                          "Occupied".equals(room.getStatus()) ? "bg-danger" : "bg-warning" %>">
                                        <%= room.getStatus() %>
                                    </span>
                                </td>
                                <td>
                                    <a href="manageRooms?action=edit&id=<%= room.getRoomId() %>" 
                                       class="btn btn-sm btn-warning">Edit</a>
                                    <a href="manageRooms?action=delete&id=<%= room.getRoomId() %>" 
                                       class="btn btn-sm btn-danger"
                                       onclick="return confirm('Delete this room?')">Delete</a>
                                </td>
                            </tr>
                        <%
                                }
                            }
                        %>
                    </tbody>
                </table>
            </div>
        </div>
    </div>
</body>
</html>
