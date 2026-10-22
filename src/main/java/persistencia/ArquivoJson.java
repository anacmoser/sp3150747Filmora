package persistencia;

import java.io.File;
import java.io.FileInputStream;
import java.io.FileOutputStream;
import java.io.IOException;
import java.io.InputStreamReader;
import java.io.OutputStreamWriter;
import java.io.Reader;
import java.io.Writer;
import java.lang.reflect.Type;
import java.nio.charset.StandardCharsets;
import java.util.ArrayList;
import java.util.List;

import com.google.gson.Gson;
import com.google.gson.GsonBuilder;
import com.google.gson.JsonParseException;

import excecao.ErroDeArquivoException;
import util.Caminhos;

/**
 * Lê e grava uma lista de objetos em um arquivo JSON usando a Gson.
 * Serve para as três entidades (Filme, Profissional, Avaliacao).
 */
public class ArquivoJson<T> {

    private final File arquivo;
    private final Type tipoDaLista;
    private final Gson gson = new GsonBuilder().setPrettyPrinting().create();

    public ArquivoJson(String nomeDoArquivo, Type tipoDaLista) {
        this.arquivo = new File(Caminhos.getPastaDados(), nomeDoArquivo);
        this.tipoDaLista = tipoDaLista;
    }

    /** JSON -> lista de objetos Java. */
    public List<T> ler() {
        if (!arquivo.exists()) {
            return new ArrayList<T>();
        }
        try (Reader leitor = new InputStreamReader(
                new FileInputStream(arquivo), StandardCharsets.UTF_8)) {
            List<T> lista = gson.fromJson(leitor, tipoDaLista);
            return (lista == null) ? new ArrayList<T>() : lista;
        } catch (IOException | JsonParseException e) {
            throw new ErroDeArquivoException(
                "Não foi possível ler " + arquivo.getName() + ": " + e.getMessage(), e);
        }
    }

    /** Lista de objetos Java -> JSON. */
    public void gravar(List<T> lista) {
        try (Writer escritor = new OutputStreamWriter(
                new FileOutputStream(arquivo), StandardCharsets.UTF_8)) {
            gson.toJson(lista, tipoDaLista, escritor);
        } catch (IOException | JsonParseException e) {
            throw new ErroDeArquivoException(
                "Não foi possível gravar " + arquivo.getName() + ": " + e.getMessage(), e);
        }
    }
}
