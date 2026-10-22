package modelo;

import java.util.List;

import com.google.gson.reflect.TypeToken;

import persistencia.ArquivoJson;

public class Filme {

    private int id;
    private String titulo;
    private String diretor;
    private int anoLancamento;
    private String genero;

    public Filme() {
    }

    public Filme(String titulo, String diretor, int anoLancamento, String genero) {
        this.titulo = titulo;
        this.diretor = diretor;
        this.anoLancamento = anoLancamento;
        this.genero = genero;
    }

    private static ArquivoJson<Filme> arquivo() {
        return new ArquivoJson<Filme>("filmes.json", new TypeToken<List<Filme>>() { }.getType());
    }

    /** Gera um novo id, adiciona este filme à lista e grava no JSON. */
    public void incluir() {
        ArquivoJson<Filme> arq = arquivo();
        List<Filme> lista = arq.ler();
        int maiorId = 0;
        for (Filme f : lista) {
            if (f.getId() > maiorId) {
                maiorId = f.getId();
            }
        }
        this.id = maiorId + 1;
        lista.add(this);
        arq.gravar(lista);
    }

    /** Substitui, no JSON, o filme que tem o mesmo id deste objeto. */
    public void alterar() {
        ArquivoJson<Filme> arq = arquivo();
        List<Filme> lista = arq.ler();
        for (int i = 0; i < lista.size(); i++) {
            if (lista.get(i).getId() == this.id) {
                lista.set(i, this);
            }
        }
        arq.gravar(lista);
    }

    /** Remove, do JSON, o filme que tem o mesmo id deste objeto. */
    public void excluir() {
        ArquivoJson<Filme> arq = arquivo();
        List<Filme> lista = arq.ler();
        for (int i = lista.size() - 1; i >= 0; i--) {
            if (lista.get(i).getId() == this.id) {
                lista.remove(i);
            }
        }
        arq.gravar(lista);
    }

    public List<Filme> listar() {
        return arquivo().ler();
    }

    public int getId() { return id; }
    public void setId(int id) { this.id = id; }
    public String getTitulo() { return titulo; }
    public void setTitulo(String titulo) { this.titulo = titulo; }
    public String getDiretor() { return diretor; }
    public void setDiretor(String diretor) { this.diretor = diretor; }
    public int getAnoLancamento() { return anoLancamento; }
    public void setAnoLancamento(int anoLancamento) { this.anoLancamento = anoLancamento; }
    public String getGenero() { return genero; }
    public void setGenero(String genero) { this.genero = genero; }
}
