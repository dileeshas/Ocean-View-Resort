<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Dashboard - Hotel Management</title>
    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css">
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/css/bootstrap.min.css" rel="stylesheet">
	<link href="https://fonts.googleapis.com/css2?family=Poppins:wght@300;400;500;600&display=swap" rel="stylesheet">
	<link href="https://fonts.googleapis.com/icon?family=Material+Icons" rel="stylesheet">
	<script src="https://cdn.jsdelivr.net/npm/chart.js"></script>
    
    <style>
		:root{
		--primary:#99c9db;
		--primary-dark:#1e71a8;
		--bg:#f4f8fc;
		--card:#ffffff;
		--text:#2c3e50;
		--muted:#7f8c8d;
		}
		
		body{
		font-family:Poppins,sans-serif;
		background:var(--bg);
		color:var(--text);
		}
		
		/* Fix sidebar overlap */
		.col-md-10{
		margin-left:250px;
		padding:30px !important;
		}
		
		/* Dashboard title */
		h2{
		font-weight:600;
		margin-bottom:20px;
		}
		
		/* Cards */
		.card-box{
		border:none;
		border-radius:16px;
		box-shadow:0 10px 24px rgba(0,0,0,0.07);
		padding:20px;
		transition:.25s;
		text-align:center;
		background: linear-gradient(135deg, #E3E6E8, #CED4DA);
		}
		
		.card-box:hover{
		transform:translateY(-4px);
		box-shadow:0 14px 30px rgba(0,0,0,0.12);
		}
		
		.card-box-body{
		padding:25px;
		}
		
		/* Card text */
		.card-title{
		font-size:19.5px;
		font-weight:500;
		}
		
		.card-box h3{
		font-size:24px;
		font-weight:600;
		}
		
		/* Quick buttons */
		.btn-outline-primary,
		.btn-outline-success,
		.btn-outline-warning{
		border-radius:10px;
		padding:8px 18px;
		transition:.2s;
		}
		
		.btn-outline-primary:hover{
		background:#1e71a8;
		border-color:#1e71a8;
		color:white;
		}
		
		.btn-outline-success:hover{
		background:#2ecc71;
		border-color:#2ecc71;
		color:white;
		}
		
		.btn-outline-warning:hover{
		background:#f39c12;
		border-color:#f39c12;
		color:white;
		}
		
		/* Responsive */
		@media(max-width:992px){
		.col-md-10{
		margin-left:0;
		}
		}
		
		</style>
    
</head>
<body>
    <div class="container-fluid">
        <div class="row">
            <!-- Sidebar -->
            <jsp:include page="sidebar.jsp" />

            <!-- Main Content -->
            <div class="col-md-10 p-4">
                <h1>Dashboard</h1>
                <p>Welcome, <strong><%= session.getAttribute("username") %></strong>!</p>
                <hr>

                <div class="row">
                    <div class="col-md-3 mb-3">
                        <div class="card-box">
                            <div class="card-box-body text-center">
                                <h5 class="card-title">Total Rooms</h5>
                                <h3>${totalRooms}</h3>
                            </div>
                        </div>
                    </div>
                    <div class="col-md-3 mb-3">
                        <div class="card-box">
                            <div class="card-box-body text-center">
                                <h5 class="card-title">Available Rooms</h5>
                                <h3>${availableRooms}</h3>
                            </div>
                        </div>
                    </div>
                    <div class="col-md-3 mb-3">
                        <div class="card-box">
                            <div class="card-box-body text-center">
                                <h5 class="card-title">Occupied Rooms</h5>
                                <h3>${occupiedRooms}</h3>
                            </div>
                        </div>
                    </div>
                    <div class="col-md-3 mb-3">
                        <div class="card-box ">
                            <div class="card-box-body text-center">
                                <h5 class="card-title">Active Reservations</h5>
                                <h3>${activeReservations}</h3>
                            </div>
                        </div>
                    </div>
                </div>

                <div class="mt-4 p-3 bg-light rounded shadow-sm">
				    <h3 class="mb-5">Quick Actions</h3>
				    <div class="d-flex flex-wrap gap-2">
				        <a href="checkAvailability" class="btn btn-outline-primary flex-fill">Check Availability</a>
				        <a href="newReservation" class="btn btn-outline-success flex-fill">New Reservation</a>
				        <a href="billing" class="btn btn-outline-warning flex-fill">Billing</a>
				    </div>
				</div>
                
                <div class="mt-4 p-3 bg-light rounded shadow-sm">
				    <h3>Reservations Overview</h3>
				
				    <div class="card1 shadow-sm p-4">
				        <canvas id="reservationChart" height="70"></canvas>
				 </div>
				</div>
            </div>
        </div>
    </div>
</body>

<script>

const ctx = document.getElementById('reservationChart').getContext('2d');
const reservationChart = new Chart(ctx, {
    type: 'line',
    data: {
        labels: ['Jan', 'Feb', 'Mar', 'Apr', 'May', 'Jun'],
        datasets: [{
            label: 'Reservations',
            data: [20, 35, 40, 30, 50, 45],
            backgroundColor: 'rgba(153, 201, 219, 0.2)',
            borderColor: 'rgba(30, 113, 168, 1)',
            borderWidth: 2,
            tension: 0.3,
            fill: true,
            pointBackgroundColor: 'rgba(30, 113, 168, 1)'
        }]
    },
    options: {
        responsive: true,
        plugins: {
            legend: { display: false }
        },
        scales: {
            y: { beginAtZero: true }
        }
    }
});
</script>
</html>