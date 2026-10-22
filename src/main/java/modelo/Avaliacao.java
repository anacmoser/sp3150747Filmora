package modelo;

import java.util.List;

import com.google.gson.reflect.TypeToken;

import persistencia.ArquivoJson;

public class Avaliacao {

    private int id;
    private String tituloFilme;
    private int nota;
    private String comentario;
    // Data no formato "aaaa-mm-dd" (texto), para a Gson ler/gravar sem configuração extra
    private String data;
    private boolean reassistido;

    public Avaliacao() {
    }

    public Avaliacao(String tituloFilme, int nota, String comentario, String data, boolean reassistido) {
        this.tituloFilme = tituloFilme;
        this.nota = nota;
        this.comentario = comentario;
        this.data = data;
        this.reassistido = reassistido;
    }

    private static ArquivoJson<Avaliacao> arquivo() {
        return new ArquivoJson<Avaliacao>("avaliacoes.json", new TypeToken<List<Avaliacao>>() { }.getType());
    }

    /** Gera um novo id, adiciona este registro à lista e grava no JSON. */
    public void incluir() {
        ArquivoJson<Avaliacao> arq = arquivo();
        List<Avaliacao> lista = arq.ler();
        int maiorId = 0;
        for (Avaliacao f : lista) {
            if (f.getId() > maiorId) {
                maiorId = f.getId();
            }
        }
        this.id = maiorId + 1;
        lista.add(this);
        arq.gravar(lista);
    }

    /** Substitui, no JSON, o registro que tem o mesmo id deste objeto. */
    public void alterar() {
        ArquivoJson<Avaliacao> arq = arquivo();
        List<Avaliacao> lista = arq.ler();
        for (int i = 0; i < lista.size(); i++) {
            if (lista.get(i).getId() == this.id) {
                lista.set(i, this);
            }
        }
        arq.gravar(lista);
    }

    /** Remove, do JSON, o registro que tem o mesmo id deste objeto. */
    public void excluir() {
        ArquivoJson<Avaliacao> arq = arquivo();
        List<Avaliacao> lista = arq.ler();
        for (int i = lista.size() - 1; i >= 0; i--) {
            if (lista.get(i).getId() == this.id) {
                lista.remove(i);
            }
        }
        arq.gravar(lista);
    }

    public List<Avaliacao> listar() {
        return arquivo().ler();
    }

    public int getId() { return id; }
    public void setId(int id) { this.id = id; }
    public String getTituloFilme() { return tituloFilme; }
    public void setTituloFilme(String tituloFilme) { this.tituloFilme = tituloFilme; }
    public int getNota() { return nota; }
    public void setNota(int nota) { this.nota = nota; }
    public String getComentario() { return comentario; }
    public void setComentario(String comentario) { this.comentario = comentario; }
    public String getData() { return data; }
    public void setData(String data) { this.data = data; }
    public boolean isReassistido() { return reassistido; }
    public void setReassistido(boolean reassistido) { this.reassistido = reassistido; }
}
