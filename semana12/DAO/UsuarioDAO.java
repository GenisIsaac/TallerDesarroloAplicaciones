/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package DAO;

import DB.DatabaseConnection;
import Modelos.Docente;
import Modelos.EstadoUsuario;
import Modelos.Estudiante;
import Modelos.TipoUsuario;
import Modelos.Usuario;
import Modelos.Usuario.Estado;
import Modelos.Usuario.Tipo;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;
import java.sql.Timestamp;
import java.util.ArrayList;
import java.util.List;
import java.util.Map;
import java.util.logging.Logger;

/**
 *
 * @author WindowsPC
 */
public class UsuarioDAO {
    
    public Usuario obtenerUsuarioPorId(int id) {
        String sql = "SELECT * FROM usuarios WHERE id = ?";
        try (Connection conn = getConnection();
             PreparedStatement stmt = conn.prepareStatement(sql)) {
            stmt.setInt(1, id);
            try (ResultSet rs = stmt.executeQuery()) {
                if (rs.next()) {
                    return mapearUsuario(rs);
                }
            }
        } catch (SQLException e) {
            throw new RuntimeException("Error al obtener usuario por ID: " + e.getMessage(), e);
        }
        return null;
    }
    
    public Usuario obtenerUsuarioPorEmail(String email) {
        String sql = "SELECT * FROM usuarios WHERE email = ?";
        try (Connection conn = getConnection();
             PreparedStatement stmt = conn.prepareStatement(sql)) {
            stmt.setString(1, email);
            try (ResultSet rs = stmt.executeQuery()) {
                if (rs.next()) {
                    return mapearUsuario(rs);
                }
            }
        } catch (SQLException e) {
            throw new RuntimeException("Error al obtener usuario por email: " + e.getMessage(), e);
        }
        return null;
    }
    
    public List<Usuario> obtenerTodosUsuarios() {
        List<Usuario> usuarios = new ArrayList<>();
        String sql = "SELECT * FROM usuarios ORDER BY tipo, apellido, nombre";
        try (Connection conn = getConnection();
             Statement stmt = conn.createStatement();
             ResultSet rs = stmt.executeQuery(sql)) {
            while (rs.next()) {
                usuarios.add(mapearUsuario(rs));
            }
        } catch (SQLException e) {
            throw new RuntimeException("Error al obtener todos los usuarios: " + e.getMessage(), e);
        }
        return usuarios;
    }
    
    public List<Estudiante> obtenerTodosEstudiantes() {
        List<Estudiante> estudiantes = new ArrayList<>();
        String sql = "SELECT u.*, e.codigo_estudiante, e.carrera_id, e.estado_tesis, " +
                    "e.fecha_inicio, e.fecha_estimada_graduacion, c.nombre as carrera_nombre " +
                    "FROM usuarios u " +
                    "INNER JOIN estudiantes e ON u.id = e.id " +
                    "INNER JOIN carreras c ON e.carrera_id = c.id " +
                    "WHERE u.tipo = 'ESTUDIANTE' " +
                    "ORDER BY u.apellido, u.nombre";
        
        try (Connection conn = getConnection();
             PreparedStatement stmt = conn.prepareStatement(sql);
             ResultSet rs = stmt.executeQuery()) {
            while (rs.next()) {
                estudiantes.add(mapearEstudiante(rs));
            }
        } catch (SQLException e) {
            throw new RuntimeException("Error al obtener todos los estudiantes: " + e.getMessage(), e);
        }
        return estudiantes;
    }
    
    public List<Docente> obtenerTodosDocentes() {
        List<Docente> docentes = new ArrayList<>();
        String sql = "SELECT u.*, d.especialidad, d.titulo, d.tesis_asignadas, " +
                    "d.capacidad_maxima, d.carga_trabajo, d.activo " +
                    "FROM usuarios u " +
                    "INNER JOIN docentes d ON u.id = d.id " +
                    "WHERE u.tipo = 'DOCENTE' " +
                    "ORDER BY u.apellido, u.nombre";
        
        try (Connection conn = getConnection();
             PreparedStatement stmt = conn.prepareStatement(sql);
             ResultSet rs = stmt.executeQuery()) {
            while (rs.next()) {
                docentes.add(mapearDocente(rs));
            }
        } catch (SQLException e) {
            throw new RuntimeException("Error al obtener todos los docentes: " + e.getMessage(), e);
        }
        return docentes;
    }
    
    public List<Docente> obtenerDocentesDisponibles() {
        List<Docente> docentes = new ArrayList<>();
        String sql = "SELECT u.*, d.especialidad, d.titulo, d.tesis_asignadas, " +
                    "d.capacidad_maxima, d.carga_trabajo, d.activo " +
                    "FROM usuarios u " +
                    "INNER JOIN docentes d ON u.id = d.id " +
                    "WHERE u.tipo = 'DOCENTE' AND d.activo = TRUE AND d.carga_trabajo < 100 " +
                    "ORDER BY d.carga_trabajo ASC";
        
        try (Connection conn = getConnection();
             PreparedStatement stmt = conn.prepareStatement(sql);
             ResultSet rs = stmt.executeQuery()) {
            while (rs.next()) {
                docentes.add(mapearDocente(rs));
            }
        } catch (SQLException e) {
            throw new RuntimeException("Error al obtener docentes disponibles: " + e.getMessage(), e);
        }
        return docentes;
    }
    
    public int crearUsuario(Usuario usuario) {
        String sql = "INSERT INTO usuarios (nombre, apellido, email, password, tipo, estado, avatar) " +
                    "VALUES (?, ?, ?, ?, ?, ?, ?)";
        
        try (Connection conn = getConnection();
             PreparedStatement stmt = conn.prepareStatement(sql, Statement.RETURN_GENERATED_KEYS)) {
            
            stmt.setString(1, usuario.getNombre());
            stmt.setString(2, usuario.getApellido());
            stmt.setString(3, usuario.getEmail());
            stmt.setString(4, usuario.getPassword());
            stmt.setString(5, usuario.getTipo().toString());
            stmt.setString(6, usuario.getEstado().toString());
            stmt.setString(7, usuario.getAvatar());
            
            int affectedRows = stmt.executeUpdate();
            
            if (affectedRows > 0) {
                try (ResultSet generatedKeys = stmt.getGeneratedKeys()) {
                    if (generatedKeys.next()) {
                        return generatedKeys.getInt(1);
                    }
                }
            }
            return -1;
        } catch (SQLException e) {
            throw new RuntimeException("Error al crear usuario: " + e.getMessage(), e);
        }
    }
    
