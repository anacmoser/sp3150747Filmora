<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" errorPage="erro.jsp" %>
<%@ page import="java.util.*, modelo.*, util.*" %>
<%
    Caminhos.iniciar(application.getRealPath("/dados"));String erro=null;
    List<Filme> filmes=new Filme().listar();List<Profissional> profissionais=new persistencia.RepositorioProfissionais().listar();
    if("POST".equalsIgnoreCase(request.getMethod())){String acao=request.getParameter("acao");
        if("excluir".equals(acao)){Participacao p=new Participacao();p.setId(Integer.parseInt(request.getParameter("registroId")));p.excluir();response.sendRedirect("participacoes.jsp");return;}
        int filmeId=Integer.parseInt(request.getParameter("filmeId"));int profId=Integer.parseInt(request.getParameter("profissionalId"));
        String funcao=request.getParameter("funcao");String personagem=request.getParameter("personagem").trim();
        boolean filmeExiste=false,profExiste=false;for(Filme f:filmes)if(f.getId()==filmeId)filmeExiste=true;for(Profissional p:profissionais)if(p.getId()==profId)profExiste=true;
        if(!filmeExiste||!profExiste)erro="Escolha um filme e um profissional cadastrados.";
        else {Participacao p=new Participacao();p.setFilmeId(filmeId);p.setProfissionalId(profId);p.setFuncao(funcao);p.setPersonagem(personagem);p.incluir();response.sendRedirect("participacoes.jsp");return;}
    }
    List<Participacao> participacoes=new Participacao().listar();
%>
<!DOCTYPE html><html lang="pt-BR"><head><meta charset="UTF-8"><meta name="viewport" content="width=device-width, initial-scale=1"><title>Participações · Filmora</title><link rel="stylesheet" href="css/estilo.css"></head><body>
<%@ include file="includes/cabecalho.jsp" %><main class="pagina"><div class="titulo-pagina"><div><p class="sobrelinha">RELAÇÕES DO CATÁLOGO</p><h1>Participações</h1><p class="subtitulo">Associe profissionais às obras em que trabalharam.</p></div></div>
<div class="duas-colunas"><section class="painel"><div class="painel-cabecalho"><h2>Créditos registrados</h2><span class="contador"><%=participacoes.size()%></span></div>
<%if(participacoes.isEmpty()){%><div class="vazio compacto"><p>Nenhuma participação registrada.</p></div><%}else{%><div class="tabela-rolagem"><table><thead><tr><th>Filme</th><th>Profissional</th><th>Função</th><th>Personagem / crédito</th><th>Ação</th></tr></thead><tbody>
<%for(Participacao p:participacoes){String filme="Filme removido",prof="Profissional removido";for(Filme f:filmes)if(f.getId()==p.getFilmeId())filme=f.getTitulo();for(Profissional pr:profissionais)if(pr.getId()==p.getProfissionalId())prof=pr.getNome();%>
<tr><td><%=Html.escapar(filme)%></td><td><%=Html.escapar(prof)%></td><td><%=Html.escapar(p.getFuncao())%></td><td><%=Html.escapar(p.getPersonagem())%></td><td><form method="post" action="participacoes.jsp"><input type="hidden" name="acao" value="excluir"><input type="hidden" name="registroId" value="<%=p.getId()%>"><button class="link-perigo">Remover</button></form></td></tr><%}%>
</tbody></table></div><%}%></section>
<section class="painel formulario"><div class="painel-cabecalho"><h2>Adicionar participação</h2></div><%if(erro!=null){%><p class="mensagem-erro"><%=Html.escapar(erro)%></p><%}%>
<%if(filmes.isEmpty()||profissionais.isEmpty()){%><p class="dica">Cadastre ao menos um filme e um profissional antes de criar o vínculo.</p><%}%>
<form method="post" action="participacoes.jsp" class="campos"><input type="hidden" name="acao" value="salvar">
<label>Filme<select name="filmeId" required><option value="">Selecione</option><%for(Filme f:filmes){%><option value="<%=f.getId()%>"><%=Html.escapar(f.getTitulo())%></option><%}%></select></label>
<label>Profissional<select name="profissionalId" required><option value="">Selecione</option><%for(Profissional p:profissionais){%><option value="<%=p.getId()%>"><%=Html.escapar(p.getNome())%> · <%=Html.escapar(p.getTipo())%></option><%}%></select></label>
<label>Função<select name="funcao"><option>Direção</option><option>Atuação</option><option>Roteiro</option><option>Outra</option></select></label>
<label>Personagem / crédito<input name="personagem" maxlength="100" placeholder="Opcional"></label>
<button class="botao" <%=filmes.isEmpty()||profissionais.isEmpty()?"disabled":""%>>Registrar participação</button></form></section></div></main>
<%@ include file="includes/rodape.jsp" %></body></html>