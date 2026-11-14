package dao;

import model.Estadio;
import java.sql.*;
import java.util.ArrayList;
import java.util.List;

public class EstadioDAO {

    public void inserir(Estadio e) {
        String sql = "INSERT INTO Estadios (NomeEstadio, Capacidade, Cidade) VALUES (?, ?, ?)";
        try (Connection con = Conexao.getConnection();
             PreparedStatement pst = con.prepareStatement(sql, Statement.RETURN_GENERATED_KEYS)) {
            pst.setString(1, e.getNomeEstadio());
            pst.setInt(2, e.getCapacidade());
            pst.setString(3, e.getCidade());
            pst.executeUpdate();
            try (ResultSet rs = pst.getGeneratedKeys()) { if (rs.next()) e.setIdEstadio(rs.getInt(1)); }
        } catch (SQLException ex) { ex.printStackTrace(); }
    }

    public void atualizar(Estadio e) {
        String sql = "UPDATE Estadios SET NomeEstadio=?, Capacidade=?, Cidade=? WHERE idEstadio=?";
        try (Connection con = Conexao.getConnection();
             PreparedStatement pst = con.prepareStatement(sql)) {
            pst.setString(1, e.getNomeEstadio());
            pst.setInt(2, e.getCapacidade());
            pst.setString(3, e.getCidade());
            pst.setInt(4, e.getIdEstadio());
            pst.executeUpdate();
        } catch (SQLException ex) { ex.printStackTrace(); }
    }

    public void deletar(int id) {
        String sql = "DELETE FROM Estadios WHERE idEstadio=?";
        try (Connection con = Conexao.getConnection();
             PreparedStatement pst = con.prepareStatement(sql)) {
            pst.setInt(1, id); pst.executeUpdate();
        } catch (SQLException ex) { ex.printStackTrace(); }
    }

    public Estadio buscarPorId(int id) {
        String sql = "SELECT * FROM Estadios WHERE idEstadio=?";
        try (Connection con = Conexao.getConnection();
             PreparedStatement pst = con.prepareStatement(sql)) {
            pst.setInt(1, id);
            try (ResultSet rs = pst.executeQuery()) {
                if (rs.next()) {
                    return new Estadio(rs.getInt("idEstadio"), rs.getString("NomeEstadio"), rs.getInt("Capacidade"),
                            rs.getString("Cidade"));
                }
            }
        } catch (SQLException ex) { ex.printStackTrace(); }
        return null;
    }

    public List<Estadio> listarTodos() {
        List<Estadio> lista = new ArrayList<>();
        String sql = "SELECT * FROM Estadios";
        try (Connection con = Conexao.getConnection();
             PreparedStatement pst = con.prepareStatement(sql);
             ResultSet rs = pst.executeQuery()) {
            while (rs.next()) {
                lista.add(new Estadio(rs.getInt("idEstadio"), rs.getString("NomeEstadio"), rs.getInt("Capacidade"),
                        rs.getString("Cidade")));
            }
        } catch (SQLException ex) { ex.printStackTrace(); }
        return lista;
    }
}
