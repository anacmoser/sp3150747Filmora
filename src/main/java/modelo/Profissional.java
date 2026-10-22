package modelo;

import java.util.List;

import com.google.gson.reflect.TypeToken;

import persistencia.ArquivoJson;

public class Profissional {

    private int id;
    private String nome;
    private String profissao;
    private int idade;

    public Profissional() {
    }

    public Profissional(String nome, String profissao, int idade) {
        this.nome = nome;
        this.profissao = profissao;
        this.idade = idade;
    }

    private static ArquivoJson<Profissional> arquivo() {
        return new ArquivoJson<Profissional>("profissionais.json", new TypeToken<List<Profissional>>() { }.getType());
    }

    /** Gera um novo id, adiciona este registro à lista e grava no JSON. */
    public void incluir() {
        ArquivoJson<Profissional> arq = arquivo();
        List<Profissional> lista = arq.ler();
        int maiorId = 0;
        for (Profissional f : lista) {
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
        ArquivoJson<Profissional> arq = arquivo();
        List<Profissional> lista = arq.ler();
        for (int i = 0; i < lista.size(); i++) {
            if (lista.get(i).getId() == this.id) {
                lista.set(i, this);
            }
        }
        arq.gravar(lista);
    }

    /** Remove, do JSON, o registro que tem o mesmo id deste objeto. */
    public void excluir() {
        ArquivoJson<Profissional> arq = arquivo();
        List<Profissional> lista = arq.ler();
        for (int i = lista.size() - 1; i >= 0; i--) {
            if (lista.get(i).getId() == this.id) {
                lista.remove(i);
            }
        }
        arq.gravar(lista);
    }

    public List<Profissional> listar() {
        return arquivo().ler();
    }

    public int getId() { return id; }
    public void setId(int id) { this.id = id; }
    public String getNome() { return nome; }
    public void setNome(String nome) { this.nome = nome; }
    public String getProfissao() { return profissao; }
    public void setProfissao(String profissao) { this.profissao = profissao; }
    public int getIdade() { return idade; }
    public void setIdade(int idade) { this.idade = idade; }
}