    public void crearEstudiante(Estudiante estudiante) {
        String sql = "INSERT INTO estudiantes (id, codigo_estudiante, carrera_id, estado_tesis, " +
                    "fecha_inicio, fecha_estimada_graduacion) VALUES (?, ?, ?, ?, ?, ?)";
        
        try (Connection conn = getConnection();
             PreparedStatement stmt = conn.prepareStatement(sql)) {
            
            stmt.setInt(1, estudiante.getId());
            stmt.setString(2, estudiante.getCodigoEstudiante());
            stmt.setInt(3, estudiante.getCarreraId());
            stmt.setString(4, estudiante.getEstadoTesis() != null ? 
                estudiante.getEstadoTesis() : "SIN_ENVIAR");
            
            if (estudiante.getFechaInicio() != null) {
                stmt.setDate(5, new java.sql.Date(estudiante.getFechaInicio().getTime()));
            } else {
                stmt.setDate(5, new java.sql.Date(System.currentTimeMillis()));
            }
            
            if (estudiante.getFechaEstimadaGraduacion() != null) {
                stmt.setDate(6, new java.sql.Date(estudiante.getFechaEstimadaGraduacion().getTime()));
            } else {
                stmt.setNull(6, java.sql.Types.DATE);
            }
            
            stmt.executeUpdate();
        } catch (SQLException e) {
            throw new RuntimeException("Error al crear estudiante: " + e.getMessage(), e);
        }
    }
    
    public void crearDocente(Docente docente) {
        String sql = "INSERT INTO docentes (id, especialidad, titulo, tesis_asignadas, " +
                    "capacidad_maxima, carga_trabajo, activo) VALUES (?, ?, ?, ?, ?, ?, ?)";
        
        try (Connection conn = getConnection();
             PreparedStatement stmt = conn.prepareStatement(sql)) {
            
            stmt.setInt(1, docente.getId());
            stmt.setString(2, docente.getEspecialidad());
            stmt.setString(3, docente.getTitulo());
            stmt.setInt(4, docente.getTesisAsignadas());
            stmt.setInt(5, docente.getCapacidadMaxima());
            stmt.setDouble(6, docente.getCargaTrabajo());
            stmt.setBoolean(7, docente.isActivo());
            
            stmt.executeUpdate();
        } catch (SQLException e) {
            throw new RuntimeException("Error al crear docente: " + e.getMessage(), e);
        }
    }
    
    public boolean actualizarUsuario(Usuario usuario) {
        String sql = "UPDATE usuarios SET nombre = ?, apellido = ?, email = ?, estado = ?, " +
                    "avatar = ? WHERE id = ?";
        
        try (Connection conn = getConnection();
             PreparedStatement stmt = conn.prepareStatement(sql)) {
            
            stmt.setString(1, usuario.getNombre());
            stmt.setString(2, usuario.getApellido());
            stmt.setString(3, usuario.getEmail());
            stmt.setString(4, usuario.getEstado().toString());
            stmt.setString(5, usuario.getAvatar());
            stmt.setInt(6, usuario.getId());
            
            return stmt.executeUpdate() > 0;
        } catch (SQLException e) {
            throw new RuntimeException("Error al actualizar usuario: " + e.getMessage(), e);
        }
    }
    
    public boolean actualizarPassword(int usuarioId, String nuevaPassword) {
        String sql = "UPDATE usuarios SET password = ? WHERE id = ?";
        
        try (Connection conn = getConnection();
             PreparedStatement stmt = conn.prepareStatement(sql)) {
            
            stmt.setString(1, nuevaPassword);
            stmt.setInt(2, usuarioId);
            
            return stmt.executeUpdate() > 0;
        } catch (SQLException e) {
            throw new RuntimeException("Error al actualizar contraseña: " + e.getMessage(), e);
        }
    }
    
    public boolean eliminarUsuario(int id) {
        // Primero eliminar de la tabla específica según el tipo
        String tipoSql = "SELECT tipo FROM usuarios WHERE id = ?";
        String deleteUserSql = "DELETE FROM usuarios WHERE id = ?";
        
        try (Connection conn = getConnection()) {
            conn.setAutoCommit(false);
            
            // Obtener tipo de usuario
            try (PreparedStatement stmt = conn.prepareStatement(tipoSql)) {
                stmt.setInt(1, id);
                try (ResultSet rs = stmt.executeQuery()) {
                    if (rs.next()) {
                        String tipo = rs.getString("tipo");
                        
                        // Eliminar de tabla específica
                        if ("ESTUDIANTE".equals(tipo)) {
                            String deleteEstudianteSql = "DELETE FROM estudiantes WHERE id = ?";
                            try (PreparedStatement stmt2 = conn.prepareStatement(deleteEstudianteSql)) {
                                stmt2.setInt(1, id);
                                stmt2.executeUpdate();
                            }
                        } else if ("DOCENTE".equals(tipo)) {
                            String deleteDocenteSql = "DELETE FROM docentes WHERE id = ?";
                            try (PreparedStatement stmt2 = conn.prepareStatement(deleteDocenteSql)) {
                                stmt2.setInt(1, id);
                                stmt2.executeUpdate();
                            }
                        }
                    }
                }
            }
            
            // Eliminar de usuarios
            try (PreparedStatement stmt = conn.prepareStatement(deleteUserSql)) {
                stmt.setInt(1, id);
                int result = stmt.executeUpdate();
                
                conn.commit();
                return result > 0;
            }
            
        } catch (SQLException e) {
            throw new RuntimeException("Error al eliminar usuario: " + e.getMessage(), e);
        }
    }
    
    public boolean actualizarUltimoAcceso(int usuarioId) {
        String sql = "UPDATE usuarios SET ultimo_acceso = NOW() WHERE id = ?";
        
        try (Connection conn = getConnection();
             PreparedStatement stmt = conn.prepareStatement(sql)) {
            
            stmt.setInt(1, usuarioId);
            return stmt.executeUpdate() > 0;
            
        } catch (SQLException e) {
            throw new RuntimeException("Error al actualizar último acceso: " + e.getMessage(), e);
        }
    }
    
