package model;

public class Gol {
    private int idGol;
    private int idJogador;
    private int idJogo;
    private int minuto;

    public Gol() {}

    public Gol(int idGol, int idJogador, int idJogo, int minuto) {
        this.idGol = idGol;
        this.idJogador = idJogador;
        this.idJogo = idJogo;
        this.minuto = minuto;
    }

    public int getIdGol() { return idGol; }
    public void setIdGol(int idGol) { this.idGol = idGol; }

    public int getIdJogador() { return idJogador; }
    public void setIdJogador(int idJogador) { this.idJogador = idJogador; }

    public int getIdJogo() { return idJogo; }
    public void setIdJogo(int idJogo) { this.idJogo = idJogo; }

    public int getMinuto() { return minuto; }
    public void setMinuto(int minuto) { this.minuto = minuto; }
}
