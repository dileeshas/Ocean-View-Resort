<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Ocean View Resort Management System - Login</title>
    
    <!-- Bootstrap -->
	<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/css/bootstrap.min.css" rel="stylesheet">
	
	<!-- Google Font -->
	<link href="https://fonts.googleapis.com/css2?family=Poppins:wght@300;400;500;600&display=swap" rel="stylesheet">
	
	<!-- Material Icons -->
	<link href="https://fonts.googleapis.com/icon?family=Material+Icons" rel="stylesheet">
	
	<style>
		body {
		    font-family: 'Poppins', sans-serif;
		    height: 100vh;
		    margin: 0;
		    background: linear-gradient(rgba(18,94,130,0.55), rgba(18,94,130,0.55)),
		                url("https://images.unsplash.com/photo-1507525428034-b723cf961d3e?q=80&w=1974&auto=format&fit=crop");
		    background-size: cover;
		    background-position: center;
		    background-attachment: fixed;
		    display: flex;
		    align-items: center;
		    justify-content: center;
		}
		
		.login-card {
		    width: 480px;
		    padding: 40px;
		    border-radius: 22px;
		    background: rgb(126, 165, 188);
		    border: 1px solid rgba(255,255,255,0.25);
		    animation: fadeIn 0.8s ease-in-out;
		}
		
		@keyframes fadeIn {
		    from { opacity: 0; transform: translateY(20px); }
		    to { opacity: 1; transform: translateY(0); }
		}
		
		.header-flex {
		    display: flex;
		    flex-direction: column;
		    align-items: center;
		    margin-bottom: 25px;
		}
		
		.logo {
		    width: 130px;
		    margin-bottom: 12px;
		}
		
		.title {
		    font-weight: 600;
		    color: white;
		    text-align: center;
		    letter-spacing: 0.5px;
		}
		
		.subtitle {
		    font-size: 12px;
		    color: #e6f5ff;
		    margin-bottom: 25px;
		}
		
		.form-control {
		    border-radius: 12px;
		    height: 48px;
		    border: none;
		    background: rgba(255,255,255,0.9);
		    transition: 0.3s;
		}
		
		.input-group-text {
		    background: rgba(255,255,255,0.9);
		    border: none;
		    color: #1b6ca8;
		}
		
		.form-control:focus {
		    box-shadow: 0 0 0 3px rgba(27,108,168,0.25);
		    transform: scale(1.02);
		}
		
		.btn-login {
		    background: linear-gradient(135deg, #1b6ca8, #155d8e);
		    border: none;
		    height: 48px;
		    border-radius: 12px;
		    font-weight: 600;
		    letter-spacing: 0.5px;
		    transition: 0.3s ease;
		    color: white;
		}
		
		.btn-login:hover {
		    transform: translateY(-3px);
		    box-shadow: 0 10px 25px rgba(0,0,0,0.35);
		}
		
		.footer-text {
		    text-align: center;
		    margin-top: 20px;
		    font-size: 12px;
		    color: #d9f2ff;
		}
		
		.error-message {
		    color: #ffdddd;
		    background: #a83232;
		    text-align: center;
		    padding: 8px;
		    border-radius: 8px;
		    margin-bottom: 15px;
		}
	</style>
	
</head>
<body>
	<div class="login-card">
		<div class="header-flex">
	      <img src="<%= request.getContextPath() %>/images/logo1.png" alt="Resort Logo" class="logo">
	      <h3 class="title">Admin Login</h3>
	      <div class="subtitle">— Ocean View Resort Administration Panel —</div>
	    </div>
	    
	    <% if (request.getAttribute("error") != null) { %>
			<div class="error-message">
		<%= request.getAttribute("error") %>
			</div>
		<% } %>
		
		<form action="<%= request.getContextPath() %>/login" method="post">
			<!-- Username -->
			<div class="mb-3 input-group">
				<span class="input-group-text">
					<span class="material-icons">person</span>
				</span>
				<input type="text" class="form-control" id="username" name="username" placeholder="Username" required>
             </div>
             
             <!-- Password -->
             <div class="mb-4 input-group">
				<span class="input-group-text">
					<span class="material-icons">lock</span>
				</span>
				<input type="password" class="form-control" id="password" name="password" placeholder="Password" required>
             </div>
             
             <!-- Login Button -->
             <button type="submit" class="btn btn-login w-100">Login</button>
         </form>
         
		 <div class="footer-text">
	        © 2026 Ocean View Resort | All Rights Reserved <br>
	        <small>Default: admin / admin123</small>
	     </div>
         
         
	</div>
</body>
</html>