    public int contarEstudiantesActivos() {
        String sql = "SELECT COUNT(*) as total FROM usuarios WHERE tipo = 'ESTUDIANTE' AND estado = 'ACTIVO'";
        
        try (Connection conn = getConnection();
             PreparedStatement stmt = conn.prepareStatement(sql);
             ResultSet rs = stmt.executeQuery()) {
            if (rs.next()) {
                return rs.getInt("total");
            }
        } catch (SQLException e) {
            throw new RuntimeException("Error al contar estudiantes activos: " + e.getMessage(), e);
        }
        return 0;
    }
    
    public int contarDocentesActivos() {
        String sql = "SELECT COUNT(*) as total FROM docentes WHERE activo = TRUE";
        
        try (Connection conn = getConnection();
             PreparedStatement stmt = conn.prepareStatement(sql);
             ResultSet rs = stmt.executeQuery()) {
            if (rs.next()) {
                return rs.getInt("total");
            }
        } catch (SQLException e) {
            throw new RuntimeException("Error al contar docentes activos: " + e.getMessage(), e);
        }
        return 0;
    }
    
    public double obtenerCargaPromedioDocentes() {
        String sql = "SELECT AVG(carga_trabajo) as promedio FROM docentes WHERE activo = TRUE";
        
        try (Connection conn = getConnection();
             PreparedStatement stmt = conn.prepareStatement(sql);
             ResultSet rs = stmt.executeQuery()) {
            if (rs.next()) {
                return rs.getDouble("promedio");
            }
        } catch (SQLException e) {
            throw new RuntimeException("Error al obtener carga promedio de docentes: " + e.getMessage(), e);
        }
        return 0;
    }
    
    private static final Logger logger = Logger.getLogger(UsuarioDAO.class.getName());
    
    // CONEXIÓN SIMPLIFICADA - SIN CAST
    private Connection getConnection() throws SQLException {
        try {
            Connection conn = DatabaseConnection.getConnection();
            if (conn != null && !conn.isClosed()) {
                System.out.println("✅ Conexión obtenida exitosamente");
                return conn;
            } else {
                System.err.println("❌ Conexión nula o cerrada");
                return null;
            }
        } catch (SQLException e) {
            System.err.println("❌ Error al obtener conexión: " + e.getMessage());
            throw e;
        }
    }
    
    // LOGIN SIMPLIFICADO - versión básica que SÍ funciona
    public Usuario login(String email, String password) {
        System.out.println("\n🔐 USUARIODAO.LOGIN - INICIANDO");
        System.out.println("📧 Email: " + email);
        System.out.println("🔐 Password: " + (password != null ? "***" : "NULL"));
        
        if (email == null || password == null || email.trim().isEmpty() || password.trim().isEmpty()) {
            System.out.println("❌ Email o password vacíos");
            return null;
        }
        
        email = email.trim().toLowerCase();
        password = password.trim();
        
        String sql = "SELECT id, nombre, apellido, email, tipo, estado FROM usuarios WHERE email = ? AND password = ?";
        
        Connection conn = null;
        PreparedStatement stmt = null;
        ResultSet rs = null;
        
        try {
            // 1. Obtener conexión
            System.out.println("1. Obteniendo conexión...");
            conn = getConnection();
            
            if (conn == null) {
                System.err.println("❌ La conexión es NULA");
                return null;
            }
            
            if (conn.isClosed()) {
                System.err.println("❌ La conexión está CERRADA");
                return null;
            }
            
            System.out.println("✅ Conexión OK - Base de datos: " + conn.getCatalog());
            
            // 2. Preparar statement
            System.out.println("2. Preparando consulta SQL...");
            System.out.println("   SQL: " + sql);
            System.out.println("   Parámetros: email=" + email + ", password=" + password);
            
            stmt = conn.prepareStatement(sql);
            stmt.setString(1, email);
            stmt.setString(2, password);
            
            // 3. Ejecutar consulta
            System.out.println("3. Ejecutando consulta...");
            rs = stmt.executeQuery();
            
            // 4. Procesar resultado
            if (rs.next()) {
                System.out.println("✅ Usuario ENCONTRADO en la base de datos");
                
                // Crear usuario manualmente (simple)
                Usuario usuario = new Usuario();
                usuario.setId(rs.getInt("id"));
                usuario.setNombre(rs.getString("nombre"));
                usuario.setApellido(rs.getString("apellido"));
                usuario.setEmail(rs.getString("email"));
                
                // Configurar tipo (simplificado)
                String tipoStr = rs.getString("tipo");
                if (tipoStr != null) {
                    if (tipoStr.equalsIgnoreCase("ADMINISTRADOR")) {
                        usuario.setTipo(Usuario.Tipo.ADMINISTRADOR);
                    } else if (tipoStr.equalsIgnoreCase("DOCENTE")) {
                        usuario.setTipo(Usuario.Tipo.DOCENTE);
                    } else if (tipoStr.equalsIgnoreCase("ESTUDIANTE")) {
                        usuario.setTipo(Usuario.Tipo.ESTUDIANTE);
                    }
                }
                
                // Configurar estado (simplificado)
                String estadoStr = rs.getString("estado");
                if (estadoStr != null) {
                    if (estadoStr.equalsIgnoreCase("ACTIVO")) {
                        usuario.setEstado(Usuario.Estado.ACTIVO);
                    } else if (estadoStr.equalsIgnoreCase("INACTIVO")) {
                        usuario.setEstado(Usuario.Estado.INACTIVO);
                    } else if (estadoStr.equalsIgnoreCase("SOBRECARGADO")) {
                        usuario.setEstado(Usuario.Estado.SOBRECARGADO);
                    }
                }
                
                System.out.println("👤 Usuario creado: " + usuario.getNombre() + " " + usuario.getApellido());
                System.out.println("🎭 Tipo: " + usuario.getTipo());
                
                return usuario;
            } else {
                System.out.println("❌ NO se encontró usuario con esas credenciales");
                System.out.println("⚠️ Verifica en MySQL:");
                System.out.println("   SELECT * FROM usuarios WHERE email = '" + email + "' AND password = '" + password + "';");
                return null;
            }
            
        } catch (SQLException e) {
            System.err.println("💥 ERROR SQL en login(): " + e.getMessage());
            System.err.println("   Error Code: " + e.getErrorCode());
            System.err.println("   SQL State: " + e.getSQLState());
            e.printStackTrace();
            return null;
        } catch (Exception e) {
            System.err.println("💥 ERROR GENERAL en login(): " + e.getMessage());
            e.printStackTrace();
            return null;
        } finally {
            // Cerrar recursos
            try {
                if (rs != null) rs.close();
                if (stmt != null) stmt.close();
                if (conn != null) conn.close();
                System.out.println("🔒 Recursos cerrados correctamente");
            } catch (SQLException e) {
                System.err.println("Error al cerrar recursos: " + e.getMessage());
            }
            System.out.println("🏁 FIN DEL MÉTODO LOGIN\n");
        }
    }
    
