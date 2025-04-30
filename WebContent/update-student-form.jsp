<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>

<!DOCTYPE html>
<html lang="en">
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<title>Student Tracker App - Modifica</title>

	<link
		href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.5/dist/css/bootstrap.min.css" rel="stylesheet"
		integrity="sha384-SgOJa3DmI69IUzQ2PVdRZhwQ+dy64/BUtbMJw1MZ8t5HZApcHrRKUc4W0kG879m7"
		crossorigin="anonymous">
		
	<link href="https://fonts.googleapis.com/css2?family=Poppins:wght@400;600&display=swap" rel="stylesheet">
	
<style>
	
	body {
  		font-family: 'Poppins', sans-serif;
	}
	
	h1 {
	margin-left: 100px;
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
    		<a id="linkNavbar"class="navbar-brand" href="StudentControllerServlet"><h1>Modifica studente</h1></a>
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
	
	<!-- per modale errore nome con numeri -->
	<div class="modal fade" id="erroreNome" tabindex="-1" aria-hidden="true">
  		<div class="modal-dialog modal-dialog-centered">
	    	<div class="modal-content">
		
		      	<div class="modal-header bg-danger text-white">
		        	<h5 class="modal-title">Errore di validazione</h5>
		        	<button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Chiudi"></button>
		      	</div>
		
		      	<div class="modal-body">
		        	Il <b>nome</b> o il <b>cognome</b> non possono contenere numeri o simboli. <b>Inserisci solo lettere</b>.
		      	</div>
		
		      	<div class="modal-footer">
		        	<button type="button" class="btn btn-secondary" data-bs-dismiss="modal">Chiudi</button>
		      	</div>
	
	    	</div>
  		</div>
	</div>

		<script
			src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.5/dist/js/bootstrap.bundle.min.js"
			integrity="sha384-k6d4wzSIapyDyv1kpU366/PK5hCdSbCRGRCMv+eplOQJWyd1fbcAu9OCUj5zNLiq"
			crossorigin="anonymous"></script>
			
	<!-- Script visualizzazione errore validazione nome -->
	<c:if test="${ERRORE_NOME}">
  		<script>
    		const modal = new bootstrap.Modal(document.getElementById('erroreNome'));
    		modal.show();
  		</script>
	</c:if>

</body>
</html>
