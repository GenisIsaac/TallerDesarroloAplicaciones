package DAO;

import DB.DatabaseConnection;
import Modelos.Asignacion;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;
import java.sql.Timestamp;
import java.util.ArrayList;
import java.util.List;

/**
 *
 * @author WindowsPC
 */
public class AsignacionDAO {
    
    public List<Asignacion> obtenerTodasAsignaciones() {
        List<Asignacion> asignaciones = new ArrayList<>();
        String sql = "SELECT a.*, " +
                    "t.titulo as tesis_titulo, " +
                    "CONCAT(u.nombre, ' ', u.apellido) as docente_nombre_completo, " +
                    "CONCAT(ue.nombre, ' ', ue.apellido) as estudiante_nombre_completo " +
                    "FROM asignaciones a " +
                    "JOIN tesis t ON a.id_tesis = t.id " +
                    "JOIN docentes d ON a.id_docente = d.id " +
                    "JOIN usuarios u ON d.id = u.id " +
                    "LEFT JOIN estudiantes e ON t.id_estudiante = e.id " +
                    "LEFT JOIN usuarios ue ON e.id = ue.id " +
                    "ORDER BY a.fecha_asignacion DESC";
        
        try (Connection conn = DatabaseConnection.getConnection();
             PreparedStatement stmt = conn.prepareStatement(sql);
             ResultSet rs = stmt.executeQuery()) {
            while (rs.next()) {
                asignaciones.add(mapearAsignacion(rs));
            }
        } catch (SQLException e) {
            throw new RuntimeException("Error al obtener todas las asignaciones: " + e.getMessage(), e);
        }
        return asignaciones;
    }
    
