package model;

public class Jogador {
    private int idJogador;
    private String nome;
    private String posicao;
    private int numero;
    private int idTime;
    private int gols;

    
    public Jogador() {}
    public Jogador(int idJogador, String nome, String posicao, int numero, int idTime, int gols) {
        this.idJogador = idJogador;
        this.nome = nome;
        this.posicao = posicao;
        this.numero = numero;
        this.idTime = idTime;
        this.gols = gols;
    }

    public int getIdJogador() { return idJogador; }
    public void setIdJogador(int idJogador) { this.idJogador = idJogador; }

    public String getNome() { return nome; }
    public void setNome(String nome) { this.nome = nome; }

    public String getPosicao() { return posicao; }
    public void setPosicao(String posicao) { this.posicao = posicao; }

    public int getNumero() { return numero; }
    public void setNumero(int numero) { this.numero = numero; }

    public int getIdTime() { return idTime; }
    public void setIdTime(int idTime) { this.idTime = idTime; }

    public int getGols() { return gols; }
    public void setGols(int gols) { this.gols = gols; }
}
