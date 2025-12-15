/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package DB;

import java.sql.*;

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
    
    // ============= MÉTODOS PARA PREPAREDSTATEMENT =============
    
    /**
     * Crea un PreparedStatement con la consulta SQL proporcionada
     * @param sql Consulta SQL con parámetros (?)
     * @return PreparedStatement configurado
     * @throws SQLException
     */
    public static PreparedStatement prepareStatement(String sql) throws SQLException {
        Connection conn = getConnection();
        return conn.prepareStatement(sql);
    }
    
    /**
     * Crea un PreparedStatement que puede retornar claves generadas
     * @param sql Consulta SQL con parámetros (?)
     * @param returnGeneratedKeys Indica si debe retornar claves generadas
     * @return PreparedStatement configurado
     * @throws SQLException
     */
    public static PreparedStatement prepareStatement(String sql, boolean returnGeneratedKeys) throws SQLException {
        Connection conn = getConnection();
        if (returnGeneratedKeys) {
            return conn.prepareStatement(sql, Statement.RETURN_GENERATED_KEYS);
        }
        return conn.prepareStatement(sql);
    }
    
    /**
     * Crea un PreparedStatement con tipo de ResultSet específico
     * @param sql Consulta SQL
     * @param resultSetType Tipo de ResultSet (ResultSet.TYPE_FORWARD_ONLY, etc.)
     * @param resultSetConcurrency Concurrencia (ResultSet.CONCUR_READ_ONLY, etc.)
     * @return PreparedStatement configurado
     * @throws SQLException
     */
    public static PreparedStatement prepareStatement(String sql, int resultSetType, int resultSetConcurrency) throws SQLException {
        Connection conn = getConnection();
        return conn.prepareStatement(sql, resultSetType, resultSetConcurrency);
    }
    
    /**
     * Crea un PreparedStatement para operaciones de batch
     * @param sql Consulta SQL para batch
     * @return PreparedStatement configurado para batch
     * @throws SQLException
     */
    public static PreparedStatement prepareBatchStatement(String sql) throws SQLException {
        Connection conn = getConnection();
        PreparedStatement pstmt = conn.prepareStatement(sql);
        conn.setAutoCommit(false); // Desactivar auto-commit para batch
        return pstmt;
    }
    
    /**
     * Cierra los recursos de conexión de manera segura
     * @param conn Conexión a cerrar (puede ser null)
     * @param pstmt PreparedStatement a cerrar (puede ser null)
     * @param rs ResultSet a cerrar (puede ser null)
     */
    public static void closeResources(Connection conn, PreparedStatement pstmt, ResultSet rs) {
        try {
            if (rs != null && !rs.isClosed()) {
                rs.close();
            }
        } catch (SQLException e) {
            System.err.println("Error al cerrar ResultSet: " + e.getMessage());
        }
        
        try {
            if (pstmt != null && !pstmt.isClosed()) {
                pstmt.close();
            }
        } catch (SQLException e) {
            System.err.println("Error al cerrar PreparedStatement: " + e.getMessage());
        }
        
        try {
            if (conn != null && !conn.isClosed()) {
                conn.close();
            }
        } catch (SQLException e) {
            System.err.println("Error al cerrar Connection: " + e.getMessage());
        }
    }
    
    /**
     * Cierra solo el Connection y PreparedStatement
     * @param conn Conexión a cerrar
     * @param pstmt PreparedStatement a cerrar
     */
    public static void closeConnection(Connection conn, PreparedStatement pstmt) {
        closeResources(conn, pstmt, null);
    }
    
    /**
     * Cierra solo el PreparedStatement
     * @param pstmt PreparedStatement a cerrar
     */
    public static void closeStatement(PreparedStatement pstmt) {
        try {
            if (pstmt != null && !pstmt.isClosed()) {
                pstmt.close();
            }
        } catch (SQLException e) {
            System.err.println("Error al cerrar PreparedStatement: " + e.getMessage());
        }
    }
    
    /**
     * Cierra solo el ResultSet
     * @param rs ResultSet a cerrar
     */
    public static void closeResultSet(ResultSet rs) {
        try {
            if (rs != null && !rs.isClosed()) {
                rs.close();
            }
        } catch (SQLException e) {
            System.err.println("Error al cerrar ResultSet: " + e.getMessage());
        }
    }
    
    // ============= MÉTODOS DE EJEMPLO DE USO =============
    
    /**
     * Ejemplo de cómo usar prepareStatement para INSERT
     * @param nombre Nombre del usuario
     * @param email Email del usuario
     * @param tipo Tipo de usuario
     * @return ID generado o -1 si hubo error
     */
    public static int insertUsuario(String nombre, String email, String tipo) {
        Connection conn = null;
        PreparedStatement pstmt = null;
        ResultSet rs = null;
        
        try {
            // Usar prepareStatement con returnGeneratedKeys
            conn = getConnection();
            pstmt = conn.prepareStatement(
                "INSERT INTO usuarios (nombre, email, tipo, estado) VALUES (?, ?, ?, 'ACTIVO')",
                Statement.RETURN_GENERATED_KEYS
            );
            
            // Establecer parámetros
            pstmt.setString(1, nombre);
            pstmt.setString(2, email);
            pstmt.setString(3, tipo);
            
            // Ejecutar
            int rows = pstmt.executeUpdate();
            
            if (rows > 0) {
                // Obtener ID generado
                rs = pstmt.getGeneratedKeys();
                if (rs.next()) {
                    return rs.getInt(1);
                }
            }
            return -1;
            
        } catch (SQLException e) {
            System.err.println("Error al insertar usuario: " + e.getMessage());
            return -1;
        } finally {
            closeResources(conn, pstmt, rs);
        }
    }
    
    /**
     * Ejemplo de cómo usar prepareStatement para SELECT
     * @param usuarioId ID del usuario
     * @return Map con los datos del usuario o null si no existe
     */
    public static java.util.Map<String, Object> getUsuarioById(int usuarioId) {
        Connection conn = null;
        PreparedStatement pstmt = null;
        ResultSet rs = null;
        
        try {
            // Usar prepareStatement
            conn = getConnection();
            pstmt = conn.prepareStatement(
                "SELECT * FROM usuarios WHERE id = ?"
            );
            
            // Establecer parámetro
            pstmt.setInt(1, usuarioId);
            
            // Ejecutar
            rs = pstmt.executeQuery();
            
            if (rs.next()) {
                // Convertir ResultSet a Map
                java.util.Map<String, Object> usuario = new java.util.HashMap<>();
                ResultSetMetaData metaData = rs.getMetaData();
                int columnCount = metaData.getColumnCount();
                
                for (int i = 1; i <= columnCount; i++) {
                    String columnName = metaData.getColumnName(i);
                    Object value = rs.getObject(i);
                    usuario.put(columnName, value);
                }
                return usuario;
            }
            return null;
            
        } catch (SQLException e) {
            System.err.println("Error al obtener usuario: " + e.getMessage());
            return null;
        } finally {
            closeResources(conn, pstmt, rs);
        }
    }
    
    /**
     * Ejemplo de cómo usar prepareStatement para UPDATE
     * @param usuarioId ID del usuario
     * @param nuevoEstado Nuevo estado del usuario
     * @return true si se actualizó correctamente
     */
    public static boolean updateUsuarioEstado(int usuarioId, String nuevoEstado) {
        Connection conn = null;
        PreparedStatement pstmt = null;
        
        try {
            // Usar prepareStatement
            conn = getConnection();
            pstmt = conn.prepareStatement(
                "UPDATE usuarios SET estado = ? WHERE id = ?"
            );
            
            // Establecer parámetros
            pstmt.setString(1, nuevoEstado);
            pstmt.setInt(2, usuarioId);
            
            // Ejecutar
            int rows = pstmt.executeUpdate();
            return rows > 0;
            
        } catch (SQLException e) {
            System.err.println("Error al actualizar usuario: " + e.getMessage());
            return false;
        } finally {
            closeConnection(conn, pstmt);
        }
    }
    
    /**
     * Ejemplo de cómo usar prepareStatement para DELETE
     * @param usuarioId ID del usuario a eliminar
     * @return true si se eliminó correctamente
     */
    public static boolean deleteUsuario(int usuarioId) {
        Connection conn = null;
        PreparedStatement pstmt = null;
        
        try {
            // Usar prepareStatement
            conn = getConnection();
            pstmt = conn.prepareStatement(
                "DELETE FROM usuarios WHERE id = ?"
            );
            
            // Establecer parámetro
            pstmt.setInt(1, usuarioId);
            
            // Ejecutar
            int rows = pstmt.executeUpdate();
            return rows > 0;
            
        } catch (SQLException e) {
            System.err.println("Error al eliminar usuario: " + e.getMessage());
            return false;
        } finally {
            closeConnection(conn, pstmt);
        }
    }
    
    /**
     * Ejemplo de cómo usar prepareStatement para SELECT con múltiples resultados
     * @param tipo Tipo de usuario a buscar
     * @return Lista de usuarios
     */
    public static java.util.List<java.util.Map<String, Object>> getUsuariosByTipo(String tipo) {
        Connection conn = null;
        PreparedStatement pstmt = null;
        ResultSet rs = null;
        java.util.List<java.util.Map<String, Object>> usuarios = new java.util.ArrayList<>();
        
        try {
            // Usar prepareStatement
            conn = getConnection();
            pstmt = conn.prepareStatement(
                "SELECT * FROM usuarios WHERE tipo = ? ORDER BY nombre"
            );
            
            // Establecer parámetro
            pstmt.setString(1, tipo);
            
            // Ejecutar
            rs = pstmt.executeQuery();
            
            // Procesar resultados
            while (rs.next()) {
                java.util.Map<String, Object> usuario = new java.util.HashMap<>();
                ResultSetMetaData metaData = rs.getMetaData();
                int columnCount = metaData.getColumnCount();
                
                for (int i = 1; i <= columnCount; i++) {
                    String columnName = metaData.getColumnName(i);
                    Object value = rs.getObject(i);
                    usuario.put(columnName, value);
                }
                usuarios.add(usuario);
            }
            
            return usuarios;
            
        } catch (SQLException e) {
            System.err.println("Error al obtener usuarios: " + e.getMessage());
            return usuarios;
        } finally {
            closeResources(conn, pstmt, rs);
        }
    }
    
    /**
     * Ejemplo de cómo usar prepareStatement para operaciones en lote (batch)
     * @param usuarios Lista de usuarios a insertar
     * @return Array con resultados de cada operación
     */
    public static int[] insertUsuariosBatch(java.util.List<java.util.Map<String, Object>> usuarios) {
        Connection conn = null;
        PreparedStatement pstmt = null;
        
        try {
            // Usar prepareBatchStatement
            conn = getConnection();
            pstmt = conn.prepareStatement(
                "INSERT INTO usuarios (nombre, email, tipo, estado) VALUES (?, ?, ?, 'ACTIVO')"
            );
            
            // Configurar cada usuario y agregar al batch
            for (java.util.Map<String, Object> usuario : usuarios) {
                pstmt.setString(1, (String) usuario.get("nombre"));
                pstmt.setString(2, (String) usuario.get("email"));
                pstmt.setString(3, (String) usuario.get("tipo"));
                pstmt.addBatch();
            }
            
            // Ejecutar batch
            int[] results = pstmt.executeBatch();
            
            // Confirmar transacción
            conn.commit();
            
            return results;
            
        } catch (SQLException e) {
            try {
                if (conn != null) {
                    conn.rollback(); // Revertir cambios en caso de error
                }
            } catch (SQLException ex) {
                System.err.println("Error al hacer rollback: " + ex.getMessage());
            }
            System.err.println("Error en batch: " + e.getMessage());
            return new int[0];
        } finally {
            closeConnection(conn, pstmt);
        }
    }
}