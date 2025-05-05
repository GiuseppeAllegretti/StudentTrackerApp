<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>

<!DOCTYPE html>
<html lang="it">
<head>
	<meta charset="UTF-8">
	<meta name="viewport" content="width=device-width, initial-scale=1.0">
	<title>Login | Student Tracker App</title>

	<!-- Bootstrap CSS -->
	<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.5/dist/css/bootstrap.min.css" rel="stylesheet">
	<!-- Google Fonts -->
	<link href="https://fonts.googleapis.com/css2?family=Poppins:wght@400;600&display=swap" rel="stylesheet">

	<style>
		body {
			font-family: 'Poppins', sans-serif;
			background-color: #f0f4f8;
		}
		.login-container {
			margin-top: 100px;
			background: #fff;
			padding: 40px;
			border-radius: 20px;
			box-shadow: 0 8px 16px rgba(0, 0, 0, 0.1);
		}
		.app-title {
			font-weight: 600;
			color: #0d6efd;
		}
		.app-icon {
			font-size: 48px;
			color: #0d6efd;
		}
		.form-label {
			font-weight: 500;
		}
	</style>
</head>

<body>
	<div class="container">
	    <div class="row justify-content-center">
	        <div class="col-md-5">
	            <div class="text-center mt-5">
	                <h1 class="app-title">Student Tracker App</h1>
	                <p class="text-muted">Accedi per gestire e monitorare gli sudenti.</p>
	            </div>

	            <div class="login-container">
	                <h3 class="text-center mb-4">Login</h3>

	                <form action="LoginServlet" method="post">
	                    <div class="mb-3">
	                        <label class="form-label">Email</label>
	                        <input type="email" name="email" class="form-control" placeholder="email@example.com" required>
	                    </div>

	                    <div class="mb-3">
	                        <label class="form-label">Password</label>
	                        <input type="password" name="password" class="form-control" placeholder="password" required>
	                    </div>

	                    <c:if test="${param.error == 'true'}">
	                        <div class="alert alert-danger text-center"><b>Email</b> o <b>password</b> errate.</div>
	                    </c:if>

	                    <button type="submit" class="btn btn-primary w-100">Accedi</button>
	                </form>
	            </div>
	        </div>
	    </div>
	</div>

	<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.5/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>
