<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" isErrorPage="true" %>
<%@ page import="util.Html" %>
<!DOCTYPE html><html lang="pt-BR"><head><meta charset="UTF-8"><meta name="viewport" content="width=device-width, initial-scale=1"><title>Erro · Filmora</title><link rel="stylesheet" href="css/estilo.css"></head><body>
<%@ include file="includes/cabecalho.jsp" %><main class="pagina"><section class="painel erro-pagina"><p class="sobrelinha">FILMORA</p><h1>Ops, algo deu errado</h1>
<p class="mensagem-erro"><%=exception!=null&&exception.getMessage()!=null?Html.escapar(exception.getMessage()):"Ocorreu um erro inesperado."%></p><a class="botao" href="index.jsp">Voltar ao início</a></section></main>
<%@ include file="includes/rodape.jsp" %></body></html>