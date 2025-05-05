<!DOCTYPE html>
<html lang="en">
<head>
	<meta charset="UTF-8">
	<meta name="viewport" content="width=device-width, initial-scale=1.0">
	<title>Aggiungi | Student Tracker App</title>
	
	<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.5/dist/css/bootstrap.min.css" rel="stylesheet" integrity="sha384-SgOJa3DmI69IUzQ2PVdRZhwQ+dy64/BUtbMJw1MZ8t5HZApcHrRKUc4W0kG879m7" crossorigin="anonymous">
	<link href="https://fonts.googleapis.com/css2?family=Poppins:wght@400;600&display=swap" rel="stylesheet">
	
	
	<style>
		body {
			font-family: 'Poppins', sans-serif;
		}
		
		#linkNavbar {
			padding: 20px;
		}
		
		form {
			margin-top: 50px;
		}
		
		label {
			margin-top: 15px;
			font-weight: bold;
		}
		
		h1 {
			margin-left: 100px;
		}
		
		#btnAggiungi {
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
			<a id="linkNavbar" class="navbar-brand" href="StudentControllerServlet"><h1>Aggiungi studente</h1></a>
		</div>
	</nav>
	
	<div>
		<div class="row">
			<div class="col">
			</div>

			<div class="col-6">
				<form action="StudentControllerServlet" method="POST">
					<input type="hidden" name="command" value="ADD">
					
					<div class="mb-3">
						<label for="firstName" class="form-label">Nome</label> 
						<input type=text class="form-control" name="firstName" id="firstName" placeholder="First Name" required> 
						
						<label for="lastName" class="form-label">Cognome</label> 
						<input type=text class="form-control" name="lastName" id="lastName" placeholder="Last Name" required> 
						
						<label for="firstName" class="form-label">Email</label> 
						<input type=email class="form-control" name="email" id="email" placeholder="email@example.com" required>

						<div class="allineamentoDx">
							<input type="submit" id="btnAggiungi"
								class="btn btn-outline-success" value="Aggiungi">
						</div>
					</div>
				</form>
			</div>

			<div class="col">
			</div>
		</div>
	</div>
	
	<!-- MODALE DI ERRORE EMAIL GIA IN USO -->
	<div class="modal fade" id="erroreDuplicato" tabindex="-1" aria-labelledby="erroreDuplicatoLabel" aria-hidden="true">
		<div class="modal-dialog modal-dialog-centered">
	    	<div class="modal-content">
	
	      		<div class="modal-header bg-warning text-dark">
	        		<h5 class="modal-title" id="erroreDuplicatoLabel">Email già in uso</h5>
	        		<button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Chiudi"></button>
	      		</div>
	
	      		<div class="modal-body">
	        		L'email che stai cercando di registrare è <b>gia in uso</b> da un altro studente.
	      		</div>
	
	      		<div class="modal-footer">
	        		<button type="button" class="btn btn-secondary" data-bs-dismiss="modal">Chiudi</button>
	      		</div>
	
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
	
	<!-- deve stare sopra gli script da eseguire -->
	<script
		src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.5/dist/js/bootstrap.bundle.min.js"
		integrity="sha384-k6d4wzSIapyDyv1kpU366/PK5hCdSbCRGRCMv+eplOQJWyd1fbcAu9OCUj5zNLiq"
		crossorigin="anonymous">
	</script>
	
	<!-- Script visualizzazione errore validazione nome -->
	<script>
		const urlParams = new URLSearchParams(window.location.search);

		if (urlParams.get("errore") === "nome") {
			const modal = new bootstrap.Modal(document.getElementById('erroreNome'));
			modal.show();
		}

		if (urlParams.get("duplicate") === "true") {
			const modal = new bootstrap.Modal(document.getElementById('erroreDuplicato'));
			modal.show();
		}
	</script>

	
</body>
</html>
