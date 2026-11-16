<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" errorPage="erro.jsp" %>
<%@ page import="java.util.*, modelo.*, util.*" %>
<%
    Caminhos.iniciar(application.getRealPath("/dados"));
    String erro = null;
    String tituloForm = "", anoForm = "", generoForm = "";
    int idForm = 0;
    Filme editando = null;
    String idEdicao = request.getParameter("id");
    if (idEdicao != null && !idEdicao.isEmpty()) {
        int id = Integer.parseInt(idEdicao);
        for (Filme f : new Filme().listar()) if (f.getId() == id) editando = f;
        if (editando == null) throw new IllegalArgumentException("Filme não encontrado.");
        idForm = editando.getId(); tituloForm = editando.getTitulo();
        anoForm = String.valueOf(editando.getAnoLancamento()); generoForm = editando.getGenero();
    }
    if ("POST".equalsIgnoreCase(request.getMethod())) {
        String acao = request.getParameter("acao");
        int id = Integer.parseInt(request.getParameter("registroId") == null ? "0" : request.getParameter("registroId"));
        if ("excluir".equals(acao)) {
            Filme f = new Filme(); f.setId(id); f.excluir(); response.sendRedirect("filmes.jsp"); return;
        }
        tituloForm = request.getParameter("titulo").trim();
        anoForm = request.getParameter("ano").trim(); generoForm = request.getParameter("genero").trim(); idForm = id;
        if (tituloForm.isEmpty() || anoForm.isEmpty() || generoForm.isEmpty()) erro = "Preencha título, ano e gênero.";
        else {
            int ano = Integer.parseInt(anoForm);
            if (ano < 1888 || ano > 3000) erro = "Informe um ano válido (a partir de 1888).";
            else {
                Filme f = new Filme(); f.setId(id); f.setTitulo(tituloForm); f.setAnoLancamento(ano); f.setGenero(generoForm);
                if (id == 0) f.incluir(); else f.alterar();
                response.sendRedirect("filmes.jsp"); return;
            }
        }
    }
    List<Filme> filmes = new Filme().listar();
%>
<!DOCTYPE html><html lang="pt-BR"><head><meta charset="UTF-8"><meta name="viewport" content="width=device-width, initial-scale=1">
<title>Filmes · Filmora</title><link rel="stylesheet" href="css/estilo.css"></head><body>
<%@ include file="includes/cabecalho.jsp" %>
<main class="pagina"><div class="titulo-pagina"><div><p class="sobrelinha">CATÁLOGO</p><h1>Filmes</h1><p class="subtitulo">Seus filmes, organizados em um só lugar.</p></div>
<a class="botao" href="filmes.jsp#formulario">＋ Novo filme</a></div>
<div class="duas-colunas"><section class="painel"><div class="painel-cabecalho"><h2>Todos os filmes</h2><span class="contador"><%= filmes.size() %></span></div>
<% if (filmes.isEmpty()) { %><div class="vazio compacto"><p>Nenhum filme cadastrado ainda.</p></div><% } else { %>
<div class="tabela-rolagem"><table><thead><tr><th>Título</th><th>Diretor / participações</th><th>Ano</th><th>Gênero</th><th>Ações</th></tr></thead><tbody>
<% for (Filme f : filmes) { String creditos=""; for (Participacao p : new Participacao().listar()) if (p.getFilmeId()==f.getId()) {
    for (Profissional pr : new persistencia.RepositorioProfissionais().listar()) if (pr.getId()==p.getProfissionalId()) creditos += (creditos.isEmpty()?"":", ")+pr.getNome()+" ("+p.getFuncao()+")"; }
%><tr><td><strong><%= Html.escapar(f.getTitulo()) %></strong></td><td><%= creditos.isEmpty()?"—":Html.escapar(creditos) %></td>
<td><%= f.getAnoLancamento() %></td><td><%= Html.escapar(f.getGenero()) %></td><td class="acoes"><a href="filmes.jsp?id=<%= f.getId() %>#formulario">Editar</a>
<form method="post" action="filmes.jsp" onsubmit="return confirm('Excluir este filme e seus vínculos e avaliações?')"><input type="hidden" name="acao" value="excluir"><input type="hidden" name="registroId" value="<%= f.getId() %>"><button class="link-perigo">Excluir</button></form></td></tr><% } %>
</tbody></table></div><% } %></section>
<section class="painel formulario" id="formulario"><div class="painel-cabecalho"><h2><%= idForm==0?"Novo filme":"Editar filme" %></h2></div>
<% if (erro != null) { %><p class="mensagem-erro"><%= Html.escapar(erro) %></p><% } %>
<form method="post" action="filmes.jsp" class="campos"><input type="hidden" name="acao" value="salvar"><input type="hidden" name="registroId" value="<%= idForm %>">
<label>Título<input name="titulo" required maxlength="150" value="<%= Html.escapar(tituloForm) %>" placeholder="Digite o título do filme"></label>
<label>Ano de lançamento<input name="ano" type="number" required min="1888" max="3000" value="<%= Html.escapar(anoForm) %>" placeholder="Ex.: 2005"></label>
<label>Gênero<input name="genero" required maxlength="60" value="<%= Html.escapar(generoForm) %>" placeholder="Ex.: Romance"></label>
<p class="dica">Direção, elenco e roteiro são associados em Participações.</p>
<div class="botoes"><a class="botao botao-secundario" href="filmes.jsp">Cancelar</a><button class="botao" type="submit"><%= idForm==0?"Cadastrar filme":"Salvar alterações" %></button></div></form></section></div></main>
<%@ include file="includes/rodape.jsp" %></body></html>