<!DOCTYPE html>
<html lang="en">
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<title>Modifica studente</title>

	<link
		href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.5/dist/css/bootstrap.min.css" rel="stylesheet"
		integrity="sha384-SgOJa3DmI69IUzQ2PVdRZhwQ+dy64/BUtbMJw1MZ8t5HZApcHrRKUc4W0kG879m7"
		crossorigin="anonymous">
		
	<link href="https://fonts.googleapis.com/css2?family=Poppins:wght@400;600&display=swap" rel="stylesheet">
	
<style>
	
	body {
  		font-family: 'Poppins', sans-serif;
	}

	#linkNavbar {
		padding:20px;
	}
	
	form {
		margin-top: 50px;
	}

	label {
		margin-top: 15px;
		font-weight: bold;
	}
	
	#btnModifica {
		margin-top: 15px;
	}
	
	.allineamentoDx {
		text-align: right;
	}
	
</style>

</head>

<body>
	<nav class="navbar bg-body-tertiary">
		<div class="container-fluid">
    		<a id="linkNavbar"class="navbar-brand" href="StudentControllerServlet"><h1>Modifica studente!</h1></a>
  		</div>
	</nav>

	<div>
		<div class="row">
			<div class="col">
				
			</div>
			
			<div class="col-6">
				<form action="StudentControllerServlet" method="POST">
				
					<input type="hidden" name="command" value="UPDATE">
					<input type="hidden" name="studentId" value="${THE_STUDENT.id}">
					
					<div class="mb-3">
						<label for="firstName" class="form-label">Nome</label> 
						<input type=text class="form-control" name="firstName" id="firstName" value="${THE_STUDENT.firstName}" placeholder="First Name" required> 
						
						<label for="firstName" class="form-label">Cognome</label> 
						<input type=text class="form-control" name="lastName" id="lastName" value="${THE_STUDENT.lastName}" placeholder="Last Name" required> 
						
						<label for="firstName" class="form-label">Email</label> 
						<input type=email class="form-control" name="email" id="email" value="${THE_STUDENT.email}" placeholder="email@example.com" required> 
						
						<div class="allineamentoDx">
							<input type="submit" id="btnModifica" class="btn btn-outline-primary" value="Modifica">
						</div>
					</div>
				</form>
			</div>
			
			<div class="col">
				
			</div>
		</div>
	</div>

		




		<script
			src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.5/dist/js/bootstrap.bundle.min.js"
			integrity="sha384-k6d4wzSIapyDyv1kpU366/PK5hCdSbCRGRCMv+eplOQJWyd1fbcAu9OCUj5zNLiq"
			crossorigin="anonymous"></script>
</body>
</html>
