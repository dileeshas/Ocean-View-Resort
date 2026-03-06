<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.util.List" %>
<%@ page import="com.OceanViewResort.Model.Room" %>


<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Ocean View Resort Management System - Check Availability</title>
    
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/css/bootstrap.min.css" rel="stylesheet">
    <link href="https://fonts.googleapis.com/css2?family=Poppins:wght@300;400;500;600&display=swap" rel="stylesheet">
    <link href="https://fonts.googleapis.com/icon?family=Material+Icons" rel="stylesheet">

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
		
		.form-select {
		    color: #6c757d;
		    font-size: 0.9rem;
		}
		
		.form-select:valid {
		    color: #212529;
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
                <h2>Check Room Availability</h2>
                <hr>

                <form action="checkAvailability" method="post" class="row g-3 mb-4" onsubmit="return validateDates()">
                    <div class="col-md-3">
                        <label class="form-label">Room Type</label>
                        <select name="roomType" class="form-select" required>
                            <option value="">-- Select room type --</option>
                            <%
                                List<String> roomTypes = (List<String>) request.getAttribute("roomTypes");
                                String selectedType = (String) request.getAttribute("selectedType");
                                if (roomTypes != null) {
                                    for (String type : roomTypes) {
                            %>
                                <option value="<%= type %>" <%= type.equals(selectedType) ? "selected" : "" %>><%= type %></option>
                            <%
                                    }
                                }
                            %>
                        </select>
                    </div>
                    <div class="col-md-3">
                        <label class="form-label">Check-in Date</label>
                        <input type="date" name="checkIn" class="form-control" 
                               value="${checkIn}" required>
                    </div>
                    <div class="col-md-3">
                        <label class="form-label">Check-out Date</label>
                        <input type="date" name="checkOut" class="form-control" 
                               value="${checkOut}" required>
                    </div>
                    <div class="col-md-3 d-flex align-items-end">
                        <button type="submit" class="btn btn-primary">Search</button>
                    </div>
                </form>

                <%
                    List<Room> availableRooms = (List<Room>) request.getAttribute("availableRooms");
                    if (availableRooms != null) {
                %>
                    <h4>Available Rooms (<%= availableRooms.size() %> found)</h4>
                    <% if (availableRooms.isEmpty()) { %>
                        <div class="alert alert-warning">No rooms available for the selected criteria.</div>
                    <% } else { %>
                        <table class="table table-bordered table-striped">
                            <thead class="table-dark">
                                <tr>
                                    <th>Room No.</th>
                                    <th>Type</th>
                                    <th>Price/Night</th>
                                    <th>Status</th>
                                    <th>Action</th>
                                </tr>
                            </thead>
                            <tbody>
                                <% for (Room room : availableRooms) { %>
                                    <tr>
                                        <td><%= room.getRoomNumber() %></td>
                                        <td><%= room.getRoomType() %></td>
                                        <td>$<%= String.format("%.2f", room.getPricePerNight()) %></td>
                                        <td><span class="badge bg-success">Available</span></td>
                                        <td>
                                            <a href="newReservation?roomId=<%= room.getRoomId() %>&checkIn=${checkIn}&checkOut=${checkOut}" 
                                               class="btn btn-sm btn-success">Book Now</a>
                                        </td>
                                    </tr>
                                <% } %>
                            </tbody>
                        </table>
                    <% } %>
                <% } %>
            </div>
        </div>
    </div>
    
    <script>
		function validateDates() {
		
		    var checkIn = document.querySelector("input[name='checkIn']").value;
		    var checkOut = document.querySelector("input[name='checkOut']").value;
		
		    if (checkIn === "" || checkOut === "") {
		        alert("Please select both check-in and check-out dates.");
		        return false;
		    }
		
		    var inDate = new Date(checkIn);
		    var outDate = new Date(checkOut);
		
		    if (inDate >= outDate) {
		        alert("Check-out date must be later than check-in date.");
		        return false;
		    }
		
		    return true;
		}
	</script>
    
</body>
</html>