    // MÉTODO SIMPLE para obtener usuario por email
    public Usuario obtenerPorEmail(String email) {
        System.out.println("\n🔍 OBTENER POR EMAIL: " + email);
        
        String sql = "SELECT id, nombre, apellido, email, tipo, estado FROM usuarios WHERE email = ?";
        
        try (Connection conn = getConnection();
             PreparedStatement stmt = conn.prepareStatement(sql)) {
            
            stmt.setString(1, email);
            ResultSet rs = stmt.executeQuery();
            
            if (rs.next()) {
                // Crear usuario manualmente
                Usuario usuario = new Usuario();
                usuario.setId(rs.getInt("id"));
                usuario.setNombre(rs.getString("nombre"));
                usuario.setApellido(rs.getString("apellido"));
                usuario.setEmail(rs.getString("email"));
                
                String tipoStr = rs.getString("tipo");
                if (tipoStr != null) {
                    if (tipoStr.equalsIgnoreCase("ADMINISTRADOR")) {
                        usuario.setTipo(Usuario.Tipo.ADMINISTRADOR);
                    } else if (tipoStr.equalsIgnoreCase("DOCENTE")) {
                        usuario.setTipo(Usuario.Tipo.DOCENTE);
                    } else if (tipoStr.equalsIgnoreCase("ESTUDIANTE")) {
                        usuario.setTipo(Usuario.Tipo.ESTUDIANTE);
                    }
                }
                
                return usuario;
            }
            
        } catch (SQLException e) {
            System.err.println("Error en obtenerPorEmail: " + e.getMessage());
        }
        
        return null;
    }
    
    // MÉTODO para probar conexión
    public String testDatabase() {
        StringBuilder resultado = new StringBuilder();
        resultado.append("=== PRUEBA DE BASE DE DATOS ===\n\n");
        
        try (Connection conn = getConnection()) {
            if (conn == null) {
                resultado.append("❌ No se pudo establecer conexión\n");
                return resultado.toString();
            }
            
            resultado.append("✅ Conexión exitosa\n\n");
            
            // Probar que podemos ejecutar consultas
            String testQuery = "SELECT 1 as test";
            try (Statement stmt = conn.createStatement(); 
                 ResultSet rs = stmt.executeQuery(testQuery)) {
                if (rs.next()) {
                    resultado.append("✅ Consulta básica funcionando\n\n");
                }
            }
            
            // Verificar si existe la tabla usuarios
            String checkTable = "SHOW TABLES LIKE 'usuarios'";
            try (Statement stmt = conn.createStatement(); 
                 ResultSet rs = stmt.executeQuery(checkTable)) {
                if (rs.next()) {
                    resultado.append("✅ Tabla 'usuarios' existe\n\n");
                } else {
                    resultado.append("❌ Tabla 'usuarios' NO existe\n\n");
                    return resultado.toString();
                }
            }
            
            // Contar usuarios
            String countSql = "SELECT COUNT(*) as total FROM usuarios";
            try (Statement stmt = conn.createStatement(); 
                 ResultSet rs = stmt.executeQuery(countSql)) {
                if (rs.next()) {
                    int total = rs.getInt("total");
                    resultado.append("📊 Total usuarios en BD: ").append(total).append("\n\n");
                    
                    // Si hay usuarios, listarlos
                    if (total > 0) {
                        String selectSql = "SELECT id, nombre, apellido, email, tipo, estado, password FROM usuarios";
                        try (Statement stmt2 = conn.createStatement(); 
                             ResultSet rs2 = stmt2.executeQuery(selectSql)) {
                            resultado.append("👥 LISTA DE USUARIOS:\n");
                            resultado.append("ID | NOMBRE | EMAIL | TIPO | ESTADO | PASSWORD\n");
                            resultado.append("------------------------------------------------\n");
                            
                            while (rs2.next()) {
                                resultado.append(String.format("%2d | %s %s | %s | %s | %s | %s\n",
                                    rs2.getInt("id"),
                                    rs2.getString("nombre"),
                                    rs2.getString("apellido"),
                                    rs2.getString("email"),
                                    rs2.getString("tipo"),
                                    rs2.getString("estado"),
                                    rs2.getString("password")
                                ));
                            }
                        }
                    }
                }
            }
            
        } catch (SQLException e) {
            resultado.append("❌ ERROR: ").append(e.getMessage()).append("\n\n");
            resultado.append("POSIBLES CAUSAS:\n");
            resultado.append("1. MySQL no está corriendo\n");
            resultado.append("2. Base de datos 'thesisreview_portal' no existe\n");
            resultado.append("3. Usuario/contraseña incorrectos en DatabaseConnection\n");
            resultado.append("4. Puerto 3306 bloqueado\n");
        }
        
        return resultado.toString();
    }

    // MÉTODOS AUXILIARES DE MAPEO
    
    private Usuario mapearUsuario(ResultSet rs) throws SQLException {
        Usuario usuario = new Usuario();
        usuario.setId(rs.getInt("id"));
        usuario.setNombre(rs.getString("nombre"));
        usuario.setApellido(rs.getString("apellido"));
        usuario.setEmail(rs.getString("email"));
        usuario.setPassword(rs.getString("password"));
        
        // Manejo seguro de enums
        try {
            usuario.setTipo(Tipo.valueOf(rs.getString("tipo")));
        } catch (IllegalArgumentException e) {
            usuario.setTipo(Tipo.ESTUDIANTE); // Valor por defecto
        }
        
        try {
            usuario.setEstado(Estado.valueOf(rs.getString("estado")));
        } catch (IllegalArgumentException e) {
            usuario.setEstado(Estado.ACTIVO); // Valor por defecto
        }
        
        usuario.setAvatar(rs.getString("avatar"));
        
        // Manejo de fechas
        Timestamp fechaRegistro = rs.getTimestamp("fecha_registro");
        if (fechaRegistro != null) {
            usuario.setFechaRegistro((Timestamp) new java.util.Date(fechaRegistro.getTime()));
        }
        
        Timestamp ultimoAcceso = rs.getTimestamp("ultimo_acceso");
        if (ultimoAcceso != null) {
            usuario.setUltimoAcceso((Timestamp) new java.util.Date(ultimoAcceso.getTime()));
        }
        
        return usuario;
    }
    
