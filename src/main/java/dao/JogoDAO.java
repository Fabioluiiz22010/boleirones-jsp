package dao;

import model.Jogo;
import java.sql.*;
import java.util.ArrayList;
import java.util.List;

public class JogoDAO {

     
    public void inserir(Jogo j) {
        String sql = "INSERT INTO Jogos (idTimeCasa, idTimeFora, golsTimeCasa, golsTimeFora, pontosTimeCasa, pontosTimeFora, idEstadio, horario) VALUES (?, ?, ?, ?, ?, ?, ?, ?)";
        Connection con = null;
        try {
            con = Conexao.getConnection();
            con.setAutoCommit(false);

             
            int pontosCasa = 0, pontosFora = 0;
            if (j.getGolsTimeCasa() > j.getGolsTimeFora()) pontosCasa = 3;
            else if (j.getGolsTimeFora() > j.getGolsTimeCasa()) pontosFora = 3;
            else { pontosCasa = 1; pontosFora = 1; }

            try (PreparedStatement pst = con.prepareStatement(sql, Statement.RETURN_GENERATED_KEYS)) {
                pst.setInt(1, j.getIdTimeCasa());
                pst.setInt(2, j.getIdTimeFora());
                pst.setInt(3, j.getGolsTimeCasa());
                pst.setInt(4, j.getGolsTimeFora());
                pst.setInt(5, pontosCasa);
                pst.setInt(6, pontosFora);
                pst.setInt(7, j.getIdEstadio());
                pst.setString(8, j.getHorario());
                pst.executeUpdate();
                try (ResultSet rs = pst.getGeneratedKeys()) {
                    if (rs.next()) j.setIdJogo(rs.getInt(1));
                }
            }

            
            TimeDAO tdao = new TimeDAO();
            if (pontosCasa != 0) tdao.somarPontos(con, j.getIdTimeCasa(), pontosCasa);
            if (pontosFora != 0) tdao.somarPontos(con, j.getIdTimeFora(), pontosFora);

            con.commit();
        } catch (SQLException e) {
            e.printStackTrace();
            if (con != null) try { con.rollback(); } catch (SQLException ex) { ex.printStackTrace(); }
        } finally {
            if (con != null) try { con.setAutoCommit(true); con.close(); } catch (SQLException e) { e.printStackTrace(); }
        }
    }

 
    public void atualizar(Jogo j) {
        Connection con = null;
        try {
            con = Conexao.getConnection();
            con.setAutoCommit(false);

 
            Jogo antigo = buscarPorId(j.getIdJogo());
            if (antigo == null) {
                inserir(j);
                return;
            }

            //calcular pontos antigos
            int pontosCasaAnt = antigo.getPontosTimeCasa();
            int pontosForaAnt = antigo.getPontosTimeFora();

            TimeDAO tdao = new TimeDAO();
            //subtrai pontos antigos
            if (pontosCasaAnt != 0) tdao.somarPontos(con, antigo.getIdTimeCasa(), -pontosCasaAnt);
            if (pontosForaAnt != 0) tdao.somarPontos(con, antigo.getIdTimeFora(), -pontosForaAnt);

            //calcular novos pontos
            int pontosCasaNovo = 0, pontosForaNovo = 0;
            if (j.getGolsTimeCasa() > j.getGolsTimeFora()) pontosCasaNovo = 3;
            else if (j.getGolsTimeFora() > j.getGolsTimeCasa()) pontosForaNovo = 3;
            else { pontosCasaNovo = 1; pontosForaNovo = 1; }

            //atualizar registro de jogos
            String sql = "UPDATE Jogos SET idTimeCasa=?, idTimeFora=?, golsTimeCasa=?, golsTimeFora=?, pontosTimeCasa=?, pontosTimeFora=?, idEstadio=?, horario=? WHERE idJogo=?";
            try (PreparedStatement pst = con.prepareStatement(sql)) {
                pst.setInt(1, j.getIdTimeCasa());
                pst.setInt(2, j.getIdTimeFora());
                pst.setInt(3, j.getGolsTimeCasa());
                pst.setInt(4, j.getGolsTimeFora());
                pst.setInt(5, pontosCasaNovo);
                pst.setInt(6, pontosForaNovo);
                pst.setInt(7, j.getIdEstadio());
                pst.setString(8, j.getHorario());
                pst.setInt(9, j.getIdJogo());
                pst.executeUpdate();
            }

            //aplicar os pontos
            if (pontosCasaNovo != 0) tdao.somarPontos(con, j.getIdTimeCasa(), pontosCasaNovo);
            if (pontosForaNovo != 0) tdao.somarPontos(con, j.getIdTimeFora(), pontosForaNovo);

            con.commit();
        } catch (SQLException e) {
            e.printStackTrace();
            if (con != null) try { con.rollback(); } catch (SQLException ex) { ex.printStackTrace(); }
        } finally {
            if (con != null) try { con.setAutoCommit(true); con.close(); } catch (SQLException e) { e.printStackTrace(); }
        }
    }

