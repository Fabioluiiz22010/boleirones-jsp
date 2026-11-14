package model;

public class Estadio {
    private int idEstadio;
    private String nomeEstadio;
    private int capacidade;
    private String cidade;

    public Estadio() {}

    public Estadio(int idEstadio, String nomeEstadio, int capacidade, String cidade) {
        this.idEstadio = idEstadio;
        this.nomeEstadio = nomeEstadio;
        this.capacidade = capacidade;
        this.cidade = cidade;
    }

    public int getIdEstadio() { return idEstadio; }
    public void setIdEstadio(int idEstadio) { this.idEstadio = idEstadio; }

    public String getNomeEstadio() { return nomeEstadio; }
    public void setNomeEstadio(String nomeEstadio) { this.nomeEstadio = nomeEstadio; }

    public int getCapacidade() { return capacidade; }
    public void setCapacidade(int capacidade) { this.capacidade = capacidade; }

    public String getCidade() { return cidade; }
    public void setCidade(String cidade) { this.cidade = cidade; }
}
