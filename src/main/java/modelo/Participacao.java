package modelo;

import java.util.List;
import com.google.gson.reflect.TypeToken;
import persistencia.RepositorioJson;

public class Participacao implements Identificavel {
    private static final RepositorioJson<Participacao> REPOSITORIO =
        new RepositorioJson<Participacao>("participacoes.json", new TypeToken<List<Participacao>>() {}.getType());
    private int id;
    private int filmeId;
    private int profissionalId;
    private String funcao;
    private String personagem;

    public Participacao() {}
    public int getId() { return id; }
    public void setId(int id) { this.id = id; }
    public int getFilmeId() { return filmeId; }
    public void setFilmeId(int filmeId) { this.filmeId = filmeId; }
    public int getProfissionalId() { return profissionalId; }
    public void setProfissionalId(int profissionalId) { this.profissionalId = profissionalId; }
    public String getFuncao() { return funcao; }
    public void setFuncao(String funcao) { this.funcao = funcao; }
    public String getPersonagem() { return personagem; }
    public void setPersonagem(String personagem) { this.personagem = personagem; }
    public void incluir() { REPOSITORIO.incluir(this); }
    public void excluir() { REPOSITORIO.excluir(id); }
    public List<Participacao> listar() { return REPOSITORIO.listar(); }

    public static void excluirDoFilme(int filmeId) {
        List<Participacao> lista = REPOSITORIO.listar();
        if (lista.removeIf(p -> p.getFilmeId() == filmeId)) REPOSITORIO.substituirTodos(lista);
    }
    public static void excluirDoProfissional(int profissionalId) {
        List<Participacao> lista = REPOSITORIO.listar();
        if (lista.removeIf(p -> p.getProfissionalId() == profissionalId)) REPOSITORIO.substituirTodos(lista);
    }
}