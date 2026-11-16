package modelo;

public class Roteirista extends Profissional {
    private String tipoRoteiro;
    public Roteirista() { super("ROTEIRISTA"); }
    public String getTipoRoteiro() { return tipoRoteiro; }
    public void setTipoRoteiro(String valor) { tipoRoteiro = valor; }
}