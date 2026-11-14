package dao;

import model.Time;
import java.sql.*;
import java.util.ArrayList;
import java.util.List;

public class TimeDAO {

    public void inserir(Time t) {
        String sql = "INSERT INTO Times (nome, cidade, pontos) VALUES (?, ?, ?)";
        try (Connection con = Conexao.getConnection();
             PreparedStatement pst = con.prepareStatement(sql, Statement.RETURN_GENERATED_KEYS)) {
            pst.setString(1, t.getNome());
            pst.setString(2, t.getCidade());
            pst.setInt(3, t.getPontos());
            pst.executeUpdate();
            try (ResultSet rs = pst.getGeneratedKeys()) {
                if (rs.next()) t.setIdTime(rs.getInt(1));
            }
        } catch (SQLException e) { e.printStackTrace(); }
    }

    public void atualizar(Time t) {
        String sql = "UPDATE Times SET nome=?, cidade=?, pontos=? WHERE idTime=?";
        try (Connection con = Conexao.getConnection();
             PreparedStatement pst = con.prepareStatement(sql)) {
            pst.setString(1, t.getNome());
            pst.setString(2, t.getCidade());
            pst.setInt(3, t.getPontos());
            pst.setInt(4, t.getIdTime());
            pst.executeUpdate();
        } catch (SQLException e) { e.printStackTrace(); }
    }

    public void deletar(int idTime) {
        String sql = "DELETE FROM Times WHERE idTime=?";
        try (Connection con = Conexao.getConnection();
             PreparedStatement pst = con.prepareStatement(sql)) {
            pst.setInt(1, idTime);
            pst.executeUpdate();
        } catch (SQLException e) { e.printStackTrace(); }
    }

    public Time buscarPorId(int idTime) {
        String sql = "SELECT * FROM Times WHERE idTime=?";
        try (Connection con = Conexao.getConnection();
             PreparedStatement pst = con.prepareStatement(sql)) {
            pst.setInt(1, idTime);
            try (ResultSet rs = pst.executeQuery()) {
                if (rs.next()) {
                    return new Time(rs.getInt("idTime"), rs.getString("nome"), rs.getString("cidade"), rs.getInt("pontos"));
                }
            }
        } catch (SQLException e) { e.printStackTrace(); }
        return null;
    }

    public List<Time> listarTodos() {
        List<Time> lista = new ArrayList<>();
        String sql = "SELECT * FROM Times";
        try (Connection con = Conexao.getConnection();
             PreparedStatement pst = con.prepareStatement(sql);
             ResultSet rs = pst.executeQuery()) {
            while (rs.next()) {
                lista.add(new Time(rs.getInt("idTime"), rs.getString("nome"), rs.getString("cidade"), rs.getInt("pontos")));
            }
        } catch (SQLException e) { e.printStackTrace(); }
        return lista;
    }
 
    public void somarPontos(Connection con, int idTime, int delta) throws SQLException {
        String sql = "UPDATE Times SET pontos = pontos + ? WHERE idTime = ?";
        try (PreparedStatement pst = con.prepareStatement(sql)) {
            pst.setInt(1, delta);
            pst.setInt(2, idTime);
            pst.executeUpdate();
        }
    }
}
