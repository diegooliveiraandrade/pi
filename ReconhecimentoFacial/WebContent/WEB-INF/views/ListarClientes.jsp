<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
        <!DOCTYPE html>
        <html lang="pt-br">
        <head>
            <meta charset="utf-8">
            <meta http-equiv="X-UA-Compatible" content="IE=edge">
            <meta name="viewport" content="width=device-width, initial-scale=1">
            <title>Buscar Clientes</title>

            <link href="css/bootstrap.min.css" rel="stylesheet">
            <link href="css/style.css" rel="stylesheet">

        </head>

        <body>
            <!-- Modal -->
            <div class="modal fade" id="delete-modal" tabindex="-1" role="dialog" aria-labelledby="modalLabel">
                <div class="modal-dialog" role="document">
                    <div class="modal-content">
                        <div class="modal-header">
                            <button type="button" class="close" data-dismiss="modal" aria-label="Fechar"><span aria-hidden="true">&times;</span>
                            </button>
                            <h4 class="modal-title" id="modalLabel">Excluir Cliente</h4>
                        </div>
                        <div class="modal-body">
                            Deseja realmente excluir este cliente?
                        </div>
                        <div class="modal-footer">
                            <form action="excluir_cliente" method="post">
                                <input type="hidden" name="id" id="id_excluir" />
                                <button type="submit" class="btn btn-primary" name="acao" value="Excluir">Sim</button>
                                <button type="button" class="btn btn-default" data-dismiss="modal">N&atilde;o</button>
                            </form>
                        </div>
                    </div>
                </div>
            </div>
            <!-- /.modal -->
            <!-- Barra superior com os menus de navegação -->
			<c:import url="Menu.jsp"/>
            <!-- Container Principal -->
            <div id="main" class="container">
                <form action="listar_clientes" method="post">
                    <div id="top" class="row">
                        <div class="col-md-3">
                            <h2>Clientes</h2>
                        </div>

                        <div class="col-md-6">
                            <div class="input-group h2">
                                <input name="chave" class="form-control" id="search" type="text" placeholder="Pesquisar Clientes (deixe vazio para trazer todos)">
                                <span class="input-group-btn">
                <button class="btn btn-primary" type="submit" name="acao" value="listar">
                    <span class="glyphicon glyphicon-search"></span>
                                </button>
                                </span>
                            </div>
                        </div>
                        <div class="col-md-2">
                            <a href="busca_foto" class="btn btn-primary pull-right h2">Buscar por foto</a>
                        </div>

                        <div class="col-md-3">
                            <a href="novo_cliente" class="btn btn-primary pull-right h2">Novo Cliente</a>
                        </div>
                    </div>
                    <!-- /#top -->
                </form>
                <hr />
                <c:if test="${not empty lista}">
                <div id="list" class="row">

                    <div class="table-responsive col-md-12">
                        <table class="table table-striped" cellspacing="0" cellpadding="0">
                            <thead>
                                <tr>
                                    <th>ID</th>
                                    <th>Nome</th>
                                    <th>CPF</th>
                                    <th>RG</th>
                                    <th>E-Mail</th>
                                    <th>ID IMAGEM</th>
                                    <th>Endereço</th>
                                    <th>CEP</th>
                                    <th>Tipo Logradouro</th>
                                    <th>Número</th>
                                    <th>Bairro</th>
                                    <th>Cidade</th>
                                    <th>Estado</th>
                                    <th>País</th>
                                    <th>Telefone</th>
                                    <th class="actions">Ações</th>
                                </tr>
                            </thead>
                            <tbody>
          					<c:forEach var="cliente" items="${lista}">
                                       <tr>
                                            <td>
                                               ${cliente.id }
                                            </td>
                                            <td>
                                                ${cliente.nome }
                                            </td>
                                            <td>
                                                ${cliente.cpf }
                                            </td>
                                            <td>
                                                ${cliente.rg }
                                            </td>
                                            <td>
                                                ${cliente.email }
                                            </td>
                                            <td>
                                                ${cliente.idImagem }
                                            </td>
                                            <td>
                                                ${cliente.endereco }
                                            </td>
                                            <td>
                                                ${cliente.cep }
                                            </td>
                                            <td>
                                                ${cliente.tipoLogradouro }
                                            </td>
                                            <td>
                                                ${cliente.numero }
                                            </td>
                                            <td>
                                                ${cliente.bairro }
                                            </td>
                                            <td>
                                                ${cliente.cidade }
                                            </td>
                                            <td>
                                                ${cliente.estado }
                                            </td>
                                            <td>
                                                ${cliente.pais }
                                            </td>
                                            <td>
                                                ${cliente.telefone }
                                            </td>
                                            <td class="actions">
                                                <a class="btn btn-success btn-xs" href="visualizar_cliente?id=${cliente.id}">Visualizar</a>
                                                <a class="btn btn-warning btn-xs" href="alterar_cliente?id=${cliente.id}">Editar</a>
                                                <button id="btn${cliente.id }%>" type="button" class="btn btn-danger btn-xs" data-toggle="modal" data-target="#delete-modal" data-cliente="${cliente.id }">Excluir</button>
                                            </td>
                                        </tr>
                            </c:forEach>

                            </tbody>
                        </table>

                    </div>
                </div>
                <!-- /#list -->

                <div id="bottom" class="row">
                    <div class="col-md-12">
                        <!-- paginação ainda não foi implementada -->
                        <ul class="pagination">
                            <li class="disabled"><a>&lt; Anterior</a>
                            </li>
                            <li class="disabled"><a>1</a>
                            </li>
                            <li><a href="#">2</a>
                            </li>
                            <li><a href="#">3</a>
                            </li>
                            <li class="next"><a href="#" rel="next">Próximo &gt;</a>
                            </li>
                        </ul>
                        <!-- /.pagination -->
                    </div>
                </div>
                </c:if>
                <!-- /#bottom -->
            </div>
            <!-- /#main -->
            <script src="js/jquery.min.js"></script>
            <script src="js/bootstrap.min.js"></script>
            <script type="text/javascript">
                $("#delete-modal").on('show.bs.modal', function(event) {
                    var button = $(event.relatedTarget); //botao que disparou a modal
                    var recipient = button.data('cliente');
                    $("#id_excluir").val(recipient);
                });
            </script>
        </body>

        </html>