    public Jogo buscarPorId(int id) {
        String sql = "SELECT * FROM Jogos WHERE idJogo=?";
        try (Connection con = Conexao.getConnection();
             PreparedStatement pst = con.prepareStatement(sql)) {
            pst.setInt(1, id);
            try (ResultSet rs = pst.executeQuery()) {
                if (rs.next()) {
                    return new Jogo(
                            rs.getInt("idJogo"),
                            rs.getInt("idTimeCasa"),
                            rs.getInt("idTimeFora"),
                            rs.getInt("golsTimeCasa"),
                            rs.getInt("golsTimeFora"),
                            rs.getInt("pontosTimeCasa"),
                            rs.getInt("pontosTimeFora"),
                            rs.getInt("idEstadio"),
                            rs.getString("horario")
                    );
                }
            }
        } catch (SQLException e) { e.printStackTrace(); }
        return null;
    }

    public List<Jogo> listarTodos() {
        List<Jogo> lista = new ArrayList<>();
        String sql = "SELECT * FROM Jogos";
        try (Connection con = Conexao.getConnection();
             PreparedStatement pst = con.prepareStatement(sql);
             ResultSet rs = pst.executeQuery()) {
            while (rs.next()) {
                lista.add(new Jogo(
                        rs.getInt("idJogo"),
                        rs.getInt("idTimeCasa"),
                        rs.getInt("idTimeFora"),
                        rs.getInt("golsTimeCasa"),
                        rs.getInt("golsTimeFora"),
                        rs.getInt("pontosTimeCasa"),
                        rs.getInt("pontosTimeFora"),
                        rs.getInt("idEstadio"),
                        rs.getString("horario")
                ));
            }
        } catch (SQLException e) { e.printStackTrace(); }
        return lista;
    }

    public void deletar(int idJogo) {
        Jogo antigo = buscarPorId(idJogo);
        if (antigo == null) return;

        Connection con = null;
        try {
            con = Conexao.getConnection();
            con.setAutoCommit(false);

            // subtrai pontos
            TimeDAO tdao = new TimeDAO();
            if (antigo.getPontosTimeCasa() != 0) tdao.somarPontos(con, antigo.getIdTimeCasa(), -antigo.getPontosTimeCasa());
            if (antigo.getPontosTimeFora() != 0) tdao.somarPontos(con, antigo.getIdTimeFora(), -antigo.getPontosTimeFora());

            // deleta gols relacionados 
            String delGols = "DELETE FROM Gols WHERE idJogo=?";
            try (PreparedStatement pst = con.prepareStatement(delGols)) {
                pst.setInt(1, idJogo);
                pst.executeUpdate();
            }

            String sql = "DELETE FROM Jogos WHERE idJogo=?";
            try (PreparedStatement pst2 = con.prepareStatement(sql)) {
                pst2.setInt(1, idJogo);
                pst2.executeUpdate();
            }

            con.commit();
        } catch (SQLException e) {
            e.printStackTrace();
            if (con != null) try { con.rollback(); } catch (SQLException ex) { ex.printStackTrace(); }
        } finally {
            if (con != null) try { con.setAutoCommit(true); con.close(); } catch (SQLException e) { e.printStackTrace(); }
        }
    }
}
