/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package DB;


import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.SQLException;


/**
 *
 * @author WindowsPC
 */
public class DatabaseConnection {
    
    
    
   // CONFIGURACIÓN - AJUSTA ESTOS VALORES
    private static final String URL = "jdbc:mysql://localhost:3306/thesisreview_portal?useSSL=false&serverTimezone=UTC";
    private static final String USER = "root";  // Cambia si es necesario
    private static final String PASSWORD = "root";  // Cambia si tienes contraseña
    
    static {
        try {
            // Cargar driver MySQL 8.0
            Class.forName("com.mysql.cj.jdbc.Driver");
            System.out.println("✅ Driver MySQL cargado correctamente");
        } catch (ClassNotFoundException e) {
            System.err.println("❌ ERROR: No se pudo cargar el driver MySQL");
            e.printStackTrace();
            throw new RuntimeException("Driver MySQL no encontrado", e);
        }
    }
    
    public static Connection getConnection() throws SQLException {
        System.out.println("🔄 Intentando conectar a MySQL...");
        System.out.println("   URL: " + URL);
        System.out.println("   Usuario: " + USER);
        
        try {
            Connection conn = DriverManager.getConnection(URL, USER, PASSWORD);
            System.out.println("✅ Conexión exitosa a MySQL");
            System.out.println("   Base de datos: " + conn.getCatalog());
            System.out.println("   Server: " + conn.getMetaData().getDatabaseProductName() + 
                              " " + conn.getMetaData().getDatabaseProductVersion());
            return conn;
        } catch (SQLException e) {
            System.err.println("❌ ERROR de conexión a MySQL:");
            System.err.println("   Error: " + e.getMessage());
            System.err.println("   Error Code: " + e.getErrorCode());
            System.err.println("   SQL State: " + e.getSQLState());
            throw e;
        }
    }
    
    public static boolean testConnection() {
        try (Connection conn = getConnection()) {
            return conn != null && !conn.isClosed();
        } catch (SQLException e) {
            return false;
        }
    }
}