package excecao;

/**
 * Lançada quando algo dá errado ao ler ou gravar um arquivo JSON.
 * A página erro.jsp mostra a mensagem desta exceção ao usuário.
 */
public class ErroDeArquivoException extends RuntimeException {

    private static final long serialVersionUID = 1L;

    public ErroDeArquivoException(String mensagem) {
        super(mensagem);
    }

    public ErroDeArquivoException(String mensagem, Throwable causa) {
        super(mensagem, causa);
    }
}