    private Estudiante mapearEstudiante(ResultSet rs) throws SQLException {
        Estudiante estudiante = new Estudiante();
        
        // Campos de Usuario
        estudiante.setId(rs.getInt("id"));
        estudiante.setNombre(rs.getString("nombre"));
        estudiante.setApellido(rs.getString("apellido"));
        estudiante.setEmail(rs.getString("email"));
        estudiante.setPassword(rs.getString("password"));
        
        try {
            estudiante.setTipo(Tipo.valueOf(rs.getString("tipo")));
        } catch (IllegalArgumentException e) {
            estudiante.setTipo(Tipo.ESTUDIANTE);
        }
        
        try {
            estudiante.setEstado(Estado.valueOf(rs.getString("estado")));
        } catch (IllegalArgumentException e) {
            estudiante.setEstado(Estado.ACTIVO);
        }
        
        estudiante.setAvatar(rs.getString("avatar"));
        
        Timestamp fechaRegistro = rs.getTimestamp("fecha_registro");
        if (fechaRegistro != null) {
            estudiante.setFechaRegistro((Timestamp) new java.util.Date(fechaRegistro.getTime()));
        }
        
        Timestamp ultimoAcceso = rs.getTimestamp("ultimo_acceso");
        if (ultimoAcceso != null) {
            estudiante.setUltimoAcceso((Timestamp) new java.util.Date(ultimoAcceso.getTime()));
        }
        
        // Campos específicos de Estudiante
        estudiante.setCodigoEstudiante(rs.getString("codigo_estudiante"));
        estudiante.setCarreraId(rs.getInt("carrera_id"));
        estudiante.setCarrera(rs.getString("carrera_nombre"));
        
        String estadoTesis = rs.getString("estado_tesis");
        estudiante.setEstadoTesis(estadoTesis != null ? estadoTesis : "SIN_ENVIAR");
        
        estudiante.setFechaInicio(rs.getDate("fecha_inicio"));
        estudiante.setFechaEstimadaGraduacion(rs.getDate("fecha_estimada_graduacion"));
        
        return estudiante;
    }
    
    private Docente mapearDocente(ResultSet rs) throws SQLException {
        Docente docente = new Docente();
        
        // Campos de Usuario
        docente.setId(rs.getInt("id"));
        docente.setNombre(rs.getString("nombre"));
        docente.setApellido(rs.getString("apellido"));
        docente.setEmail(rs.getString("email"));
        docente.setPassword(rs.getString("password"));
        
        try {
            docente.setTipo(Tipo.valueOf(rs.getString("tipo")));
        } catch (IllegalArgumentException e) {
            docente.setTipo(Tipo.DOCENTE);
        }
        
        try {
            docente.setEstado(Estado.valueOf(rs.getString("estado")));
        } catch (IllegalArgumentException e) {
            docente.setEstado(Estado.ACTIVO);
        }
        
        docente.setAvatar(rs.getString("avatar"));
        
        Timestamp fechaRegistro = rs.getTimestamp("fecha_registro");
        if (fechaRegistro != null) {
            docente.setFechaRegistro((Timestamp) new java.util.Date(fechaRegistro.getTime()));
        }
        
        Timestamp ultimoAcceso = rs.getTimestamp("ultimo_acceso");
        if (ultimoAcceso != null) {
            docente.setUltimoAcceso((Timestamp) new java.util.Date(ultimoAcceso.getTime()));
        }
        
        // Campos específicos de Docente
        docente.setEspecialidad(rs.getString("especialidad"));
        docente.setTitulo(rs.getString("titulo"));
        docente.setTesisAsignadas(rs.getInt("tesis_asignadas"));
        docente.setCapacidadMaxima(rs.getInt("capacidad_maxima"));
        docente.setCargaTrabajo(rs.getDouble("carga_trabajo"));
        docente.setActivo(rs.getBoolean("activo"));
        
        return docente;
    }
    
    // MÉTODOS ADICIONALES ÚTILES
    
    public boolean existeEmail(String email) {
        String sql = "SELECT COUNT(*) as count FROM usuarios WHERE email = ?";
        try (Connection conn = getConnection();
             PreparedStatement stmt = conn.prepareStatement(sql)) {
            stmt.setString(1, email);
            try (ResultSet rs = stmt.executeQuery()) {
                if (rs.next()) {
                    return rs.getInt("count") > 0;
                }
            }
        } catch (SQLException e) {
            throw new RuntimeException("Error al verificar email: " + e.getMessage(), e);
        }
        return false;
    }
    
    public boolean existeCodigoEstudiante(String codigo) {
        String sql = "SELECT COUNT(*) as count FROM estudiantes WHERE codigo_estudiante = ?";
        try (Connection conn = getConnection();
             PreparedStatement stmt = conn.prepareStatement(sql)) {
            stmt.setString(1, codigo);
            try (ResultSet rs = stmt.executeQuery()) {
                if (rs.next()) {
                    return rs.getInt("count") > 0;
                }
            }
        } catch (SQLException e) {
            throw new RuntimeException("Error al verificar código estudiante: " + e.getMessage(), e);
        }
        return false;
    }
    
