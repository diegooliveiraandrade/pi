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
<title>Visualizar Cliente</title>
</head>
<body class="bg-light">

	<c:import url="Menu.jsp" />

	<div class="container">
		<div
			class="pricing-header px-3 py-3 pt-md-5 pb-md-4 mx-auto text-center">
			<h1 class="display-4">Informações Cadastradas</h1>
		</div>

		<div class="row">
			<div class="col-md-12 order-md-1">
				<hr class="mb-4">

				<div class="row">
					<div class="col-md-2 mb-3">
						<label>Identificação</label>
						<div class="input-group">
							<div class="input-group-prepend">
								<span class="input-group-text">#</span>
							</div>
							<input type="text" class="form-control" name="id" id="id"
								value="${cliente.id}" maxlength="100" readonly>
						</div>
					</div>
					<div class="col-md-10 mb-3">
						<label>Nome Completo</label> <input type="text"
							value="${cliente.nome}" class="form-control" name="nome"
							id="nome" maxlength="100" readonly>
					</div>
				</div>

				<div class="row">
					<div class="col-md-6 mb-4">
						<label for="email">Email</label> <input type="text"
							class="form-control" name="email" id="email" maxlength="60"
							value="${cliente.email}" readonly>
					</div>

					<div class="col-md-6 mb-4">
						<label for="email">Telefone</label> <input type="text"
							class="form-control" name="telefone" id="telefone" maxlength="20"
							value="${cliente.telefone}" readonly>
					</div>
				</div>

				<div class="row">
					<div class="col-md-6 mb-3">
						<div class="input-group">
							<div class="input-group-prepend">
								<span class="input-group-text">RG</span>
							</div>
							<input type="text" class="form-control" name="rg" id="rg"
								value="${cliente.rg}" maxlength="12" readonly>
						</div>
					</div>

					<div class="col-md-6 mb-3">
						<div class="input-group">
							<div class="input-group-prepend">
								<span class="input-group-text">CPF</span>
							</div>
							<input type="text" class="form-control" name="cpf" id="cpf"
								value="${cliente.cpf}" maxlength="12" readonly>
						</div>
					</div>
				</div>

				<div class="row">
					<div class="col-md-10 mb-3">
						<label for="address">Endereço</label> <input type="text"
							class="form-control" name="endereco" id="endereco"
							value="${cliente.endereco}" maxlength="300" readonly>
					</div>

					<div class="col-md-2 mb-3">
						<label for="address">Número</label> <input type="text"
							value="${cliente.numero}" class="form-control" name="numero"
							id="numero" maxlength="10" readonly>
					</div>
				</div>

				<div class="row">
					<div class="col-md-3 mb-3">
						<label for="zip">CEP</label> <input type="text"
							class="form-control" name="cep" id="cep" maxlength="10"
							value="${cliente.cep}" readonly>
					</div>
					<div class="col-md-5 mb-3">
						<label for="country">Bairro</label> <input type="text"
							value="${cliente.bairro}" class="form-control" name="bairro"
							id="bairro" maxlength="100" readonly>
					</div>

					<div class="col-md-4 mb-3">
						<label for="country">Logradouro</label> <input type="text"
							class="form-control" name="tipoLogradouro" id="tipoLogradouro"
							value="${cliente.tipoLogradouro}" maxlength="10" readonly>
					</div>
				</div>

				<div class="row">
					<div class="col-md-4 mb-3">
						<label for="country">Cidade</label> <input type="text"
							value="${cliente.cidade}" class="form-control" name="cidade"
							id="cidade" maxlength="100" readonly>
					</div>
					<div class="col-md-4 mb-3">
						<label for="country">Estado</label> <input type="text"
							value="${cliente.estado}" class="form-control" name="estado"
							id="estado" maxlength="2" readonly>
					</div>
					<div class="col-md-4 mb-3">
						<label for="country">País</label> <input type="text"
							class="form-control" name="pais" id="pais"
							value="${cliente.pais}" maxlength="100" readonly>
					</div>
				</div>
				<div class="row">
					<div class="col-md-12 mb-3">
						<label for="country">Identificação Azure</label> <input
							type="text" class="form-control" name="pais" id="pais"
							value="${cliente.personId}" maxlength="100" readonly>
					</div>
				</div>
				<div class="row">
					<div id="foto">
						<form:errors path="file" cssStyle="color:red" />
					</div>
				</div>
				<hr class="mb-4">
				<a class="btn btn-info btn-block btn-lg" href="index">Retornar</a>
			</div>
		</div>
	</div>

	<c:import url="Footer.jsp" />

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