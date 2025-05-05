<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>

<!DOCTYPE html>
<html lang="it">
<head>
	<meta charset="UTF-8">
	<meta name="viewport" content="width=device-width, initial-scale=1.0">
	<title>Login | Student Tracker App</title>

	<!-- Bootstrap CSS -->
	<link
		href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.5/dist/css/bootstrap.min.css" rel="stylesheet">
	<!-- Google Fonts -->
	<link href="https://fonts.googleapis.com/css2?family=Poppins:wght@400;600&display=swap" rel="stylesheet">

	<style>
		body {
			font-family: 'Poppins', sans-serif;
			margin-top: 150px;
		}

	</style>
</head>


<body class="bg-light">

	<div class="container mt-5">
	    <div class="row justify-content-center">
	        <div class="col-md-4">
	
	            <h2 class="text-center mb-3">Login</h2>
	
	            <form action="LoginServlet" method="post">
	                <div class="mb-3">
	                    <label>Email</label>
	                    <input type="email" name="email" class="form-control" placeholder="email@example.com" required>
	                </div>
	
	                <div class="mb-3">
	                    <label>Password</label>
	                    <input type="password" name="password" class="form-control" placeholder="password" required>
	                </div>
	
	                <c:if test="${param.error == 'true'}">
	                    <div class="alert alert-danger">Credenziali non valide.</div>
	                </c:if>
	
	                <button type="submit" class="btn btn-primary w-100">Accedi</button>
	            </form>
	
	        </div>
	    </div>
	</div>

	<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.5/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>
