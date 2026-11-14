package dao;

import model.Jogador;
import java.sql.*;
import java.util.ArrayList;
import java.util.List;

public class JogadorDAO {

    public void inserir(Jogador j) {
        String sql = "INSERT INTO Jogadores (nome, posicao, numero, idTime, gols) VALUES (?, ?, ?, ?, ?)";
        try (Connection con = Conexao.getConnection();
             PreparedStatement pst = con.prepareStatement(sql, Statement.RETURN_GENERATED_KEYS)) {
            pst.setString(1, j.getNome());
            pst.setString(2, j.getPosicao());
            pst.setInt(3, j.getNumero());
            if (j.getIdTime() > 0) pst.setInt(4, j.getIdTime()); else pst.setNull(4, Types.INTEGER);
            pst.setInt(5, j.getGols());
            pst.executeUpdate();
            try (ResultSet rs = pst.getGeneratedKeys()) { if (rs.next()) j.setIdJogador(rs.getInt(1)); }
        } catch (SQLException e) { e.printStackTrace(); }
    }

    public void atualizar(Jogador j) {
        String sql = "UPDATE Jogadores SET nome=?, posicao=?, numero=?, idTime=?, gols=? WHERE idJogador=?";
        try (Connection con = Conexao.getConnection();
             PreparedStatement pst = con.prepareStatement(sql)) {
            pst.setString(1, j.getNome());
            pst.setString(2, j.getPosicao());
            pst.setInt(3, j.getNumero());
            if (j.getIdTime() > 0) pst.setInt(4, j.getIdTime()); else pst.setNull(4, Types.INTEGER);
            pst.setInt(5, j.getGols());
            pst.setInt(6, j.getIdJogador());
            pst.executeUpdate();
        } catch (SQLException e) { e.printStackTrace(); }
    }

    public void deletar(int idJogador) {
        String sql = "DELETE FROM Jogadores WHERE idJogador=?";
        try (Connection con = Conexao.getConnection();
             PreparedStatement pst = con.prepareStatement(sql)) {
            pst.setInt(1, idJogador); pst.executeUpdate();
        } catch (SQLException e) { e.printStackTrace(); }
    }

    public Jogador buscarPorId(int idJogador) {
        String sql = "SELECT * FROM Jogadores WHERE idJogador=?";
        try (Connection con = Conexao.getConnection();
             PreparedStatement pst = con.prepareStatement(sql)) {
            pst.setInt(1, idJogador);
            try (ResultSet rs = pst.executeQuery()) {
                if (rs.next()) {
                    return new Jogador(rs.getInt("idJogador"), rs.getString("nome"), rs.getString("posicao"),
                            rs.getInt("numero"), rs.getInt("idTime"), rs.getInt("gols"));
                }
            }
        } catch (SQLException e) { e.printStackTrace(); }
        return null;
    }

    public List<Jogador> listarTodos() {
        List<Jogador> lista = new ArrayList<>();
        String sql = "SELECT * FROM Jogadores";
        try (Connection con = Conexao.getConnection();
             PreparedStatement pst = con.prepareStatement(sql);
             ResultSet rs = pst.executeQuery()) {
            while (rs.next()) {
                lista.add(new Jogador(rs.getInt("idJogador"), rs.getString("nome"), rs.getString("posicao"),
                        rs.getInt("numero"), rs.getInt("idTime"), rs.getInt("gols")));
            }
        } catch (SQLException e) { e.printStackTrace(); }
        return lista;
    }
    
    public List<Jogador> listarPorTime(int idTime) {
        List<Jogador> lista = new ArrayList<>();
        String sql = "SELECT * FROM Jogadores WHERE idTime = ? ORDER BY gols DESC";
        try (Connection con = Conexao.getConnection();
             PreparedStatement pst = con.prepareStatement(sql)) {
            pst.setInt(1, idTime);
            try (ResultSet rs = pst.executeQuery()) {
                while (rs.next()) {
                    lista.add(new Jogador(
                        rs.getInt("idJogador"),
                        rs.getString("nome"),
                        rs.getString("posicao"),
                        rs.getInt("numero"),
                        rs.getInt("idTime"),
                        rs.getInt("gols")
                    ));
                }
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }

       
        System.out.println("Jogadores encontrados para o time ID: " + idTime + " -> " + lista.size() + " jogadores.");
        return lista;
    }

    public void adicionarGol(int idJogador) {
        String sql = "UPDATE Jogadores SET gols = gols + 1 WHERE idJogador = ?";
        try (Connection con = Conexao.getConnection();
             PreparedStatement pst = con.prepareStatement(sql)) {
            pst.setInt(1, idJogador);
            pst.executeUpdate();
        } catch (SQLException e) {
            e.printStackTrace();
        }
    }


 

public List<Jogador> listarArtilheiros() {
 List<Jogador> artilheiros = new ArrayList<>();

 String sql = "SELECT * FROM Jogadores ORDER BY gols DESC LIMIT 10"; 
 
 try (Connection con = Conexao.getConnection();
      PreparedStatement pst = con.prepareStatement(sql);
      ResultSet rs = pst.executeQuery()) {
     
     while (rs.next()) {
         artilheiros.add(new Jogador(
             rs.getInt("idJogador"),
             rs.getString("nome"),
             rs.getString("posicao"),
             rs.getInt("numero"),
             rs.getInt("idTime"),
             rs.getInt("gols")
         ));
     }
 } catch (SQLException e) {
     e.printStackTrace();
 }
 return artilheiros;
}
}