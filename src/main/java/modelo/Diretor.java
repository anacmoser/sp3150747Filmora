package modelo;

public class Diretor extends Profissional {
    private String estiloDirecao;
    public Diretor() { super("DIRETOR"); }
    public String getEstiloDirecao() { return estiloDirecao; }
    public void setEstiloDirecao(String valor) { estiloDirecao = valor; }
}