    public Asignacion obtenerAsignacionPorId(int id) {
        String sql = "SELECT a.*, " +
                    "t.titulo as tesis_titulo, " +
                    "CONCAT(u.nombre, ' ', u.apellido) as docente_nombre_completo, " +
                    "CONCAT(ue.nombre, ' ', ue.apellido) as estudiante_nombre_completo " +
                    "FROM asignaciones a " +
                    "JOIN tesis t ON a.id_tesis = t.id " +
                    "JOIN docentes d ON a.id_docente = d.id " +
                    "JOIN usuarios u ON d.id = u.id " +
                    "LEFT JOIN estudiantes e ON t.id_estudiante = e.id " +
                    "LEFT JOIN usuarios ue ON e.id = ue.id " +
                    "WHERE a.id = ?";
        
        try (Connection conn = DatabaseConnection.getConnection();
             PreparedStatement stmt = conn.prepareStatement(sql)) {
            stmt.setInt(1, id);
            try (ResultSet rs = stmt.executeQuery()) {
                if (rs.next()) {
                    return mapearAsignacion(rs);
                }
            }
        } catch (SQLException e) {
            throw new RuntimeException("Error al obtener asignación por ID: " + e.getMessage(), e);
        }
        return null;
    }
    
public List<Asignacion> obtenerAsignacionesPorDocente(int docenteId) {
    List<Asignacion> asignaciones = new ArrayList<>();
    
    // Consulta simplificada que no requiere joins complejos
    String sql = "SELECT a.*, t.titulo as tesis_titulo " +
                "FROM asignaciones a " +
                "LEFT JOIN tesis t ON a.id_tesis = t.id " +
                "WHERE a.id_docente = ? " +
                "ORDER BY a.fecha_limite ASC";
    
    System.out.println("DEBUG: Ejecutando consulta para docente ID: " + docenteId);
    System.out.println("DEBUG: SQL: " + sql);
    
    try (Connection conn = DatabaseConnection.getConnection();
         PreparedStatement stmt = conn.prepareStatement(sql)) {
        
        stmt.setInt(1, docenteId);
        try (ResultSet rs = stmt.executeQuery()) {
            int count = 0;
            while (rs.next()) {
                count++;
                Asignacion asignacion = mapearAsignacionSimple(rs);
                asignaciones.add(asignacion);
            }
            System.out.println("DEBUG: Se encontraron " + count + " registros");
        }
    } catch (SQLException e) {
        System.err.println("ERROR SQL en obtenerAsignacionesPorDocente: " + e.getMessage());
        System.err.println("SQL State: " + e.getSQLState());
        System.err.println("Error Code: " + e.getErrorCode());
        e.printStackTrace();
        throw new RuntimeException("Error al obtener asignaciones por docente: " + e.getMessage(), e);
    }
    return asignaciones;
}

public List<Asignacion> obtenerAsignacionesPorEstudiante(int estudianteId) {
    List<Asignacion> asignaciones = new ArrayList<>();
    String sql = "SELECT a.*, t.titulo as tesis_titulo, " +
                 "d.nombre || ' ' || d.apellido as docente_nombre, " +
                 "d.email as docente_email " +
                 "FROM asignacion a " +
                 "JOIN tesis t ON a.id_tesis = t.id " +
                 "JOIN usuario d ON a.id_docente = d.id " +
                 "WHERE a.id_estudiante = ? " +
                 "ORDER BY a.fecha_asignacion DESC";
    
    try (Connection conn = DatabaseConnection.getConnection();
         PreparedStatement pstmt = conn.prepareStatement(sql)) {
        
        pstmt.setInt(1, estudianteId);
        ResultSet rs = pstmt.executeQuery();
        
        while (rs.next()) {
            Asignacion asignacion = new Asignacion();
            asignacion.setId(rs.getInt("id"));
            asignacion.setIdTesis(rs.getInt("id_tesis"));
            asignacion.setIdDocente(rs.getInt("id_docente"));
            asignacion.setIdEstudiante(rs.getInt("id_estudiante"));
            asignacion.setTesisTitulo(rs.getString("tesis_titulo"));
            asignacion.setNombreDocente(rs.getString("docente_nombre"));
            asignacion.setDocenteEmail(rs.getString("docente_email"));
            asignacion.setFechaAsignacion(rs.getDate("fecha_asignacion"));
            asignacion.setFechaLimite(rs.getDate("fecha_limite"));
            asignacion.setEstado(rs.getString("estado"));
            asignacion.setRol(rs.getString("rol"));
            asignacion.setObservaciones(rs.getString("observaciones"));
            asignacion.setFeedback(rs.getString("feedback"));
            asignacion.setCalificacion(rs.getBigDecimal("calificacion"));
            asignaciones.add(asignacion);
        }
    } catch (SQLException e) {
        e.printStackTrace();
    }
    return asignaciones;
}

private Asignacion mapearAsignacionSimple(ResultSet rs) throws SQLException {
    Asignacion asignacion = new Asignacion();
    
    // Campos básicos
    asignacion.setId(rs.getInt("id"));
    asignacion.setIdTesis(rs.getInt("id_tesis"));
    asignacion.setIdDocente(rs.getInt("id_docente"));
    asignacion.setRol(rs.getString("rol"));
    asignacion.setEstado(rs.getString("estado"));
    
    // Título de la tesis
    asignacion.setTesisTitulo(rs.getString("tesis_titulo"));
    
    // Fechas
    if (rs.getTimestamp("fecha_asignacion") != null) {
        asignacion.setFechaAsignacion(new java.util.Date(rs.getTimestamp("fecha_asignacion").getTime()));
    }
    if (rs.getDate("fecha_limite") != null) {
        asignacion.setFechaLimite(new java.util.Date(rs.getDate("fecha_limite").getTime()));
    }
    if (rs.getTimestamp("fecha_completada") != null) {
        asignacion.setFechaCompletada(new java.util.Date(rs.getTimestamp("fecha_completada").getTime()));
    }
    
    // Otros campos
    asignacion.setObservaciones(rs.getString("observaciones"));
    asignacion.setFeedback(rs.getString("feedback"));
    
    if (rs.getObject("calificacion") != null) {
        asignacion.setCalificacion(rs.getBigDecimal("calificacion"));
    }
    
    return asignacion;
} 
    public List<Asignacion> obtenerAsignacionesPorTesis(int tesisId) {
    List<Asignacion> asignaciones = new ArrayList<>();
    
    // CONSULTA CORRECTA basada en tu estructura REAL
    String sql = "SELECT a.*, " +
                "t.titulo as titulo_tesis, " +
                "u_estudiante.nombre as estudiante_nombre, u_estudiante.apellido as estudiante_apellido, " +
                "u_docente.nombre as docente_nombre, u_docente.apellido as docente_apellido, " +
                "c.nombre as carrera_nombre " +
                "FROM asignaciones a " +
                "INNER JOIN tesis t ON a.id_tesis = t.id " +  // CORRECTO: id_tesis se une con t.id
                "INNER JOIN estudiantes e ON t.estudiante_id = e.id " +  // CORREGIDO: estudiante_id NO id_estudiante
                "INNER JOIN usuarios u_estudiante ON e.id = u_estudiante.id " +
                "INNER JOIN docentes d ON a.id_docente = d.id " +
                "INNER JOIN usuarios u_docente ON d.id = u_docente.id " +
                "INNER JOIN carreras c ON e.carrera_id = c.id " +
                "WHERE a.id_tesis = ?";
    
    try (Connection conn = DatabaseConnection.getConnection();
         PreparedStatement stmt = conn.prepareStatement(sql)) {
        stmt.setInt(1, tesisId);
        try (ResultSet rs = stmt.executeQuery()) {
            while (rs.next()) {
                asignaciones.add(mapearAsignacion(rs));
            }
        }
    } catch (SQLException e) {
        throw new RuntimeException("Error al obtener asignaciones por tesis: " + e.getMessage(), e);
    }
    return asignaciones;
}
    
