<%@ page import="util.Caminhos" %>
<%
    // Informa à aplicação onde está a pasta "dados" (arquivos .json).
    // Toda página que inclui este cabeçalho já fica pronta para ler/gravar JSON.
    Caminhos.iniciar(application.getRealPath("/dados"));
%>
<header class="topo">
    <span class="logo">&#9679; Filmora</span>
    <nav>
        <a href="index.jsp">Explorar</a>
        <!-- TODO: trocar "#" pelas páginas quando forem criadas -->
        <a href="#">Filmes</a>
        <a href="#">Profissionais</a>
        <a href="#">Avaliações</a>
    </nav>
</header>
