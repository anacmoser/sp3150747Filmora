# Tutorial: configurando a Gson no Eclipse (para quem nunca usou biblioteca em Java)

## 1. O que é uma biblioteca?
Uma biblioteca é código pronto, escrito por outras pessoas, que você reaproveita.
Em Java ela vem num arquivo `.jar`. A **Gson** (do Google) converte
objetos Java em JSON e JSON em objetos Java. É ela que vai ler e gravar seus arquivos
`filmes.json`, `profissionais.json` e `avaliacoes.json`.

## 2. Baixar o .jar
1. Acesse https://mvnrepository.com/artifact/com.google.code.gson/gson
2. Clique na versão mais recente (2.14.0 na data deste material; a 2.13.2 também serve).
3. Na linha **Files**, clique em **jar** e salve o arquivo (ex.: `gson-2.14.0.jar`).

## 3. Colocar o .jar no projeto
1. No Eclipse, abra o projeto `Filmora` > `WebContent` > `WEB-INF` > `lib`.
2. Copie o `.jar` para dentro dessa pasta (arrastar para o Eclipse ou colar pelo explorador
   de arquivos e apertar **F5** no projeto).
3. Confira: **Java Resources > Libraries > Web App Libraries** deve listar o `gson-2.14.0.jar`.

> Por que `WEB-INF/lib`? Porque o Tomcat só enxerga bibliotecas dessa pasta. Se você adicionar
> o jar apenas em *Build Path > Add External JARs*, o código compila, mas na hora de rodar dá
> `ClassNotFoundException`.

## 4. Testar (opcional, 2 minutos)
Crie a classe `Teste.java` em `src` (pacote `util`) e rode com **Run As > Java Application**:

```java
package util;

import java.util.List;
import com.google.gson.Gson;
import com.google.gson.reflect.TypeToken;
import modelo.Filme;

public class Teste {
    public static void main(String[] args) {
        Gson gson = new Gson();

        // Objeto Java -> JSON
        Filme f = new Filme("Orgulho e Preconceito", "Joe Wright", 2005, "romance");
        String json = gson.toJson(f);
        System.out.println(json);

        // JSON -> objeto Java
        Filme lido = gson.fromJson(json, Filme.class);
        System.out.println(lido.getTitulo());

        // JSON (lista) -> List<Filme>: precisa do TypeToken
        String jsonLista = "[{\"id\":1,\"titulo\":\"Orgulho e Preconceito\"}]";
        List<Filme> lista = gson.fromJson(jsonLista, new TypeToken<List<Filme>>() { }.getType());
        System.out.println(lista.size());
    }
}
```

Saída esperada: o JSON do filme, o título e o número `1`.
(Este teste não usa os arquivos da pasta `dados`; ele só prova que a Gson está funcionando.
Apague a classe depois, se quiser.)

## 5. As 3 funções que você vai usar
| O que fazer | Código |
|---|---|
| Objeto -> JSON (texto) | `gson.toJson(objeto)` |
| JSON -> objeto | `gson.fromJson(json, Filme.class)` |
| JSON -> lista | `gson.fromJson(json, new TypeToken<List<Filme>>() { }.getType())` |

No projeto, tudo isso já está dentro de `persistencia/ArquivoJson.java`.

## 6. Erros comuns
| Mensagem | Causa provável |
|---|---|
| `package com.google.gson does not exist` | jar não está em `WEB-INF/lib` (refaça o passo 3, depois **Project > Clean**) |
| `ClassNotFoundException: com.google.gson...` | jar só foi adicionado ao Build Path; copie para `WEB-INF/lib` |
| `JsonSyntaxException` / `Não foi possível ler ...json` | JSON inválido: confira aspas retas `"` (não `“ ”`), vírgulas e colchetes |
| Erro de nome de campo (valor `0` ou `null`) | o nome no JSON precisa ser igual ao do atributo Java (`anoLancamento`, `tituloFilme`...) |
