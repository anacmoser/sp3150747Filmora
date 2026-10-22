<%@ page language="java" contentType="text/html; charset=UTF-8"
         pageEncoding="UTF-8" isErrorPage="true" %>
<!DOCTYPE html>
<html lang="pt-BR">
<head>
    <meta charset="UTF-8">
    <title>Filmora - Erro</title>
    <link rel="stylesheet" href="css/estilo.css">
</head>
<body>
<header class="topo"><span class="logo">&#9679; Filmora</span></header>

<main class="conteudo">
    <h1>Ops, algo deu errado</h1>
    <p class="erro">
        <%= (exception != null && exception.getMessage() != null)
                ? exception.getMessage()
                : "Ocorreu um erro inesperado." %>
    </p>
    <p><a href="index.jsp">Voltar para o início</a></p>
</main>

<%@ include file="includes/rodape.jsp" %>
</body>
</html>
