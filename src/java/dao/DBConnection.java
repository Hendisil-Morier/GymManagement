package dao;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.SQLException;
import java.util.logging.Level;
import java.util.logging.Logger;
/**
 *
 * @author minht
 */
public class DBConnection {

    private static final String DRIVER = "com.microsoft.sqlserver.jdbc.SQLServerDriver";

    private static final String URL =
            "jdbc:sqlserver://DESKTOP-VHU8RKI\\SQLEXPRESS:1433;"
            + "databaseName=GymManagement;"
            + "encrypt=true;trustServerCertificate=true";

    public static String userDB = "sa";
    public static String passDB ="minhan18";
    
    public static Connection getConnection() {
        Connection con = null;
        try {
            Class.forName(DRIVER);
            con = DriverManager.getConnection(URL,userDB,passDB);
            return con;
        } catch (Exception ex) {
            Logger.getLogger(DBConnection.class.getName()).log(Level.SEVERE, null, ex);
        }
        return null;
    }
    
    public static void main(String[] args) {
        try (Connection con = getConnection()) {
            if (con != null) {
                System.out.println("KET NOI DB THANH CONG");
            }
        } catch (SQLException ex) {
            Logger.getLogger(DBConnection.class.getName()).log(Level.SEVERE, null, ex);
        }
    }
}
