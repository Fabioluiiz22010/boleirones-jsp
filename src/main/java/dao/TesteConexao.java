package dao;

import java.sql.Connection;
import java.sql.SQLException;

public class TesteConexao {
    public static void main(String[] args) {
        try {
            Connection con = Conexao.getConnection();
            System.out.println("Conexão bem-sucedida!");
            con.close();
        } catch (SQLException e) {
            e.printStackTrace();
        }
    }
}
