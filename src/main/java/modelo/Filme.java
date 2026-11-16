package modelo;

import java.util.List;
import com.google.gson.reflect.TypeToken;
import persistencia.RepositorioJson;

public class Filme implements Identificavel {
    private static final RepositorioJson<Filme> REPOSITORIO =
        new RepositorioJson<Filme>("filmes.json", new TypeToken<List<Filme>>() {}.getType());

    private int id;
    private String titulo;
    private int anoLancamento;
    private String genero;

    public Filme() {}
    public int getId() { return id; }
    public void setId(int id) { this.id = id; }
    public String getTitulo() { return titulo; }
    public void setTitulo(String titulo) { this.titulo = titulo; }
    public int getAnoLancamento() { return anoLancamento; }
    public void setAnoLancamento(int anoLancamento) { this.anoLancamento = anoLancamento; }
    public String getGenero() { return genero; }
    public void setGenero(String genero) { this.genero = genero; }

    public void incluir() { REPOSITORIO.incluir(this); }
    public void alterar() { REPOSITORIO.alterar(this); }
    public List<Filme> listar() { return REPOSITORIO.listar(); }
    public void excluir() {
        Avaliacao.excluirDoFilme(id);
        Participacao.excluirDoFilme(id);
        REPOSITORIO.excluir(id);
    }
}