    public List<Usuario> buscarUsuarios(String criterio) {
        List<Usuario> usuarios = new ArrayList<>();
        String sql = "SELECT * FROM usuarios WHERE " +
                    "nombre LIKE ? OR apellido LIKE ? OR email LIKE ? " +
                    "ORDER BY apellido, nombre";
        
        try (Connection conn = getConnection();
             PreparedStatement stmt = conn.prepareStatement(sql)) {
            
            String likeCriterio = "%" + criterio + "%";
            stmt.setString(1, likeCriterio);
            stmt.setString(2, likeCriterio);
            stmt.setString(3, likeCriterio);
            
            try (ResultSet rs = stmt.executeQuery()) {
                while (rs.next()) {
                    usuarios.add(mapearUsuario(rs));
                }
            }
        } catch (SQLException e) {
            throw new RuntimeException("Error al buscar usuarios: " + e.getMessage(), e);
        }
        return usuarios;
    }
    
    
    public Docente obtenerDocentePorId(int id) {
        String sql = "SELECT u.*, d.especialidad, d.titulo, d.tesis_asignadas, " +
                    "d.capacidad_maxima, d.carga_trabajo, d.activo " +
                    "FROM usuarios u " +
                    "INNER JOIN docentes d ON u.id = d.id " +
                    "WHERE u.id = ? AND u.tipo = 'DOCENTE'";
        
        try (Connection conn = getConnection();
             PreparedStatement stmt = conn.prepareStatement(sql)) {
            stmt.setInt(1, id);
            try (ResultSet rs = stmt.executeQuery()) {
                if (rs.next()) {
                    return mapearDocente(rs);
                }
            }
        } catch (SQLException e) {
            throw new RuntimeException("Error al obtener docente por ID: " + e.getMessage(), e);
        }
        return null;
    }
    
    /**
     * Actualiza la carga de trabajo de un docente
     * 
     * @param docenteId ID del docente
     * @param tesisAsignadas Nuevo número de tesis asignadas
     * @param capacidadMaxima Capacidad máxima del docente
     * @return true si se actualizó correctamente, false en caso contrario
     */
    public boolean actualizarCargaDocente(int docenteId, int tesisAsignadas, int capacidadMaxima) {
        // Calcular carga de trabajo como porcentaje
        double cargaTrabajo = (tesisAsignadas * 100.0) / capacidadMaxima;
        
        String sql = "UPDATE docentes SET tesis_asignadas = ?, " +
                    "carga_trabajo = ? WHERE id = ?";
        
        try (Connection conn = getConnection();
             PreparedStatement stmt = conn.prepareStatement(sql)) {
            
            stmt.setInt(1, tesisAsignadas);
            stmt.setDouble(2, cargaTrabajo);
            stmt.setInt(3, docenteId);
            
            return stmt.executeUpdate() > 0;
        } catch (SQLException e) {
            throw new RuntimeException("Error al actualizar carga del docente: " + e.getMessage(), e);
        }
    }
    
    /**
     * Obtiene un estudiante por su ID con toda su información
     * 
     * @param id ID del estudiante a obtener
     * @return Objeto Estudiante con toda la información o null si no se encuentra
     */
    public Estudiante obtenerEstudiantePorId(int id) {
        String sql = "SELECT u.*, e.codigo_estudiante, e.carrera_id, e.estado_tesis, " +
                    "e.fecha_inicio, e.fecha_estimada_graduacion, c.nombre as carrera_nombre " +
                    "FROM usuarios u " +
                    "INNER JOIN estudiantes e ON u.id = e.id " +
                    "INNER JOIN carreras c ON e.carrera_id = c.id " +
                    "WHERE u.id = ? AND u.tipo = 'ESTUDIANTE'";
        
        try (Connection conn = getConnection();
             PreparedStatement stmt = conn.prepareStatement(sql)) {
            stmt.setInt(1, id);
            try (ResultSet rs = stmt.executeQuery()) {
                if (rs.next()) {
                    return mapearEstudiante(rs);
                }
            }
        } catch (SQLException e) {
            throw new RuntimeException("Error al obtener estudiante por ID: " + e.getMessage(), e);
        }
        return null;
    }
    
    /**
     * Obtiene todos los docentes activos y disponibles
     * 
     * @return Lista de docentes activos
     */
    public List<Docente> obtenerDocentesActivos() {
        List<Docente> docentes = new ArrayList<>();
        String sql = "SELECT u.*, d.especialidad, d.titulo, d.tesis_asignadas, " +
                    "d.capacidad_maxima, d.carga_trabajo, d.activo " +
                    "FROM usuarios u " +
                    "INNER JOIN docentes d ON u.id = d.id " +
                    "WHERE u.tipo = 'DOCENTE' AND u.estado = 'ACTIVO' AND d.activo = TRUE " +
                    "ORDER BY u.apellido, u.nombre";
        
        try (Connection conn = getConnection();
             PreparedStatement stmt = conn.prepareStatement(sql);
             ResultSet rs = stmt.executeQuery()) {
            while (rs.next()) {
                docentes.add(mapearDocente(rs));
            }
        } catch (SQLException e) {
            throw new RuntimeException("Error al obtener docentes activos: " + e.getMessage(), e);
        }
        return docentes;
    }
    
    /**
     * Actualiza el estado de un usuario
     * 
     * @param usuarioId ID del usuario
     * @param estado Nuevo estado del usuario
     * @return true si se actualizó correctamente, false en caso contrario
     */
    public boolean actualizarEstadoUsuario(int usuarioId, String estado) {
        String sql = "UPDATE usuarios SET estado = ? WHERE id = ?";
        
        try (Connection conn = getConnection();
             PreparedStatement stmt = conn.prepareStatement(sql)) {
            
            stmt.setString(1, estado);
            stmt.setInt(2, usuarioId);
            
            return stmt.executeUpdate() > 0;
        } catch (SQLException e) {
            throw new RuntimeException("Error al actualizar estado de usuario: " + e.getMessage(), e);
        }
    }
    
    /**
     * Verifica si un docente tiene disponibilidad para asignar más tesis
     * 
     * @param docenteId ID del docente
     * @return true si tiene disponibilidad, false en caso contrario
     */
    public boolean tieneDisponibilidadDocente(int docenteId) {
        String sql = "SELECT d.tesis_asignadas, d.capacidad_maxima " +
                    "FROM docentes d WHERE d.id = ? AND d.activo = TRUE";
        
        try (Connection conn = getConnection();
             PreparedStatement stmt = conn.prepareStatement(sql)) {
            stmt.setInt(1, docenteId);
            try (ResultSet rs = stmt.executeQuery()) {
                if (rs.next()) {
                    int tesisAsignadas = rs.getInt("tesis_asignadas");
                    int capacidadMaxima = rs.getInt("capacidad_maxima");
                    return tesisAsignadas < capacidadMaxima;
                }
            }
        } catch (SQLException e) {
            throw new RuntimeException("Error al verificar disponibilidad del docente: " + e.getMessage(), e);
        }
        return false;
    }
    
