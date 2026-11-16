<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" errorPage="erro.jsp" %>
<%@ page import="java.util.*, modelo.*, util.*" %>
<%
    Caminhos.iniciar(application.getRealPath("/dados"));
    String erro=null, comentarioForm="", dataForm="", filmeIdForm="", notaForm="5";
    boolean reassistidoForm=false; int idForm=0; Avaliacao editando=null;
    String idEdicao=request.getParameter("id");
    if(idEdicao!=null&&!idEdicao.isEmpty()){int id=Integer.parseInt(idEdicao);for(Avaliacao a:new Avaliacao().listar())if(a.getId()==id)editando=a;
        if(editando==null)throw new IllegalArgumentException("Avaliação não encontrada.");
        idForm=editando.getId(); filmeIdForm=String.valueOf(editando.getFilmeId()); notaForm=String.valueOf(editando.getNota());
        comentarioForm=editando.getComentario();dataForm=editando.getData();reassistidoForm=editando.isReassistido();}
    if("POST".equalsIgnoreCase(request.getMethod())){String acao=request.getParameter("acao");int id=Integer.parseInt(request.getParameter("registroId")==null?"0":request.getParameter("registroId"));
        if("excluir".equals(acao)){Avaliacao a=new Avaliacao();a.setId(id);a.excluir();response.sendRedirect("avaliacoes.jsp");return;}
        filmeIdForm=request.getParameter("filmeId");notaForm=request.getParameter("nota");comentarioForm=request.getParameter("comentario").trim();dataForm=request.getParameter("data");
        reassistidoForm="true".equals(request.getParameter("reassistido"));idForm=id;
        if(filmeIdForm==null||filmeIdForm.isEmpty()||dataForm==null||dataForm.isEmpty())erro="Escolha um filme e informe a data.";
        else {int filmeId=Integer.parseInt(filmeIdForm);int nota=Integer.parseInt(notaForm);
            boolean filmeExiste=false;for(Filme f:new Filme().listar())if(f.getId()==filmeId)filmeExiste=true;
            if(!filmeExiste)erro="O filme escolhido não existe.";else if(nota<1||nota>5)erro="A nota deve ser de 1 a 5.";
            else {Avaliacao a=new Avaliacao();a.setId(id);a.setFilmeId(filmeId);a.setNota(nota);a.setComentario(comentarioForm);a.setData(dataForm);a.setReassistido(reassistidoForm);
                if(id==0)a.incluir();else a.alterar();response.sendRedirect("avaliacoes.jsp");return;}}
    }
    List<Avaliacao> avaliacoes=new Avaliacao().listar();List<Filme> filmes=new Filme().listar();
    Collections.sort(avaliacoes,(a,b)->b.getData().compareTo(a.getData()));
%>
<!DOCTYPE html><html lang="pt-BR"><head><meta charset="UTF-8"><meta name="viewport" content="width=device-width, initial-scale=1"><title>Avaliações · Filmora</title><link rel="stylesheet" href="css/estilo.css"></head><body>
<%@ include file="includes/cabecalho.jsp" %><main class="pagina"><div class="titulo-pagina"><div><p class="sobrelinha">SEU DIÁRIO DE CINEMA</p><h1>Avaliações</h1><p class="subtitulo">Registre suas notas e comentários sobre cada filme.</p></div><a class="botao" href="avaliacoes.jsp#formulario">＋ Nova avaliação</a></div>
<div class="duas-colunas"><section class="painel"><div class="painel-cabecalho"><h2>Suas avaliações</h2><span class="contador"><%= avaliacoes.size() %></span></div>
<% if(avaliacoes.isEmpty()){ %><div class="vazio compacto"><p>Nenhuma avaliação cadastrada.</p></div><% } else { %><div class="lista-avaliacoes">
<% for(Avaliacao a:avaliacoes){String titulo="Filme removido";for(Filme f:filmes)if(f.getId()==a.getFilmeId())titulo=f.getTitulo(); %>
<article class="item-avaliacao"><div><strong><%= Html.escapar(titulo) %></strong><span class="estrelas"><%for(int i=0;i<5;i++){%><%=i<a.getNota()?"★":"☆"%><%}%></span></div>
<p><%= Html.escapar(a.getComentario()) %></p><small><%= Html.escapar(a.getData()) %><%= a.isReassistido()?" · Reassistido":"" %></small>
<div class="acoes"><a href="avaliacoes.jsp?id=<%=a.getId()%>#formulario">Editar</a><form method="post" action="avaliacoes.jsp" onsubmit="return confirm('Excluir esta avaliação?')"><input type="hidden" name="acao" value="excluir"><input type="hidden" name="registroId" value="<%=a.getId()%>"><button class="link-perigo">Excluir</button></form></div></article><%}%>
</div><%}%></section>
<section class="painel formulario" id="formulario"><div class="painel-cabecalho"><h2><%=idForm==0?"Nova avaliação":"Editar avaliação"%></h2></div>
<%if(erro!=null){%><p class="mensagem-erro"><%=Html.escapar(erro)%></p><%}%>
<%if(filmes.isEmpty()){%><p class="dica">Cadastre um filme antes de avaliá-lo.</p><%}%>
<form method="post" action="avaliacoes.jsp" class="campos"><input type="hidden" name="acao" value="salvar"><input type="hidden" name="registroId" value="<%=idForm%>">
<label>Filme<select name="filmeId" required><option value="">Selecione um filme</option><%for(Filme f:filmes){%><option value="<%=f.getId()%>" <%=String.valueOf(f.getId()).equals(filmeIdForm)?"selected":""%>><%=Html.escapar(f.getTitulo())%></option><%}%></select></label>
<label>Nota<select name="nota"><%for(int n=1;n<=5;n++){%><option value="<%=n%>" <%=String.valueOf(n).equals(notaForm)?"selected":""%>><%=n%> estrela(s)</option><%}%></select></label>
<label>Comentário<textarea name="comentario" rows="4" maxlength="1000"><%=Html.escapar(comentarioForm)%></textarea></label>
<label>Data<input type="date" name="data" required value="<%=Html.escapar(dataForm)%>"></label>
<label class="linha-checkbox"><input type="checkbox" name="reassistido" value="true" <%=reassistidoForm?"checked":""%>> Reassisti a este filme</label>
<div class="botoes"><a class="botao botao-secundario" href="avaliacoes.jsp">Cancelar</a><button class="botao" <%=filmes.isEmpty()?"disabled":""%>><%=idForm==0?"Cadastrar avaliação":"Salvar alterações"%></button></div></form></section></div></main>
<%@ include file="includes/rodape.jsp" %></body></html>