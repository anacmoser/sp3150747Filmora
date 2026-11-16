package modelo;

import java.util.List;
import persistencia.RepositorioProfissionais;

public abstract class Profissional implements Identificavel {
    private static final RepositorioProfissionais REPOSITORIO = new RepositorioProfissionais();
    protected int id;
    protected String nome;
    protected int idade;
    protected String tipo;

    protected Profissional(String tipo) { this.tipo = tipo; }
    public int getId() { return id; }
    public void setId(int id) { this.id = id; }
    public String getNome() { return nome; }
    public void setNome(String nome) { this.nome = nome; }
    public int getIdade() { return idade; }
    public void setIdade(int idade) { this.idade = idade; }
    public String getTipo() { return tipo; }
    public void setTipo(String tipo) { this.tipo = tipo; }

    public void incluir() { REPOSITORIO.incluir(this); }
    public void alterar() { REPOSITORIO.alterar(this); }
    public void excluir() {
        Participacao.excluirDoProfissional(id);
        REPOSITORIO.excluir(id);
    }
    public List<Profissional> listar() { return REPOSITORIO.listar(); }
}