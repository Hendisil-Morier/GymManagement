package dao;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.SQLException;
import java.util.logging.Level;
import java.util.logging.Logger;

public class DBConnection {

    private static final String DRIVER = "com.microsoft.sqlserver.jdbc.SQLServerDriver";

    private static final String URL =
            "jdbc:sqlserver://localhost:1433;"
            + "databaseName=GymManagement;"
            + "encrypt=true;"
            + "trustServerCertificate=true";

    private static final String USER = "sa";
    private static final String PASSWORD = "minhan18";

    public static Connection getConnection() throws SQLException {
        try {
            Class.forName(DRIVER);
        } catch (ClassNotFoundException ex) {
            Logger.getLogger(DBConnection.class.getName())
                  .log(Level.SEVERE, "Driver not found!", ex);
        }

        return DriverManager.getConnection(URL, USER, PASSWORD);
    }

    public static void main(String[] args) {
        try (Connection con = getConnection()) {
            if (con != null) {
                System.out.println(" Connect to EmployeeManagement SUCCESS");
            }
        } catch (SQLException ex) {
            Logger.getLogger(DBConnection.class.getName())
                  .log(Level.SEVERE, " Connection FAILED", ex);
        }
    }
}