    public int crearAsignacion(Asignacion asignacion) {
        String sql = "INSERT INTO asignaciones (id_tesis, id_docente, rol, estado, fecha_limite, observaciones) " +
                    "VALUES (?, ?, ?, ?, ?, ?)";
        
        try (Connection conn = DatabaseConnection.getConnection();
             PreparedStatement stmt = conn.prepareStatement(sql, Statement.RETURN_GENERATED_KEYS)) {
            
            stmt.setInt(1, asignacion.getIdTesis());
            stmt.setInt(2, asignacion.getIdDocente());
            stmt.setString(3, asignacion.getRol());
            stmt.setString(4, asignacion.getEstado());
            
            if (asignacion.getFechaLimite() != null) {
                stmt.setDate(5, new java.sql.Date(asignacion.getFechaLimite().getTime()));
            } else {
                stmt.setNull(5, java.sql.Types.DATE);
            }
            
            stmt.setString(6, asignacion.getObservaciones());
            
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
            throw new RuntimeException("Error al crear asignación: " + e.getMessage(), e);
        }
    }
    
    public boolean actualizarAsignacion(Asignacion asignacion) {
        String sql = "UPDATE asignaciones SET estado = ?, fecha_limite = ?, observaciones = ?, " +
                    "calificacion = ?, feedback = ? " +
                    "WHERE id = ?";
        
        try (Connection conn = DatabaseConnection.getConnection();
             PreparedStatement stmt = conn.prepareStatement(sql)) {
            
            stmt.setString(1, asignacion.getEstado());
            
            if (asignacion.getFechaLimite() != null) {
                stmt.setDate(2, new java.sql.Date(asignacion.getFechaLimite().getTime()));
            } else {
                stmt.setNull(2, java.sql.Types.DATE);
            }
            
            stmt.setString(3, asignacion.getObservaciones());
            
            if (asignacion.getCalificacion() != null) {
                stmt.setBigDecimal(4, asignacion.getCalificacion());
            } else {
                stmt.setNull(4, java.sql.Types.DECIMAL);
            }
            
            stmt.setString(5, asignacion.getFeedback());
            stmt.setInt(6, asignacion.getId());
            
            return stmt.executeUpdate() > 0;
        } catch (SQLException e) {
            throw new RuntimeException("Error al actualizar asignación: " + e.getMessage(), e);
        }
    }
    
    public boolean completarAsignacion(int id, double calificacion, String feedback) {
        String sql = "UPDATE asignaciones SET estado = 'COMPLETADA', fecha_completada = CURRENT_TIMESTAMP, " +
                    "calificacion = ?, feedback = ? WHERE id = ?";
        
        try (Connection conn = DatabaseConnection.getConnection();
             PreparedStatement stmt = conn.prepareStatement(sql)) {
            
            stmt.setDouble(1, calificacion);
            stmt.setString(2, feedback);
            stmt.setInt(3, id);
            
            return stmt.executeUpdate() > 0;
        } catch (SQLException e) {
            throw new RuntimeException("Error al completar asignación: " + e.getMessage(), e);
        }
    }
    
    public boolean eliminarAsignacion(int id) {
        String sql = "DELETE FROM asignaciones WHERE id = ?";
        
        try (Connection conn = DatabaseConnection.getConnection();
             PreparedStatement stmt = conn.prepareStatement(sql)) {
            stmt.setInt(1, id);
            return stmt.executeUpdate() > 0;
        } catch (SQLException e) {
            throw new RuntimeException("Error al eliminar asignación: " + e.getMessage(), e);
        }
    }
    
