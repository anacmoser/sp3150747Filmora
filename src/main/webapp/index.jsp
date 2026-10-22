<%@ page language="java" contentType="text/html; charset=UTF-8"
         pageEncoding="UTF-8" errorPage="erro.jsp" %>
<%@ page import="java.util.List, modelo.Filme, modelo.Profissional, modelo.Avaliacao" %>
<!DOCTYPE html>
<html lang="pt-BR">
<head>
    <meta charset="UTF-8">
    <title>Filmora - Catálogo de Filmes</title>
    <link rel="stylesheet" href="css/estilo.css">
</head>
<body>
<%@ include file="includes/cabecalho.jsp" %>

<main class="conteudo">
    <h1>Descubra filmes</h1>
    <p>Cadastre, avalie e organize o que você assiste.</p>

    <%
        // Teste da primeira versão: a Gson lê os arquivos .json da pasta "dados".
        List<Filme> filmes = new Filme().listar();
        List<Profissional> profissionais = new Profissional().listar();
        List<Avaliacao> avaliacoes = new Avaliacao().listar();
    %>

    <section class="cartoes">
        <div class="cartao"><strong><%= filmes.size() %></strong><span>filmes</span></div>
        <div class="cartao"><strong><%= profissionais.size() %></strong><span>profissionais</span></div>
        <div class="cartao"><strong><%= avaliacoes.size() %></strong><span>avaliações</span></div>
    </section>

    <p class="ok">Ambiente funcionando: Tomcat, JSP e Gson lendo os JSON.</p>
</main>

<%@ include file="includes/rodape.jsp" %>
</body>
</html>
