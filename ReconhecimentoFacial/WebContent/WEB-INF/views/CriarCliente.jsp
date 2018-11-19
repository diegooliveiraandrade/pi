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
<title>Cadastro de Cliente</title>
</head>
<body class="bg-light">

	<c:import url="Menu.jsp"/>

	<div class="container">
		<div
			class="pricing-header px-3 py-3 pt-md-5 pb-md-4 mx-auto text-center">
			<h1 class="display-4">Cadastro</h1>
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
				<h5 class="text-muted">Informações Cadastrais</h5>
				<hr class="mb-4">
				<form action="createClientePhoto" method="post"
					enctype="multipart/form-data">
					<div class="row">
					<div class="col-md-12 mb-3">
						<label>Nome Completo</label> <input type="text"
							class="form-control" name="nome" id="nome" maxlength="100"
							placeholder="Ex.: João Marcos Martins" required>
					</div>
					</div>

					<div class="row">
						<div class="col-md-6 mb-3">
						<label></label>
							<div class="input-group">
								<div class="input-group-prepend">
									<span class="input-group-text">RG</span>
								</div>
								<input type="text" class="form-control" name="rg" id="rg"
									maxlength="12" required>
							</div>
						</div>

						<div class="col-md-6 mb-3">
						<label></label>
							<div class="input-group">
								<div class="input-group-prepend">
									<span class="input-group-text">CPF</span>
								</div>
								<input type="text" class="form-control" name="cpf" id="cpf"
									maxlength="12" required>
							</div>
						</div>
					</div>

					<div class="row">
						<div class="col-md-6 mb-3">
							<label for="email">Email</label> <input type="text"
								class="form-control" name="email" id="email" maxlength="60"
								placeholder="exemplo@exemplo.com" required>
						</div>

						<div class="col-md-6 mb-3">
							<label for="email">Telefone</label> <input type="text"
								class="form-control" name="telefone" id="telefone"
								maxlength="20" placeholder="(00)0000-0000" required>
						</div>
					</div>

					<div class="row">
						<div class="col-md-10 mb-3">
							<label for="address">Endereço</label> <input type="text"
								class="form-control" name="endereco" id="endereco"
								maxlength="300" required>
						</div>

						<div class="col-md-2 mb-3">
							<label for="address">Número</label> <input type="text"
								class="form-control" name="numero" id="numero" maxlength="10"
								required>
						</div>
					</div>

					<div class="row">
						<div class="col-md-3 mb-3">
							<label for="zip">CEP</label> <input type="text"
								class="form-control" name="cep" id="cep" maxlength="10"
								placeholder="00000-000" required>
						</div>
						<div class="col-md-5 mb-3">
							<label for="country">Bairro</label> <input type="text"
								class="form-control" name="bairro" id="bairro" maxlength="100"
								required>
						</div>

						<div class="col-md-4 mb-3">
							<label for="country">Logradouro</label> <input type="text"
								class="form-control" name="tipoLogradouro" id="tipoLogradouro"
								maxlength="10" placeholder="Ex.: Avenida" required>
						</div>
					</div>

					<div class="row">
						<div class="col-md-4 mb-3">
							<label for="country">Cidade</label> <input type="text"
								class="form-control" name="cidade" id="cidade" maxlength="100"
								required>
						</div>
						<div class="col-md-4 mb-3">
							<label for="country">Estado</label> <input type="text"
								class="form-control" name="estado" id="estado" maxlength="2"
								required>
						</div>
						<div class="col-md-4 mb-3">
							<label for="country">País</label> <input type="text"
								class="form-control" name="pais" id="pais" maxlength="100"
								required>
						</div>

						<div hidden="form-group col-md-4">
							<label for="personId">PersonId</label> <input type="text"
								class="form-control" name="cliente.personId" id="personId"
								placeholder="personId">
						</div>
						<div id="foto">
							<form:errors path="file" cssStyle="color:red" />
						</div>
					</div>
					<hr class="mb-4">
					<button type="submit" class="btn btn-md btn-primary btn-block"
						name="acao" value="criar">Finalizar Cadastro</button>
					<hr class="mb-4">
					<button type="reset" class="btn btn-md btn-warning btn-block"
						name="acao">Resetar Campos</button>
					<a class="btn btn-danger btn-block btn-md" href="index">Cancelar</a>
				</form>
			</div>
		</div>
		
		<c:import url="Footer.jsp"/>
		
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