<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>

<!DOCTYPE html>
<html lang="it">
<head>
	<meta charset="UTF-8">
	<meta name="viewport" content="width=device-width, initial-scale=1.0">
	<title>Student Tracker App</title>

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
		
		#tabella {
			margin-top: 30px;
		}
		
		#linkNavbar {
			padding: 20px;
		}
		
		#containerItemNav {
			margin-right: 100px;
		}
		
		h1 {
			margin-left: 100px;
		}
		
		h2 {
			text-align: center;
			background-color: grey;
			color: white;
			padding: 10px;
		}
		
		table thead th {
			position: sticky;
			top: 0;
			background-color: #212529; /* stesso colore della tua thead .table-dark */
			color: white;
			z-index: 10;
		}
		
	
	</style>
</head>

<body>

	<nav class="navbar bg-body-tertiary fixed-top">
		<div class="container-fluid d-flex align-items-center">
			<a id="linkNavbar" class="navbar-brand" href="StudentControllerServlet"><h1>Student Tracker App</h1></a>
			
			<div class="d-flex ms-auto" id="containerItemNav">
			
				<div class="me-2">
					<input type="button" class="btn btn-outline-success" value="Aggiungi Studente" onclick="window.location.href='add-student-form.jsp'; return false;">
				</div>
			
				<div class="btn-group">
				  	<button type="button" class="btn btn-primary dropdown-toggle me-2" data-bs-toggle="dropdown" aria-expanded="false">
				    	Cerca per
				  	</button>
				  	<ul class="dropdown-menu">
  						<li><a class="dropdown-item" href="#" onclick="apriModalRicerca('id')">ID</a></li>
						<li><a class="dropdown-item" href="#" onclick="apriModalRicerca('firstName')">Nome</a></li>
						<li><a class="dropdown-item" href="#" onclick="apriModalRicerca('lastName')">Cognome</a></li>
						<li><a class="dropdown-item" href="#" onclick="apriModalRicerca('email')">Email</a></li>
					</ul>

				</div>
				
			</div>
		</div>
	</nav>
	
	<div class="container" id="tabella">
		<div class="row justify-content-center">
			<div class="col-12 col-lg-10">
			
				<c:if test="${empty STUDENT_LIST}">
					<div class="alert alert-warning text-center mt-4" role="alert">
						Nessuno studente trovato come <strong>"${param.term}"</strong>.
					</div>
				</c:if>
				<c:if test="${TERM_NON_VALIDO}">
					<div class="alert alert-warning text-center mt-4" role="alert">
						Inserisci almeno un carattere per cercare.
					</div>
				</c:if>
				
				<c:if test="${not empty STUDENT_LIST}">
				<div style="max-height: 700px; overflow-y: auto;">
					<table class="table table-hover table-striped">
						<thead class="table-dark">
							<tr>
								<th scope="col">#</th>
								<th scope="col">Nome</th>
								<th scope="col">Cognome</th>
								<th scope="col">Email</th>
								<th scope="col">Azioni</th>
							</tr>
						</thead>
						<tbody>
							<c:forEach var="tempStudent" items="${STUDENT_LIST}">
								<c:url var="tempLink" value="StudentControllerServlet">
									<c:param name="command" value="LOAD" />
									<c:param name="studentId" value="${tempStudent.id}" />
								</c:url>
	
								<c:url var="deleteLink" value="StudentControllerServlet">
									<c:param name="command" value="DELETE" />
									<c:param name="studentId" value="${tempStudent.id}" />
								</c:url>
	
								<tr>
									<th scope="row">${tempStudent.id}</th>
									<td>${tempStudent.firstName}</td>
									<td>${tempStudent.lastName}</td>
									<td>${tempStudent.email}</td>
									<!-- Pulsante per aprire modale --> 
									<td><a href="${tempLink}" class="link-primary link-offset-2 link-underline-opacity-25 link-underline-opacity-100-hover"> Modifica </a> | 
									<!-- MODALE per ogni studente -->
									<a href="#" class="link-danger link-offset-2 link-underline-opacity-25 link-underline-opacity-100-hover" data-bs-toggle="modal" data-bs-target="#modalElimina${tempStudent.id}"> Elimina </a> 
										<div class="modal fade" id="modalElimina${tempStudent.id}" tabindex="-1" aria-labelledby="modaleLabel${tempStudent.id}" aria-hidden="true">
											<div class="modal-dialog modal-dialog-centered">
												<div class="modal-content">
	
													<div class="modal-header">
														<h5 class="modal-title" id="modaleLabel${tempStudent.id}">
															Conferma Eliminazione
														</h5>
														<button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Chiudi"></button>
													</div>
	
													<div class="modal-body">
														Sei sicuro di voler eliminare lo studente <strong>${tempStudent.firstName} ${tempStudent.lastName}</strong>?
													</div>
	
													<div class="modal-footer">
														<button type="button" class="btn btn-secondary" data-bs-dismiss="modal">Annulla</button>
	
														<form action="StudentControllerServlet" method="post">
															<input type="hidden" name="command" value="DELETE">
															<input type="hidden" name="studentId" value="${tempStudent.id}">
															<button type="submit" class="btn btn-danger">Elimina</button>
														</form>
													</div>
												</div>
											</div>
										</div></td>
								</tr>
							</c:forEach>
						</tbody>
					</table>
				</div>
				</c:if>
			</div>
		</div>
	</div>
	
	<!-- MODALE RICERCA STUDENTE -->
	<div class="modal fade" id="modalRicerca" tabindex="-1" aria-labelledby="modalRicercaLabel" aria-hidden="true">
	  	<div class="modal-dialog modal-dialog-centered">
	    	<div class="modal-content">
	
		      	<div class="modal-header">
		        	<h5 class="modal-title" id="modalTitolo">Ricerca Studente</h5>
		        	<button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Chiudi"></button>
		      	</div>
		
		      	<form action="StudentControllerServlet" method="GET">
		        	<input type="hidden" name="command" value="SEARCH">
		        	<input type="hidden" name="searchBy" id="searchBy">
		        	<div class="modal-body">
		          		<input type="search" class="form-control" name="term" id="campoTermine" placeholder="Inserisci valore..." required minlength="1">
		        	</div>
		        	<div class="modal-footer">
		          		<button type="submit" class="btn btn-dark">Cerca</button>
		        	</div>
		      	</form>
	
	    	</div>
	  	</div>
	</div>

	<script>
  		const ricercaModal = document.getElementById('modalRicerca');
  		const titoloModal = document.getElementById('modalTitolo');
  		const inputTipo = document.getElementById('searchBy');

  		function apriModalRicerca(campo) {
    		inputTipo.value = campo;

    		// Imposta il titolo dinamico
    		const titoli = {
      			id: "Ricerca per ID",
      			firstName: "Ricerca per Nome",
      			lastName: "Ricerca per Cognome",
      			email: "Ricerca per Email"
    		};
    		titoloModal.textContent = titoli[campo] || "Ricerca Studente";

    		// Mostra la modale
    		const modal = new bootstrap.Modal(ricercaModal);
    		modal.show();
  		}

  		ricercaModal.addEventListener('shown.bs.modal', function () {
    		ricercaModal.querySelector('input[name="term"]').focus();
  		});
	</script>

	
	<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.5/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>
