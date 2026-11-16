package modelo;

public class Ator extends Profissional {
    private String especialidadeVocal;
    public Ator() { super("ATOR"); }
    public String getEspecialidadeVocal() { return especialidadeVocal; }
    public void setEspecialidadeVocal(String valor) { especialidadeVocal = valor; }
}