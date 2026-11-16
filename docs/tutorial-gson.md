# Tutorial: Gson no Eclipse e no Filmora

Este tutorial explica como a Gson é usada para salvar e ler os arquivos JSON do Filmora. É voltado a quem está começando com bibliotecas Java.

## 1. O que é a Gson?

Uma biblioteca é um conjunto de código pronto que pode ser usado em um programa. Em Java, uma biblioteca costuma ser distribuída em um arquivo `.jar`. A Gson, mantida pelo Google, converte objetos Java em texto JSON e transforma JSON de volta em objetos Java.

No Filmora, ela é usada para ler e gravar `filmes.json`, `profissionais.json`, `participacoes.json` e `avaliacoes.json`. Os dados ficam em arquivos locais; o projeto não usa banco de dados.

## 2. Confira se a Gson já está no projeto

No ZIP do Filmora, o arquivo já está incluído em:

```text
src/main/webapp/WEB-INF/lib/gson-2.14.0.jar
```

No Eclipse, expanda o projeto e confirme que o `.jar` aparece nessa pasta. Se você copiou a pasta manualmente para dentro do Eclipse, selecione o projeto e pressione **F5** para atualizar a visualização.

Se o arquivo estiver ausente, baixe um `.jar` da Gson no [Maven Repository](https://mvnrepository.com/artifact/com.google.code.gson/gson) e coloque-o em `src/main/webapp/WEB-INF/lib/`. Mantenha a pasta `WEB-INF/lib`: adicionar o `.jar` apenas como biblioteca externa do Build Path pode fazer o código compilar, mas deixar o Tomcat sem a biblioteca ao executar.

## 3. Confirme o reconhecimento no Eclipse

1. Abra **Project > Properties > Java Build Path > Libraries** e confira as bibliotecas do projeto.
2. Em um projeto Web, a Gson também deve aparecer em **Java Resources > Libraries > Web App Libraries**.
3. Se o Eclipse ainda marcar os imports como erro, use **Project > Clean...** e atualize o projeto com **F5**.
4. Execute novamente com **Run As > Run on Server**.

## 4. Exemplo básico: objeto Java para JSON e de volta

O exemplo usa os métodos de `Filme` disponíveis no projeto. Ele demonstra a conversão, mas não grava o arquivo de dados do Filmora:

```java
import com.google.gson.Gson;
import modelo.Filme;

public class TesteGson {
    public static void main(String[] args) {
        Gson gson = new Gson();

        Filme filme = new Filme();
        filme.setTitulo("Orgulho e Preconceito");
        filme.setAnoLancamento(2005);
        filme.setGenero("Romance");

        // Objeto Java -> texto JSON
        String json = gson.toJson(filme);
        System.out.println(json);

        // Texto JSON -> objeto Java
        Filme lido = gson.fromJson(json, Filme.class);
        System.out.println(lido.getTitulo());
    }
}
```

Para converter uma lista, o Java precisa conhecer o tipo dos elementos. Por isso o Filmora usa `TypeToken` nos repositórios de filmes, avaliações e participações:

```java
new TypeToken<List<Filme>>() {}.getType()
```

A leitura e a gravação dos arquivos da aplicação já ficam nos repositórios da pasta `src/main/java/persistencia/`; os JSPs não precisam converter o JSON diretamente.

## 5. Como o Filmora representa os relacionamentos

Os arquivos JSON se relacionam por identificadores numéricos:

- `Participacao.filmeId` aponta para um filme.
- `Participacao.profissionalId` aponta para um profissional.
- `Avaliacao.filmeId` aponta para o filme avaliado.

Profissionais são gravados com o campo `tipo`, que informa se o registro representa um `ATOR`, `DIRETOR` ou `ROTEIRISTA`. O repositório de profissionais usa esse campo para reconstruir a subclasse correspondente durante a leitura.

Exemplo de registro de profissional:

```json
{"id":1,"nome":"Keira Knightley","idade":41,"tipo":"ATOR","especialidadeVocal":""}
```

Exemplo de participação e avaliação para o filme de identificador `1`:

```json
{"id":1,"filmeId":1,"profissionalId":1,"funcao":"Atuação","personagem":"Elizabeth Bennet"}
```

```json
{"id":1,"filmeId":1,"nota":5,"comentario":"Gostei muito","data":"2026-09-28","reassistido":true}
```

Os nomes dos campos no JSON devem corresponder aos atributos Java. Ao migrar dados antigos, faça uma cópia de segurança e substitua `tituloFilme` por `filmeId` em avaliações; as participações também precisam ser criadas para registrar direção, elenco e roteiro.

## 6. Erros comuns

| Mensagem ou sintoma | O que conferir |
|---|---|
| `package com.google.gson does not exist` | O `.jar` está em `src/main/webapp/WEB-INF/lib/` e o Eclipse atualizou o projeto? Depois, use **Project > Clean**. |
| `ClassNotFoundException: com.google.gson...` ao executar | Verifique se a Gson está dentro de `WEB-INF/lib` e se o projeto foi executado como aplicação Web no Tomcat. |
| `JsonSyntaxException` ou erro ao ler um JSON | Confira aspas duplas, vírgulas, colchetes e se o arquivo contém JSON válido. Um arquivo vazio deve começar com `[]` para representar uma lista vazia. |
| Campos aparecem como `null` ou `0` | Confira se o nome e o tipo dos campos no JSON correspondem aos atributos Java, por exemplo `anoLancamento`, `filmeId` e `profissionalId`. |
| O cadastro funciona, mas some após reiniciar | Confira se o Tomcat consegue gravar em `src/main/webapp/dados/` e se está lendo a mesma pasta do projeto. |
