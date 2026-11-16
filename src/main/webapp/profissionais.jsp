<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" errorPage="erro.jsp" %>
<%@ page import="java.util.*, modelo.*, util.*" %>
<%
    Caminhos.iniciar(application.getRealPath("/dados"));
    String erro=null, nomeForm="", idadeForm="", tipoForm="ATOR";
    int idForm=0; Profissional editando=null;
    String idEdicao=request.getParameter("id");
    if(idEdicao!=null && !idEdicao.isEmpty()) { int id=Integer.parseInt(idEdicao);
        for(Profissional p:new persistencia.RepositorioProfissionais().listar()) if(p.getId()==id) editando=p;
        if(editando==null) throw new IllegalArgumentException("Profissional não encontrado.");
        idForm=editando.getId(); nomeForm=editando.getNome(); idadeForm=String.valueOf(editando.getIdade()); tipoForm=editando.getTipo();
    }
    if("POST".equalsIgnoreCase(request.getMethod())) {
        String acao=request.getParameter("acao"); int id=Integer.parseInt(request.getParameter("registroId")==null?"0":request.getParameter("registroId"));
        if("excluir".equals(acao)){Profissional p=new Ator();p.setId(id);p.excluir();response.sendRedirect("profissionais.jsp");return;}
        nomeForm=request.getParameter("nome").trim(); idadeForm=request.getParameter("idade").trim();
        tipoForm=request.getParameter("tipo"); idForm=id;
        if(nomeForm.isEmpty()||idadeForm.isEmpty()) erro="Preencha nome e idade.";
        else {int idade=Integer.parseInt(idadeForm); if(idade<0||idade>150) erro="Informe uma idade válida.";
            else {Profissional p;
                if("DIRETOR".equals(tipoForm)) p=new Diretor();
                else if("ROTEIRISTA".equals(tipoForm)) p=new Roteirista();
                else p=new Ator();
                p.setId(id);p.setNome(nomeForm);p.setIdade(idade);
                if(id==0)p.incluir();else p.alterar();response.sendRedirect("profissionais.jsp");return;
            }
        }
    }
    List<Profissional> profissionais=new persistencia.RepositorioProfissionais().listar();
%>
<!DOCTYPE html><html lang="pt-BR"><head><meta charset="UTF-8"><meta name="viewport" content="width=device-width, initial-scale=1"><title>Profissionais · Filmora</title><link rel="stylesheet" href="css/estilo.css"></head><body>
<%@ include file="includes/cabecalho.jsp" %><main class="pagina"><div class="titulo-pagina"><div><p class="sobrelinha">ELENCO E EQUIPE</p><h1>Profissionais</h1><p class="subtitulo">Atores, diretores e roteiristas dos filmes.</p></div><a class="botao" href="profissionais.jsp#formulario">＋ Novo profissional</a></div>
<div class="duas-colunas"><section class="painel"><div class="painel-cabecalho"><h2>Todos os profissionais</h2><span class="contador"><%= profissionais.size() %></span></div>
<% if(profissionais.isEmpty()) { %><div class="vazio compacto"><p>Nenhum profissional cadastrado.</p></div><% } else { %><div class="tabela-rolagem"><table><thead><tr><th>Nome</th><th>Tipo</th><th>Idade</th><th>Ações</th></tr></thead><tbody>
<% for(Profissional p:profissionais){String tipo="ATOR".equals(p.getTipo())?"Ator / Atriz":"DIRETOR".equals(p.getTipo())?"Diretor(a)":"Roteirista";
%>
<tr><td><strong><%= Html.escapar(p.getNome()) %></strong></td><td><span class="etiqueta"><%= tipo %></span></td><td><%= p.getIdade() %></td><td class="acoes"><a href="profissionais.jsp?id=<%= p.getId() %>#formulario">Editar</a>
<form method="post" action="profissionais.jsp" onsubmit="return confirm('Excluir profissional e suas participações?')"><input type="hidden" name="acao" value="excluir"><input type="hidden" name="registroId" value="<%= p.getId() %>"><button class="link-perigo">Excluir</button></form></td></tr><% } %>
</tbody></table></div><% } %></section>
<section class="painel formulario" id="formulario"><div class="painel-cabecalho"><h2><%= idForm==0?"Novo profissional":"Editar profissional" %></h2></div>
<% if(erro!=null){ %><p class="mensagem-erro"><%= Html.escapar(erro) %></p><% } %><form method="post" action="profissionais.jsp" class="campos"><input type="hidden" name="acao" value="salvar"><input type="hidden" name="registroId" value="<%= idForm %>">
<label>Tipo<select name="tipo"><option value="ATOR" <%= "ATOR".equals(tipoForm)?"selected":"" %>>Ator / Atriz</option><option value="DIRETOR" <%= "DIRETOR".equals(tipoForm)?"selected":"" %>>Diretor(a)</option><option value="ROTEIRISTA" <%= "ROTEIRISTA".equals(tipoForm)?"selected":"" %>>Roteirista</option></select></label>
<label>Nome<input name="nome" required maxlength="120" value="<%= Html.escapar(nomeForm) %>" placeholder="Digite o nome"></label>
<label>Idade<input name="idade" type="number" required min="0" max="150" value="<%= Html.escapar(idadeForm) %>" placeholder="Idade"></label>
<p class="dica">Escolha o tipo e informe nome e idade. Os atributos das subclasses permanecem no modelo, mas não são necessários para o cadastro.</p><div class="botoes"><a class="botao botao-secundario" href="profissionais.jsp">Cancelar</a><button class="botao"><%= idForm==0?"Cadastrar profissional":"Salvar alterações" %></button></div></form></section></div></main>
<%@ include file="includes/rodape.jsp" %></body></html>