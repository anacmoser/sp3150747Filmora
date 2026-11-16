<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" errorPage="erro.jsp" %>
<%@ page import="java.util.*, modelo.*, util.Html" %>
<%
    Caminhos.iniciar(application.getRealPath("/dados"));
    List<Filme> filmes = new Filme().listar();
    List<Profissional> profissionais = new persistencia.RepositorioProfissionais().listar();
    List<Avaliacao> avaliacoes = new Avaliacao().listar();
    Collections.sort(avaliacoes, (a, b) -> b.getData().compareTo(a.getData()));
%>
<!DOCTYPE html>
<html lang="pt-BR">
<head>
    <meta charset="UTF-8"><meta name="viewport" content="width=device-width, initial-scale=1">
    <title>Filmora · Descubra filmes</title><link rel="stylesheet" href="css/estilo.css">
</head>
<body>
<%@ include file="includes/cabecalho.jsp" %>
<main class="pagina inicio">
    <section class="principal">
        <div class="titulo-pagina"><div><p class="sobrelinha">SEU CATÁLOGO PESSOAL</p><h1>Descubra filmes</h1>
            <p class="subtitulo">Cadastre, avalie e organize o que você assiste.</p></div>
            <a class="botao" href="filmes.jsp">＋ Cadastrar filme</a></div>
        <div class="resumos">
            <a class="resumo" href="filmes.jsp"><strong><%= filmes.size() %></strong><span>filmes</span></a>
            <a class="resumo" href="profissionais.jsp"><strong><%= profissionais.size() %></strong><span>profissionais</span></a>
            <a class="resumo" href="avaliacoes.jsp"><strong><%= avaliacoes.size() %></strong><span>avaliações</span></a>
        </div>
        <div class="filtros">
            <label>Gênero<select disabled><option>Todos os gêneros</option></select></label>
            <label>Ano<select disabled><option>Todos os anos</option></select></label>
            <label>Nota mínima<select disabled><option>Qualquer nota</option></select></label>
            <label class="busca">Buscar<input disabled placeholder="Buscar filmes, pessoas, listas…"></label>
        </div>
        <p class="aviso-visual">Aviso: os filtros e a busca são apenas visuais nesta versão e não alteram os resultados.</p>
        <div class="secao-titulo"><div><h2>Filmes em destaque</h2><span><%= filmes.size() %> filme(s)</span></div>
            <a href="filmes.jsp">Ver catálogo →</a></div>
        <% if (filmes.isEmpty()) { %>
            <div class="vazio"><span class="vazio-icone">✦</span><h3>Seu catálogo começa aqui</h3>
                <p>Cadastre um filme e registre sua primeira avaliação.</p><a class="botao" href="filmes.jsp">Adicionar primeiro filme</a></div>
        <% } else { %>
            <div class="grade-filmes">
            <% for (Filme filme : filmes) {
                List<Avaliacao> doFilme = new ArrayList<Avaliacao>(); double soma = 0;
                for (Avaliacao av : avaliacoes) if (av.getFilmeId() == filme.getId()) { doFilme.add(av); soma += av.getNota(); }
                int estrelas = doFilme.isEmpty() ? 0 : (int)Math.round(soma / doFilme.size());
            %>
                <article class="cartaz"><a class="capa" href="filmes.jsp?id=<%= filme.getId() %>"><span>FILMORA</span><b>✦</b></a>
                    <h3><%= Html.escapar(filme.getTitulo()) %></h3>
                    <p><%= filme.getAnoLancamento() %> · <%= Html.escapar(filme.getGenero()) %></p>
                    <% if (doFilme.isEmpty()) { %><span class="texto-suave">Sem avaliações</span><% }
                       else { %><span class="estrelas"><% for (int i=0;i<5;i++) { %><%= i < estrelas ? "★" : "☆" %><% } %></span><% } %>
                </article>
            <% } %>
            </div>
        <% } %>
    </section>
    <aside class="painel-lateral"><h2>Atividade recente</h2>
        <% if (avaliacoes.isEmpty()) { %><p class="texto-suave">Suas avaliações aparecerão aqui.</p>
        <% } else { for (int i=0; i<avaliacoes.size() && i<5; i++) { Avaliacao av = avaliacoes.get(i);
            String titulo = "Filme removido";
            for (Filme f : filmes) if (f.getId() == av.getFilmeId()) titulo = f.getTitulo(); %>
            <div class="atividade"><span class="avatar">✦</span><div><strong>Você avaliou</strong>
                <p><%= Html.escapar(titulo) %></p><span class="estrelas"><% for (int n=0;n<5;n++) { %><%= n<av.getNota()?"★":"☆" %><% } %></span></div></div>
        <% } } %>
        <a class="botao botao-secundario largura-total" href="avaliacoes.jsp">Ver avaliações</a>
    </aside>
</main>
<%@ include file="includes/rodape.jsp" %>
</body></html>