package dao;

import model.Gol;
import java.sql.*;
import java.util.ArrayList;
import java.util.List;

public class GolDAO {

    public void inserir(Gol g) {
        String sql = "INSERT INTO Gols (idJogador, idJogo, minuto) VALUES (?, ?, ?)";
        try (Connection con = Conexao.getConnection();
             PreparedStatement pst = con.prepareStatement(sql, Statement.RETURN_GENERATED_KEYS)) {
            pst.setInt(1, g.getIdJogador());
            pst.setInt(2, g.getIdJogo());
            pst.setInt(3, g.getMinuto());
            pst.executeUpdate();
            try (ResultSet rs = pst.getGeneratedKeys()) { if (rs.next()) g.setIdGol(rs.getInt(1)); }
        } catch (SQLException e) { e.printStackTrace(); }
    }

    public void atualizar(Gol g) {
        String sql = "UPDATE Gols SET idJogador=?, idJogo=?, minuto=? WHERE idGol=?";
        try (Connection con = Conexao.getConnection();
             PreparedStatement pst = con.prepareStatement(sql)) {
            pst.setInt(1, g.getIdJogador());
            pst.setInt(2, g.getIdJogo());
            pst.setInt(3, g.getMinuto());
            pst.setInt(4, g.getIdGol());
            pst.executeUpdate();
        } catch (SQLException e) { e.printStackTrace(); }
    }

    public void deletar(int idGol) {
        String sql = "DELETE FROM Gols WHERE idGol=?";
        try (Connection con = Conexao.getConnection();
             PreparedStatement pst = con.prepareStatement(sql)) {
            pst.setInt(1, idGol);
            pst.executeUpdate();
        } catch (SQLException e) { e.printStackTrace(); }
    }

    public Gol buscarPorId(int idGol) {
        String sql = "SELECT * FROM Gols WHERE idGol=?";
        try (Connection con = Conexao.getConnection();
             PreparedStatement pst = con.prepareStatement(sql)) {
            pst.setInt(1, idGol);
            try (ResultSet rs = pst.executeQuery()) {
                if (rs.next()) {
                    return new Gol(rs.getInt("idGol"), rs.getInt("idJogador"), rs.getInt("idJogo"), rs.getInt("minuto"));
                }
            }
        } catch (SQLException e) { e.printStackTrace(); }
        return null;
    }

    public List<Gol> listarTodos() {
        List<Gol> lista = new ArrayList<>();
        String sql = "SELECT * FROM Gols";
        try (Connection con = Conexao.getConnection();
             PreparedStatement pst = con.prepareStatement(sql);
             ResultSet rs = pst.executeQuery()) {
            while (rs.next()) {
                lista.add(new Gol(rs.getInt("idGol"), rs.getInt("idJogador"), rs.getInt("idJogo"), rs.getInt("minuto")));
            }
        } catch (SQLException e) { e.printStackTrace(); }
        return lista;
    }
    
    public int contarGolsPorJogoETime(int idJogo, int idTime) {
        String sql = "SELECT COUNT(*) FROM Gols g INNER JOIN Jogadores j ON g.idJogador = j.idJogador WHERE g.idJogo=? AND j.idTime=?";
        try (Connection con = Conexao.getConnection();
             PreparedStatement pst = con.prepareStatement(sql)) {
            pst.setInt(1, idJogo);
            pst.setInt(2, idTime);
            try (ResultSet rs = pst.executeQuery()) {
                if (rs.next()) return rs.getInt(1);
            }
        } catch (SQLException e) { e.printStackTrace(); }
        return 0;
    }
}
