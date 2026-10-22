package util;

import excecao.ErroDeArquivoException;

/**
 * Guarda o caminho da pasta "dados" (onde ficam os arquivos .json).
 * É preenchido pelo includes/cabecalho.jsp a cada requisição.
 */
public class Caminhos {

    private static String pastaDados;

    public static void iniciar(String caminhoDaPastaDados) {
        pastaDados = caminhoDaPastaDados;
    }

    public static String getPastaDados() {
        if (pastaDados == null) {
            throw new ErroDeArquivoException(
                "Pasta de dados não configurada. Inclua o cabecalho.jsp na página.");
        }
        return pastaDados;
    }
}
