<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>

<!DOCTYPE html>
<html lang="it">
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<title>Student Tracker App</title>

<!-- Bootstrap CSS -->
<link
	href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.5/dist/css/bootstrap.min.css"
	rel="stylesheet">

<!-- Google Fonts -->
<link
	href="https://fonts.googleapis.com/css2?family=Poppins:wght@400;600&display=swap"
	rel="stylesheet">

<style>
body {
	font-family: 'Poppins', sans-serif;
}

#tabella {
	margin-top: 30px;
}

#linkNavbar {
	padding: 20px;
}

h2 {
	text-align: center;
	background-color: grey;
	color: white;
	padding: 10px;
}
</style>
</head>

<body>

	<nav class="navbar bg-body-tertiary">
		<div class="container-fluid d-flex align-items-center">
			<a id="linkNavbar" class="navbar-brand" href="#"><h1>Student tracker App</h1></a>
			
			<div class="d-flex ms-auto">
				<div class="me-2">
					<input type="button" class="btn btn-outline-success"
						value="Aggiungi Studente"
						onclick="window.location.href='add-student-form.jsp'; return false;">
				</div>
			</div>
		</div>
	</nav>

	<div class="container" id="tabella">
		<div class="row justify-content-center">
			<div class="col-12 col-lg-10">
				<table class="table table-hover table-striped">
					<thead class="table-dark">
						<tr>
							<th scope="col">#</th>
							<th scope="col">Nome</th>
							<th scope="col">Cognome</th>
							<th scope="col">Email</th>
							<th scope="col">Azioni</th>
							<th></th>
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
								<td><a href="${tempLink}"
									class="link-primary link-offset-2 link-underline-opacity-25 link-underline-opacity-100-hover">
										Modifica </a> | <!-- Pulsante per aprire modale --> <a href="#"
									class="link-danger link-offset-2 link-underline-opacity-25 link-underline-opacity-100-hover"
									data-bs-toggle="modal"
									data-bs-target="#modalElimina${tempStudent.id}"> Elimina </a> <!-- MODALE per ogni studente -->
									<div class="modal fade" id="modalElimina${tempStudent.id}"
										tabindex="-1" aria-labelledby="modaleLabel${tempStudent.id}"
										aria-hidden="true">
										<div class="modal-dialog modal-dialog-centered">
											<div class="modal-content">

												<div class="modal-header">
													<h5 class="modal-title" id="modaleLabel${tempStudent.id}">Conferma
														Eliminazione</h5>
													<button type="button" class="btn-close"
														data-bs-dismiss="modal" aria-label="Chiudi"></button>
												</div>

												<div class="modal-body">
													Sei sicuro di voler eliminare lo studente <strong>${tempStudent.firstName}
														${tempStudent.lastName}</strong>?
												</div>

												<div class="modal-footer">
													<button type="button" class="btn btn-secondary"
														data-bs-dismiss="modal">Annulla</button>

													<form action="StudentControllerServlet" method="post">
														<input type="hidden" name="command" value="DELETE">
														<input type="hidden" name="studentId"
															value="${tempStudent.id}">
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
		</div>
	</div>

	<script
		src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.5/dist/js/bootstrap.bundle.min.js"></script>

</body>
</html>
