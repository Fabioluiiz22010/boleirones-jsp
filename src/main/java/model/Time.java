package model;

public class Time {
    private int idTime;
    private String nome;
    private String cidade;
    private int pontos;

    public Time() {}

    public Time(int idTime, String nome, String cidade, int pontos) {
        this.idTime = idTime;
        this.nome = nome;
        this.cidade = cidade;
        this.pontos = pontos;
    }

    public int getIdTime() { return idTime; }
    public void setIdTime(int idTime) { this.idTime = idTime; }

    public String getNome() { return nome; }
    public void setNome(String nome) { this.nome = nome; }

    public String getCidade() { return cidade; }
    public void setCidade(String cidade) { this.cidade = cidade; }

    public int getPontos() { return pontos; }
    public void setPontos(int pontos) { this.pontos = pontos; }
}
