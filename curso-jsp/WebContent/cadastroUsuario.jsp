<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
	pageEncoding="ISO-8859-1"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<title>Cadastro de usu�rio</title>
<link rel="stylesheet" href="resources/css/cadastro.css">

<!-- Adicionando JQuery -->
<script src="https://code.jquery.com/jquery-3.4.1.min.js"
	integrity="sha256-CSXorXvZcTkaix6Yvo6HppcZGetbYMGWSFlBw8HfCJo="
	crossorigin="anonymous"></script>


</head>
<body>
	<!-- Tela de manipula��o de tabela usuario no Banco de Dados. -->
	
	<a href="acessoliberado.jsp">Inicio </a>
	<a href="index.jsp"> Sair</a>
	<center>
		<h1>Cadastro de Usu�rio</h1>
		<h3 style="color: orange;">${msg}</h3>
	</center>

	<form action="salvarUsuario" method="post" id="formUser"
		onsubmit="return validarCampos()? true : false;" enctype="multipart/form-data" >
		<ul class="form-style-1">
			<li>
				<table>
					<tr>
						<td>ID:</td>
						<td><input type="text" readonly="readonly" id="id" name="id"
							value="${user.id}" class="field-long" /></td>

						<td>Cep:</td>
						<td><input type="text" id="cep" name="cep" value=""
							onblur="consultaCep();" value="${user.cep}"
							placeholder="D�gite o seu CEP:" maxlength="9" /></td>
					</tr>
					<tr>
						<td>Login:</td>
						<td><input type="text" id="login" name="login"
							value="${user.login}" maxlength="10" placeholder="Cadastre o seu Login:"></td>
					</tr>

					<tr>
						<td>Senha:</td>
						<td><input type="password" id="senha" name="senha"
							value="${user.senha}" maxlength="50" placeholder="Cadastre a sua Senha:"></td>
					</tr>
					<tr>
						<td>Nome:</td>
						<td><input type="text" id="nome" name="nome"
							value="${user.nome}" maxlength="50" placeholder="Informe o seu nome:"></td>
					</tr>
					
					<tr>
						<td>IBGE:</td>
						<td><input type="text" id="ibge" name="ibge" maxlength="20" ${user.ibge}
							placeholder="Digite o IBGE:"></td>
					</tr>

					<tr>
						<td>
							Foto:
						</td>
						
						<td>
							<input type="file" name="foto">
							<input type="text" style="display: none;" name="fotoTemp" readonly="readonly" value="${user.fotoBase64}"/>
							<input type="text" style="display: none;" name="contentTypeTemp" readonly="readonly" value="${user.contentType}"/>
						</td>
					</tr>
					
						<tr>
						<td>
							Curr�culo:
						</td>
						
						<td>
							<input type="file" name="curriculo" value="curriculo"/>
							<input type="text" style="display: none;" name="fotoTempPDF" readonly="readonly" value="${user.curriculoBase64}"/>
							<input type="text" style="display: none;" name="contentTypeTempPDF" readonly="readonly" value="${user.contentTypeCurriculo}"/>
						</td>
					</tr>

					<tr>
						<td></td>
						
						<td>
						<input type="submit" value="Salvar" style="width: 173px;"/> 
						</td>
						<td></td>
						<td>
						<input type="submit" value="Cancelar" style="width: 173px;"
							onclick="document.getElementById('formUser').action = 'salvarUsuario?acao=reset'">
						</td>
					</tr>
				</table>

			</li>
		</ul>
	</form>

	<div class="container">
		<table class="responsive-table">
			<caption>Usu�rios cadastrados</caption>
			<tr>
				<th>Id</th>
				<th>Foto</th>
				<th>Curricullo</th>
				<th>Nome</th>
				<th>Telefones</th>
				<th>Excluir</th>
				<th>Atualizar</th>
				

			</tr>
			<c:forEach items="${usuarios}" var="user">
				<tr>
					<td style="width: 150px"><c:out value="${user.id}"/></td>
					
					<c:if test="${user.fotoBase64.isEmpty() == false}">
					<td><a href="salvarUsuario?acao=download&tipo=imagem&user=${user.id}"><img src='<c:out value="${user.tempFotoUser}"/>' alt="Imagem User" title="Imagem User" width="32px" height="32px" /></a></td>
					</c:if>
					<c:if test="${user.fotoBase64.isEmpty() == true }">
						<td><a href="salvarUsuario?acao=download&tipo=image&user=${user.id}"><img alt="Imagem null" src="resources/img/icon-user-null.jpg" width="32px" height="32px" onclick="alert('N�o possui imagem')"></td>
					</c:if>
					
					<c:if test="${user.curriculoBase64.isEmpty() == false}">
					<td><a href="salvarUsuario?acao=download&tipo=curriculo&user=${user.id}"><img alt="Curriculo" src="resources/img/icon-pdf.png" width="32px" height="32px"></a></td>
					</c:if>
					<c:if test="${user.curriculoBase64.isEmpty() == true}">
						<td><img alt="Curriculo" src="resources/img/icon-pdf.png" width="32px" height="32px" onclick="alert('N�o possui arquivos para download')"></td>
					</c:if>
					
					<td><c:out value="${user.nome}"></c:out></td>
					<td><a href="salvarTelefones?acao=addFone&user=${user.id}"><img alt="Telefones" title="Telefones"
							src="resources/img/icone-phone.png" width="20px" height="20px"></a></td>
					<td><a href="salvarUsuario?acao=delete&user=${user.id}"><img src="resources/img/excluir.png" alt="excluir" title="Excluir"
							width="20px" height="20px"> </a></td>
					<td><a href="salvarUsuario?acao=editar&user=${user.id}"><img alt="Editar" title="Editar" src="resources/img/editar.png"
							width="20px" height="20px"></a></td>
					

				</tr>
			</c:forEach>
		</table>
	</div>

	<script type="text/javascript">
		function validarCampos() {
			if (document.getElementById("login").value == '') {
				alert('Informe o Login');
				return false;
			} else

			if (document.getElementById("senha").value == '') {
				alert('Informe a Senha');
				return false;
			} else

			if (document.getElementById("nome").value == '') {
				alert('Informe o Nome');
				return false;
			} else

			if (document.getElementById("fone").value == '') {
				alert('Informe o telefone');
				return false;
			}

			return true;
		}

		function consultaCep() {
			var cep = $("#cep").val();

			//Consulta o webservice viacep.com.br/
			$.getJSON("https://viacep.com.br/ws/" + cep + "/json/?callback=?",
					function(dados) {

						if (!("erro" in dados)) {
							//Atualiza os campos com os valores da consulta.
							$("#rua").val(dados.logradouro);
							$("#bairro").val(dados.bairro);
							$("#cidade").val(dados.localidade);
							$("#estado").val(dados.uf);
							$("#ibge").val(dados.ibge);
						} //end if.
						else {
							//CEP pesquisado n�o foi encontrado.
							$("#cep").val('');
							$("#rua").val('');
							$("#bairro").val('');
							$("#cidade").val('');
							$("#estado").val('');
							$("#ibge").val('');
							alert("CEP n�o encontrado");
						}
					});

		}
	</script>

</body>
</html>