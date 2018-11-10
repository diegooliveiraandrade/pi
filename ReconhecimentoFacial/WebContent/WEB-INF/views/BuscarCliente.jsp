<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://www.springframework.org/tags/form" prefix="form"%>
<!DOCTYPE html>
<html lang="pt-br">
<head>
<!-- Required meta tags -->
<meta charset="utf-8">
<meta name="viewport"
	content="width=device-width, initial-scale=1, shrink-to-fit=no">

<!-- Bootstrap CSS -->
<link rel="stylesheet"
	href="https://stackpath.bootstrapcdn.com/bootstrap/4.1.3/css/bootstrap.min.css"
	integrity="sha384-MCw98/SFnGE8fJT3GXwEOngsV7Zt27NXFoaoApmYm81iuXoPkFOJwJ8ERdknLPMO"
	crossorigin="anonymous">

<link rel="icon" href="https://getbootstrap.com/favicon.ico">
<title>Busca de Cliente</title>
</head>
<body class="bg-light">

	<c:import url="Menu.jsp" />

	<div class="container">
		<div
			class="pricing-header px-3 py-3 pt-md-5 pb-md-4 mx-auto text-center">
			<h1 class="display-4">Buscar Cliente</h1>
		</div>

		<div class="row">
			<div class="col-md-4 order-md-2 mb-4">
				<h5 class="d-flex justify-content-between align-items-center mb-3">
					<span class="text-muted">Captura de Imagem</span>
				</h5>
				<hr class="mb-4">
				<ul class="list-group mb-3">
					<li
						class="list-group-item d-flex justify-content-between lh-condensed">
						<div>
							<video id="video" width="300" height="300" autoplay></video>
						</div>
					</li>
					<li
						class="list-group-item d-flex justify-content-between lh-condensed">
						<input type="button"
						class="btn btn-dark btn-outline-primary btn-block btn-md"
						id="snap" title="Capturar Foto" value="Capturar Imagem">
					</li>
					<li
						class="list-group-item d-flex justify-content-between lh-condensed">
						<div>
							<canvas id="canvas" width="300" height="300"></canvas>
							<script type="text/javascript">
								// Grab elements, create settings, etc.
								var video = document.getElementById('video');
								// Get access to the camera!
								if (navigator.mediaDevices
										&& navigator.mediaDevices.getUserMedia) {
									// Not adding `{ audio: true }` since we only want video now
									navigator.mediaDevices
											.getUserMedia({
												video : true
											})
											.then(
													function(stream) {
														video.src = window.URL
																.createObjectURL(stream);
														video.play();
													});
								}
								// Elements for taking the snapshot
								var canvas = document.getElementById('canvas');
								var context = canvas.getContext('2d');
								var video = document.getElementById('video');
								// Trigger photo take
								document
										.getElementById("snap")
										.addEventListener(
												"click",
												function() {
													context.drawImage(video, 0,
															0, 300, 300);
													var input = document
															.createElement('input');
													input.type = "hidden";
													input.name = "file";
													input.value = canvas
															.toDataURL();
													document.getElementById(
															"foto")
															.appendChild(input);
												});
							</script>
						</div>
					</li>
				</ul>
			</div>
			<div class="col-md-8 order-md-1">
				<h5 class="text-muted">Dúvidas de como realizar a busca?</h5>
				<hr class="mb-4">
				<p class="lead">Tire uma fotografia do cliente e no momento que
					a mesma for capturada clique em 'Buscar Cliente'.</p>
					
				<p class="lead">Neste momento aguarde até que a aplicação te retorne um
					resultado.</p>
				<form method="POST" action="catchPhoto"
					enctype="multipart/form-data">
					<div class="mb-3" style="display: none">
						<label>Nome Completo</label> <input type="text"
							class="form-control" name="nome" id="nome" maxlength="100">
					</div>
					<div class="row">
						<div id="foto">
							<form:errors path="file" cssStyle="color:red" />
						</div>
					</div>
					<hr class="mb-4">
					<button type="submit" class="btn btn-lg btn-primary btn-block"
						name="acao" value="criar">Buscar Cliente</button>
					<a class="btn btn-danger btn-block btn-lg" href="index">Cancelar</a>
				</form>
			</div>
		</div>

		<c:import url="Footer.jsp" />

	</div>

	<!-- Optional JavaScript -->
	<!-- jQuery first, then Popper.js, then Bootstrap JS -->
	<script src="https://code.jquery.com/jquery-3.3.1.slim.min.js"
		integrity="sha384-q8i/X+965DzO0rT7abK41JStQIAqVgRVzpbzo5smXKp4YfRvH+8abtTE1Pi6jizo"
		crossorigin="anonymous"></script>
	<script
		src="https://cdnjs.cloudflare.com/ajax/libs/popper.js/1.14.3/umd/popper.min.js"
		integrity="sha384-ZMP7rVo3mIykV+2+9J3UJ46jBk0WLaUAdn689aCwoqbBJiSnjAK/l8WvCWPIPm49"
		crossorigin="anonymous"></script>
	<script
		src="https://stackpath.bootstrapcdn.com/bootstrap/4.1.3/js/bootstrap.min.js"
		integrity="sha384-ChfqqxuZUCnJSK3+MXmPNIyE6ZbWh2IMqE241rYiqJxyMiZ6OW/JmZQ5stwEULTy"
		crossorigin="anonymous"></script>

	<script src="js/jquery.min.js"></script>
	<script src="js/bootstrap.min.js"></script>
</body>
</html>