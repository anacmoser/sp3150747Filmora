package modelo;

import java.util.List;
import com.google.gson.reflect.TypeToken;
import persistencia.RepositorioJson;

public class Avaliacao implements Identificavel {
    private static final RepositorioJson<Avaliacao> REPOSITORIO =
        new RepositorioJson<Avaliacao>("avaliacoes.json", new TypeToken<List<Avaliacao>>() {}.getType());
    private int id;
    private int filmeId;
    private int nota;
    private String comentario;
    private String data;
    private boolean reassistido;

    public Avaliacao() {}
    public int getId() { return id; }
    public void setId(int id) { this.id = id; }
    public int getFilmeId() { return filmeId; }
    public void setFilmeId(int filmeId) { this.filmeId = filmeId; }
    public int getNota() { return nota; }
    public void setNota(int nota) { this.nota = nota; }
    public String getComentario() { return comentario; }
    public void setComentario(String comentario) { this.comentario = comentario; }
    public String getData() { return data; }
    public void setData(String data) { this.data = data; }
    public boolean isReassistido() { return reassistido; }
    public void setReassistido(boolean reassistido) { this.reassistido = reassistido; }

    public void incluir() { REPOSITORIO.incluir(this); }
    public void alterar() { REPOSITORIO.alterar(this); }
    public void excluir() { REPOSITORIO.excluir(id); }
    public List<Avaliacao> listar() { return REPOSITORIO.listar(); }
    public static void excluirDoFilme(int filmeId) {
        List<Avaliacao> lista = REPOSITORIO.listar();
        if (lista.removeIf(a -> a.getFilmeId() == filmeId)) REPOSITORIO.substituirTodos(lista);
    }
}