    public int calcularEficienciaSistema() {
        String sql = "SELECT ROUND((COUNT(CASE WHEN estado IN ('COMPLETADA', 'EVALUADA') THEN 1 END) * 100.0 / " +
                    "GREATEST(COUNT(*), 1)), 0) as eficiencia FROM asignaciones";
        
        try (Connection conn = DatabaseConnection.getConnection();
             PreparedStatement stmt = conn.prepareStatement(sql);
             ResultSet rs = stmt.executeQuery()) {
            if (rs.next()) {
                return rs.getInt("eficiencia");
            }
        } catch (SQLException e) {
            throw new RuntimeException("Error al calcular eficiencia del sistema: " + e.getMessage(), e);
        }
        return 0;
    }
    
    public List<Object[]> obtenerEstadisticasPorDocente(int docenteId) {
        List<Object[]> estadisticas = new ArrayList<>();
        String sql = "SELECT " +
                    "COUNT(*) as total, " +
                    "COUNT(CASE WHEN estado = 'ASIGNADA' THEN 1 END) as asignadas, " +
                    "COUNT(CASE WHEN estado = 'EN_REVISION' THEN 1 END) as en_revision, " +
                    "COUNT(CASE WHEN estado = 'EN_PROGRESO' THEN 1 END) as en_progreso, " +
                    "COUNT(CASE WHEN estado IN ('COMPLETADA', 'EVALUADA') THEN 1 END) as completadas " +
                    "FROM asignaciones WHERE id_docente = ?";
        
        try (Connection conn = DatabaseConnection.getConnection();
             PreparedStatement stmt = conn.prepareStatement(sql)) {
            stmt.setInt(1, docenteId);
            try (ResultSet rs = stmt.executeQuery()) {
                if (rs.next()) {
                    Object[] stats = new Object[5];
                    stats[0] = rs.getInt("total");
                    stats[1] = rs.getInt("asignadas");
                    stats[2] = rs.getInt("en_revision");
                    stats[3] = rs.getInt("en_progreso");
                    stats[4] = rs.getInt("completadas");
                    estadisticas.add(stats);
                }
            }
        } catch (SQLException e) {
            throw new RuntimeException("Error al obtener estadísticas por docente: " + e.getMessage(), e);
        }
        return estadisticas;
    }
    
private Asignacion mapearAsignacion(ResultSet rs) throws SQLException {
    Asignacion asignacion = new Asignacion();
    
    // Solo campos básicos
    asignacion.setId(rs.getInt("id"));
    asignacion.setIdTesis(rs.getInt("id_tesis"));
    asignacion.setIdDocente(rs.getInt("id_docente"));
    asignacion.setRol(rs.getString("rol"));
    asignacion.setEstado(rs.getString("estado"));
    asignacion.setTituloTesis(rs.getString("titulo_tesis"));
    
    // Fechas opcionales
    try {
        Timestamp fechaAsignacion = rs.getTimestamp("fecha_asignacion");
        if (fechaAsignacion != null) {
            asignacion.setFechaAsignacion(new java.util.Date(fechaAsignacion.getTime()));
        }
    } catch (SQLException e) {}
    
    try {
        java.sql.Date fechaLimite = rs.getDate("fecha_limite");
        if (fechaLimite != null) {
            asignacion.setFechaLimite(new java.util.Date(fechaLimite.getTime()));
        }
    } catch (SQLException e) {}
    
    return asignacion;
}
    public boolean verificarAsignacionDocente(int idAsignacion, int idDocente) {
    String sql = "SELECT COUNT(*) FROM asignaciones WHERE id = ? AND id_docente = ?";
    
    try (Connection conn = DatabaseConnection.getConnection();
         PreparedStatement stmt = conn.prepareStatement(sql)) {
        stmt.setInt(1, idAsignacion);
        stmt.setInt(2, idDocente);
        try (ResultSet rs = stmt.executeQuery()) {
            if (rs.next()) {
                return rs.getInt(1) > 0;
            }
        }
    } catch (SQLException e) {
        System.err.println("ERROR en verificarAsignacionDocente: " + e.getMessage());
        e.printStackTrace();
        return false;
    }
    return false;
}
}