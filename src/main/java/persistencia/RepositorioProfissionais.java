package persistencia;

import java.io.*;
import java.nio.charset.StandardCharsets;
import java.util.ArrayList;
import java.util.List;

import com.google.gson.*;
import modelo.*;
import util.Caminhos;
import excecao.ErroDeArquivoException;

public class RepositorioProfissionais {
    private final Gson gson = new GsonBuilder().setPrettyPrinting().create();
    private File arquivo() { return new File(Caminhos.getPastaDados(), "profissionais.json"); }

    public List<Profissional> listar() {
        File arquivo = arquivo();
        List<Profissional> lista = new ArrayList<Profissional>();
        if (!arquivo.exists()) return lista;
        try (Reader leitor = new InputStreamReader(new FileInputStream(arquivo), StandardCharsets.UTF_8)) {
            JsonElement raiz = JsonParser.parseReader(leitor);
            if (raiz == null || !raiz.isJsonArray()) return lista;
            for (JsonElement item : raiz.getAsJsonArray()) {
                JsonObject dados = item.getAsJsonObject();
                String tipo = dados.has("tipo") ? dados.get("tipo").getAsString() : tipoAntigo(dados);
                Profissional profissional;
                if ("ATOR".equalsIgnoreCase(tipo)) profissional = gson.fromJson(item, Ator.class);
                else if ("DIRETOR".equalsIgnoreCase(tipo)) profissional = gson.fromJson(item, Diretor.class);
                else profissional = gson.fromJson(item, Roteirista.class);
                profissional.setTipo(tipo.toUpperCase());
                lista.add(profissional);
            }
            return lista;
        } catch (IOException | JsonParseException e) {
            throw new ErroDeArquivoException("Não foi possível ler profissionais.json", e);
        }
    }

    private String tipoAntigo(JsonObject dados) {
        String profissao = dados.has("profissao") ? dados.get("profissao").getAsString().toLowerCase() : "";
        if (profissao.contains("diretor")) return "DIRETOR";
        if (profissao.contains("roteir")) return "ROTEIRISTA";
        return "ATOR";
    }

    public void incluir(Profissional profissional) {
        List<Profissional> lista = listar();
        int maiorId = 0;
        for (Profissional item : lista) if (item.getId() > maiorId) maiorId = item.getId();
        profissional.setId(maiorId + 1);
        lista.add(profissional);
        gravar(lista);
    }

    public void alterar(Profissional profissional) {
        List<Profissional> lista = listar();
        for (int i = 0; i < lista.size(); i++) {
            if (lista.get(i).getId() == profissional.getId()) {
                lista.set(i, profissional);
                gravar(lista);
                return;
            }
        }
        throw new IllegalArgumentException("Profissional não encontrado.");
    }

    public void excluir(int id) {
        List<Profissional> lista = listar();
        if (lista.removeIf(item -> item.getId() == id)) gravar(lista);
    }

    private void gravar(List<Profissional> lista) {
        try (Writer escritor = new OutputStreamWriter(new FileOutputStream(arquivo()), StandardCharsets.UTF_8)) {
            gson.toJson(lista, escritor);
        } catch (IOException e) {
            throw new ErroDeArquivoException("Não foi possível gravar profissionais.json", e);
        }
    }
}