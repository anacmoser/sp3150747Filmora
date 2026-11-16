<%@ page pageEncoding="UTF-8" %><%@ page import="util.Caminhos" %>
<%
    Caminhos.iniciar(application.getRealPath("/dados"));
    String paginaAtual = request.getRequestURI();
%>
<header class="topo">
	<a class="logo" href="<%= request.getContextPath() %>/index.jsp">
	  <img class="logo-imagem" src="<%= request.getContextPath() %>/img/logo-filmora.png" alt="Logo Filmora">
	  Filmora
	</a>
    <nav>
        <a class="<%= paginaAtual.endsWith("index.jsp") ? "ativo" : "" %>" href="index.jsp">Explorar</a>
        <a class="<%= paginaAtual.endsWith("filmes.jsp") ? "ativo" : "" %>" href="filmes.jsp">Filmes</a>
        <a class="<%= paginaAtual.endsWith("profissionais.jsp") ? "ativo" : "" %>" href="profissionais.jsp">Profissionais</a>
        <a class="<%= paginaAtual.endsWith("avaliacoes.jsp") ? "ativo" : "" %>" href="avaliacoes.jsp">Avaliações</a>
        <a class="<%= paginaAtual.endsWith("participacoes.jsp") ? "ativo" : "" %>" href="participacoes.jsp">Participações</a>
    </nav>
</header>