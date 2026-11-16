package persistencia;

import java.io.*;
import java.lang.reflect.Type;
import java.nio.charset.StandardCharsets;
import java.util.ArrayList;
import java.util.List;

import com.google.gson.Gson;
import com.google.gson.GsonBuilder;
import com.google.gson.JsonParseException;

import excecao.ErroDeArquivoException;
import modelo.Identificavel;
import util.Caminhos;

public class RepositorioJson<T extends Identificavel> {
    private final String nomeArquivo;
    private final Type tipoLista;
    private final Gson gson = new GsonBuilder().setPrettyPrinting().create();

    public RepositorioJson(String nomeArquivo, Type tipoLista) {
        this.nomeArquivo = nomeArquivo;
        this.tipoLista = tipoLista;
    }

    private File arquivo() {
        return new File(Caminhos.getPastaDados(), nomeArquivo);
    }

    public List<T> listar() {
        File arquivo = arquivo();
        if (!arquivo.exists()) return new ArrayList<T>();
        try (Reader leitor = new InputStreamReader(
                new FileInputStream(arquivo), StandardCharsets.UTF_8)) {
            List<T> lista = gson.fromJson(leitor, tipoLista);
            return lista == null ? new ArrayList<T>() : lista;
        } catch (IOException | JsonParseException e) {
            throw new ErroDeArquivoException("Não foi possível ler " + nomeArquivo, e);
        }
    }

    public void incluir(T registro) {
        List<T> lista = listar();
        int maiorId = 0;
        for (T item : lista) if (item.getId() > maiorId) maiorId = item.getId();
        registro.setId(maiorId + 1);
        lista.add(registro);
        gravar(lista);
    }

    public void alterar(T registro) {
        List<T> lista = listar();
        for (int i = 0; i < lista.size(); i++) {
            if (lista.get(i).getId() == registro.getId()) {
                lista.set(i, registro);
                gravar(lista);
                return;
            }
        }
        throw new IllegalArgumentException("Registro não encontrado.");
    }

    public void excluir(int id) {
        List<T> lista = listar();
        boolean removeu = lista.removeIf(item -> item.getId() == id);
        if (removeu) gravar(lista);
    }

    private void gravar(List<T> lista) {
        File arquivo = arquivo();
        try (Writer escritor = new OutputStreamWriter(
                new FileOutputStream(arquivo), StandardCharsets.UTF_8)) {
            gson.toJson(lista, tipoLista, escritor);
        } catch (IOException | JsonParseException e) {
            throw new ErroDeArquivoException("Não foi possível gravar " + nomeArquivo, e);
        }
    }
    public void substituirTodos(List<T> lista) { gravar(lista); }
}