    /**
     * Incrementa el contador de tesis asignadas a un docente
     * 
     * @param docenteId ID del docente
     * @return true si se actualizó correctamente, false en caso contrario
     */
    public boolean incrementarTesisAsignadas(int docenteId) {
        String sql = "UPDATE docentes SET tesis_asignadas = tesis_asignadas + 1, " +
                    "carga_trabajo = (tesis_asignadas + 1) * 100.0 / capacidad_maxima " +
                    "WHERE id = ?";
        
        try (Connection conn = getConnection();
             PreparedStatement stmt = conn.prepareStatement(sql)) {
            
            stmt.setInt(1, docenteId);
            return stmt.executeUpdate() > 0;
        } catch (SQLException e) {
            throw new RuntimeException("Error al incrementar tesis asignadas: " + e.getMessage(), e);
        }
    }
    
    /**
     * Decrementa el contador de tesis asignadas a un docente
     * 
     * @param docenteId ID del docente
     * @return true si se actualizó correctamente, false en caso contrario
     */
    public boolean decrementarTesisAsignadas(int docenteId) {
        String sql = "UPDATE docentes SET tesis_asignadas = GREATEST(tesis_asignadas - 1, 0), " +
                    "carga_trabajo = GREATEST(tesis_asignadas - 1, 0) * 100.0 / capacidad_maxima " +
                    "WHERE id = ?";
        
        try (Connection conn = getConnection();
             PreparedStatement stmt = conn.prepareStatement(sql)) {
            
            stmt.setInt(1, docenteId);
            return stmt.executeUpdate() > 0;
        } catch (SQLException e) {
            throw new RuntimeException("Error al decrementar tesis asignadas: " + e.getMessage(), e);
        }
    }
    
    /**
     * Actualiza el estado de tesis de un estudiante
     * 
     * @param estudianteId ID del estudiante
     * @param estadoTesis Nuevo estado de tesis
     * @return true si se actualizó correctamente, false en caso contrario
     */
    public boolean actualizarEstadoTesisEstudiante(int estudianteId, String estadoTesis) {
        String sql = "UPDATE estudiantes SET estado_tesis = ? WHERE id = ?";
        
        try (Connection conn = getConnection();
             PreparedStatement stmt = conn.prepareStatement(sql)) {
            
            stmt.setString(1, estadoTesis);
            stmt.setInt(2, estudianteId);
            
            return stmt.executeUpdate() > 0;
        } catch (SQLException e) {
            throw new RuntimeException("Error al actualizar estado de tesis del estudiante: " + e.getMessage(), e);
        }
    }
    
    /**
     * Obtiene estadísticas generales del sistema
     * 
     * @return Mapa con las estadísticas del sistema
     */
    public Map<String, Object> obtenerEstadisticasSistema() {
        Map<String, Object> estadisticas = new java.util.HashMap<>();
        
        String[] queries = {
            // Total usuarios
            "SELECT COUNT(*) as total_usuarios FROM usuarios",
            // Estudiantes activos
            "SELECT COUNT(*) as estudiantes_activos FROM usuarios WHERE tipo = 'ESTUDIANTE' AND estado = 'ACTIVO'",
            // Docentes activos
            "SELECT COUNT(*) as docentes_activos FROM docentes WHERE activo = TRUE",
            // Administradores
            "SELECT COUNT(*) as administradores FROM usuarios WHERE tipo = 'ADMINISTRADOR'",
            // Usuarios inactivos
            "SELECT COUNT(*) as usuarios_inactivos FROM usuarios WHERE estado = 'INACTIVO'",
            // Carga promedio de docentes
            "SELECT AVG(carga_trabajo) as carga_promedio FROM docentes WHERE activo = TRUE"
        };
        
        try (Connection conn = getConnection()) {
            for (String query : queries) {
                try (Statement stmt = conn.createStatement();
                     ResultSet rs = stmt.executeQuery(query)) {
                    if (rs.next()) {
                        String key = "";
                        if (query.contains("total_usuarios")) key = "totalUsuarios";
                        else if (query.contains("estudiantes_activos")) key = "estudiantesActivos";
                        else if (query.contains("docentes_activos")) key = "docentesActivos";
                        else if (query.contains("administradores")) key = "administradores";
                        else if (query.contains("usuarios_inactivos")) key = "usuariosInactivos";
                        else if (query.contains("carga_promedio")) key = "cargaPromedio";
                        
                        if (!key.isEmpty()) {
                            estadisticas.put(key, rs.getObject(1));
                        }
                    }
                }
            }
        } catch (SQLException e) {
            throw new RuntimeException("Error al obtener estadísticas del sistema: " + e.getMessage(), e);
        }
        
        return estadisticas;
    }
    
    /**
     * Verifica las credenciales de un usuario (alternativa simplificada a login)
     * 
     * @param email Email del usuario
     * @param password Contraseña del usuario
     * @return true si las credenciales son válidas, false en caso contrario
     */
    public boolean verificarCredenciales(String email, String password) {
        String sql = "SELECT COUNT(*) as count FROM usuarios WHERE email = ? AND password = ?";
        
        try (Connection conn = getConnection();
             PreparedStatement stmt = conn.prepareStatement(sql)) {
            stmt.setString(1, email);
            stmt.setString(2, password);
            
            try (ResultSet rs = stmt.executeQuery()) {
                if (rs.next()) {
                    return rs.getInt("count") > 0;
                }
            }
        } catch (SQLException e) {
            throw new RuntimeException("Error al verificar credenciales: " + e.getMessage(), e);
        }
        return false;
    }
    
    /**
     * Cambia la contraseña de un usuario
     * 
     * @param usuarioId ID del usuario
     * @param nuevaPassword Nueva contraseña
     * @return true si se cambió correctamente, false en caso contrario
     */
    public boolean cambiarPassword(int usuarioId, String nuevaPassword) {
        return actualizarPassword(usuarioId, nuevaPassword);
    }
    
    /**
     * Actualiza el perfil de un usuario
     * 
     * @param usuarioId ID del usuario
     * @param nombre Nuevo nombre
     * @param apellido Nuevo apellido
     * @param email Nuevo email
     * @param avatar Nuevo avatar (puede ser null o vacío)
     * @return true si se actualizó correctamente, false en caso contrario
     */
    public boolean actualizarPerfil(int usuarioId, String nombre, String apellido, String email, String avatar) {
        String sql = "UPDATE usuarios SET nombre = ?, apellido = ?, email = ?, avatar = ? WHERE id = ?";
        
        try (Connection conn = getConnection();
             PreparedStatement stmt = conn.prepareStatement(sql)) {
            
            stmt.setString(1, nombre);
            stmt.setString(2, apellido);
            stmt.setString(3, email);
            stmt.setString(4, avatar);
            stmt.setInt(5, usuarioId);
            
            return stmt.executeUpdate() > 0;
        } catch (SQLException e) {
            throw new RuntimeException("Error al actualizar perfil: " + e.getMessage(), e);
        }
    }
    
