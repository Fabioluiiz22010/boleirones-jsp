package model;

public class Jogo {
    private int idJogo;
    private int idTimeCasa;
    private int idTimeFora;
    private int golsTimeCasa;
    private int golsTimeFora;
    private int pontosTimeCasa;
    private int pontosTimeFora;
    private int idEstadio;
    private String horario; // "HH:MM:SS" format

    public Jogo() {}

    public Jogo(int idJogo, int idTimeCasa, int idTimeFora,
                int golsTimeCasa, int golsTimeFora,
                int pontosTimeCasa, int pontosTimeFora,
                int idEstadio, String horario) {
        this.idJogo = idJogo;
        this.idTimeCasa = idTimeCasa;
        this.idTimeFora = idTimeFora;
        this.golsTimeCasa = golsTimeCasa;
        this.golsTimeFora = golsTimeFora;
        this.pontosTimeCasa = pontosTimeCasa;
        this.pontosTimeFora = pontosTimeFora;
        this.idEstadio = idEstadio;
        this.horario = horario;
    }

    public int getIdJogo() { return idJogo; }
    public void setIdJogo(int idJogo) { this.idJogo = idJogo; }

    public int getIdTimeCasa() { return idTimeCasa; }
    public void setIdTimeCasa(int idTimeCasa) { this.idTimeCasa = idTimeCasa; }

    public int getIdTimeFora() { return idTimeFora; }
    public void setIdTimeFora(int idTimeFora) { this.idTimeFora = idTimeFora; }

    public int getGolsTimeCasa() { return golsTimeCasa; }
    public void setGolsTimeCasa(int golsTimeCasa) { this.golsTimeCasa = golsTimeCasa; }

    public int getGolsTimeFora() { return golsTimeFora; }
    public void setGolsTimeFora(int golsTimeFora) { this.golsTimeFora = golsTimeFora; }

    public int getPontosTimeCasa() { return pontosTimeCasa; }
    public void setPontosTimeCasa(int pontosTimeCasa) { this.pontosTimeCasa = pontosTimeCasa; }

    public int getPontosTimeFora() { return pontosTimeFora; }
    public void setPontosTimeFora(int pontosTimeFora) { this.pontosTimeFora = pontosTimeFora; }

    public int getIdEstadio() { return idEstadio; }
    public void setIdEstadio(int idEstadio) { this.idEstadio = idEstadio; }

    public String getHorario() { return horario; }
    public void setHorario(String horario) { this.horario = horario; }
}
