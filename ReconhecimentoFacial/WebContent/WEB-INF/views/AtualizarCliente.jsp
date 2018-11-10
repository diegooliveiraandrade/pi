<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://www.springframework.org/tags/form" prefix="form"%>
<!DOCTYPE html>
<html lang="pt-br">

<head>
<meta charset="utf-8">
<meta http-equiv="X-UA-Compatible" content="IE=edge">
<meta name="viewport" content="width=device-width, initial-scale=1">
<title>Atualizar Cliente</title>
<link href="css/bootstrap.min.css" rel="stylesheet">
<link href="css/style.css" rel="stylesheet">
</head>

<body>
	<!-- Barra superior com os menus de navegação -->
	<c:import url="Menu.jsp" />
	<!-- Container Principal -->
	<div id="main" class="container">
		<h3 class="page-header">Atualizar Cliente #${cliente.id}</h3>
		<!-- Formulario para inclusao de clientes -->
		<form action="atualizar_cliente" method="post">
			<!-- area de campos do form -->
			<div class="row">
				<div class="form-group col-md-4">
					<input type="hidden" name="id" value="${cliente.id}">

				</div>
				<div class="row">
					<div class="form-group col-md-8">
						<label for="nome">Nome</label> <input type="text"
							class="form-control" name="nome" id="nome" maxlength="300"
							placeholder="Nome" value="${cliente.nome }">
					</div>
				</div>
				<div class="row">
					<div class="form-group col-md-8">
						<label for="endereco">Endereço</label> <input type="text"
							class="form-control" name="endereco" id="endereco"
							maxlength="300" placeholder="Endereço"
							value="${cliente.endereco }">
					</div>
				</div>
				<div class="row">
					<div class="form-group col-md-8">
						<label for="cep">CEP</label> <input type="text"
							class="form-control" name="cep" id="cep" maxlength="10"
							placeholder="CEP" value="${cliente.cep }">
					</div>
				</div>
				<div class="row">
					<div class="form-group col-md-8">
						<label for="tipoLogradouro">Tipo Logradouro</label> <input
							type="text" class="form-control" name="tipoLogradouro"
							id="tipoLogradouro" maxlength="10"
							placeholder="Tipo do Logradouro"
							value="${cliente.tipoLogradouro }">
					</div>

					<div class="form-group col-md-8">
						<label for="numero">Numero</label> <input type="text"
							class="form-control" name="numero" id="numero" maxlength="10"
							placeholder="Número" value="${cliente.numero }">
					</div>
				</div>
				<div class="row">
					<div class="form-group col-md-8">
						<label for="bairro">Bairro</label> <input type="text"
							class="form-control" name="bairro" id="bairro" maxlength="100"
							placeholder="Bairro" value="${cliente.bairro }">
					</div>
					<div class="form-group col-md-8">
						<label for="cidade">Cidade</label> <input type="text"
							class="form-control" name="cidade" id="cidade" maxlength="100"
							placeholder="Cidade" value="${cliente.cidade }">
					</div>
					<div class="form-group col-md-8">
						<label for="estado">Estado</label> <input type="text"
							class="form-control" name="estado" id="estado" maxlength="2"
							placeholder="Estado" value="${cliente.estado }">
					</div>
					<div class="form-group col-md-8">
						<label for="pais">País</label> <input type="text"
							class="form-control" name="pais" id="pais" maxlength="100"
							placeholder="País" value="${cliente.pais }">
					</div>
					<div class="form-group col-md-8">
						<label for="telefone">Telefone</label> <input type="text"
							class="form-control" name="telefone" id="telefone" maxlength="20"
							placeholder="Telefone" value="${cliente.telefone }">
					</div>

				</div>
			</div>
			<hr />
			<div id="actions" class="row">
				<div class="col-md-12">
					<button type="submit" class="btn btn-primary" name="acao"
						value="criar">Salvar</button>
					<a href="index" class="btn btn-default">Cancelar</a>
				</div>
			</div>
		</form>

		<c:import url="Footer.jsp" />
	</div>
	<script src="js/jquery.min.js"></script>
	<script src="js/bootstrap.min.js"></script>
</body>

</html>