    /**
     * Obtiene usuarios por tipo
     * 
     * @param tipo Tipo de usuario (ADMINISTRADOR, DOCENTE, ESTUDIANTE)
     * @return Lista de usuarios del tipo especificado
     */
    public List<Usuario> obtenerUsuariosPorTipo(String tipo) {
        List<Usuario> usuarios = new ArrayList<>();
        String sql = "SELECT * FROM usuarios WHERE tipo = ? ORDER BY apellido, nombre";
        
        try (Connection conn = getConnection();
             PreparedStatement stmt = conn.prepareStatement(sql)) {
            stmt.setString(1, tipo);
            try (ResultSet rs = stmt.executeQuery()) {
                while (rs.next()) {
                    usuarios.add(mapearUsuario(rs));
                }
            }
        } catch (SQLException e) {
            throw new RuntimeException("Error al obtener usuarios por tipo: " + e.getMessage(), e);
        }
        return usuarios;
    }
    
    
    /**
     * Busca docentes por nombre, apellido o especialidad
     * 
     * @param termino Término de búsqueda
     * @return Lista de docentes que coinciden con el término de búsqueda
     */
    public List<Docente> buscarDocentes(String termino) {
        List<Docente> docentes = new ArrayList<>();
        String sql = "SELECT u.*, d.especialidad, d.titulo, d.tesis_asignadas, " +
                    "d.capacidad_maxima, d.carga_trabajo, d.activo " +
                    "FROM usuarios u " +
                    "INNER JOIN docentes d ON u.id = d.id " +
                    "WHERE (u.nombre LIKE ? OR u.apellido LIKE ? OR u.email LIKE ? OR d.especialidad LIKE ?) " +
                    "AND u.tipo = 'DOCENTE' " +
                    "ORDER BY u.apellido, u.nombre";
        
        try (Connection conn = getConnection();
             PreparedStatement stmt = conn.prepareStatement(sql)) {
            
            String terminoBusqueda = "%" + termino + "%";
            stmt.setString(1, terminoBusqueda);
            stmt.setString(2, terminoBusqueda);
            stmt.setString(3, terminoBusqueda);
            stmt.setString(4, terminoBusqueda);
            
            try (ResultSet rs = stmt.executeQuery()) {
                while (rs.next()) {
                    docentes.add(mapearDocente(rs));
                }
            }
        } catch (SQLException e) {
            throw new RuntimeException("Error al buscar docentes: " + e.getMessage(), e);
        }
        return docentes;
    }
    
    /**
     * Busca estudiantes por nombre, apellido o código de estudiante
     * 
     * @param termino Término de búsqueda
     * @return Lista de estudiantes que coinciden con el término de búsqueda
     */
    public List<Estudiante> buscarEstudiantes(String termino) {
        List<Estudiante> estudiantes = new ArrayList<>();
        String sql = "SELECT u.*, e.codigo_estudiante, e.carrera_id, e.estado_tesis, " +
                    "e.fecha_inicio, e.fecha_estimada_graduacion, c.nombre as carrera_nombre " +
                    "FROM usuarios u " +
                    "INNER JOIN estudiantes e ON u.id = e.id " +
                    "INNER JOIN carreras c ON e.carrera_id = c.id " +
                    "WHERE (u.nombre LIKE ? OR u.apellido LIKE ? OR u.email LIKE ? OR e.codigo_estudiante LIKE ?) " +
                    "AND u.tipo = 'ESTUDIANTE' " +
                    "ORDER BY u.apellido, u.nombre";
        
        try (Connection conn = getConnection();
             PreparedStatement stmt = conn.prepareStatement(sql)) {
            
            String terminoBusqueda = "%" + termino + "%";
            stmt.setString(1, terminoBusqueda);
            stmt.setString(2, terminoBusqueda);
            stmt.setString(3, terminoBusqueda);
            stmt.setString(4, terminoBusqueda);
            
            try (ResultSet rs = stmt.executeQuery()) {
                while (rs.next()) {
                    estudiantes.add(mapearEstudiante(rs));
                }
            }
        } catch (SQLException e) {
            throw new RuntimeException("Error al buscar estudiantes: " + e.getMessage(), e);
        }
        return estudiantes;
    }
    
    /**
     * Obtiene el número total de usuarios por tipo
     * 
     * @param tipo Tipo de usuario
     * @return Número de usuarios del tipo especificado
     */
    public int contarUsuariosPorTipo(String tipo) {
        String sql = "SELECT COUNT(*) as total FROM usuarios WHERE tipo = ?";
        
        try (Connection conn = getConnection();
             PreparedStatement stmt = conn.prepareStatement(sql)) {
            stmt.setString(1, tipo);
            try (ResultSet rs = stmt.executeQuery()) {
                if (rs.next()) {
                    return rs.getInt("total");
                }
            }
        } catch (SQLException e) {
            throw new RuntimeException("Error al contar usuarios por tipo: " + e.getMessage(), e);
        }
        return 0;
    }
    
    /**
     * Activa o desactiva un docente
     * 
     * @param docenteId ID del docente
     * @param activo true para activar, false para desactivar
     * @return true si se actualizó correctamente, false en caso contrario
     */
    public boolean activarDesactivarDocente(int docenteId, boolean activo) {
        String sql = "UPDATE docentes SET activo = ? WHERE id = ?";
        
        try (Connection conn = getConnection();
             PreparedStatement stmt = conn.prepareStatement(sql)) {
            
            stmt.setBoolean(1, activo);
            stmt.setInt(2, docenteId);
            
            return stmt.executeUpdate() > 0;
        } catch (SQLException e) {
            throw new RuntimeException("Error al activar/desactivar docente: " + e.getMessage(), e);
        }
    }
    
    // ... (los métodos existentes se mantienen igual, incluyendo mapearUsuario, mapearEstudiante, mapearDocente) ...
}