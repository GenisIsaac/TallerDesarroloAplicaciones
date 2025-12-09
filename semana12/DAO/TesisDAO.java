/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package DAO;

import DB.DatabaseConnection;
import Modelos.EstadoTesis;
import Modelos.Tesis;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;
import java.sql.Timestamp;
import java.util.ArrayList;
import java.util.Date;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

/**
 *
 * @author WindowsPC
 */
public class TesisDAO {
    
    /**
     * Obtiene todas las tesis
     * 
     * @return Lista de todas las tesis
     */
    public List<Tesis> obtenerTodasTesis() {
        List<Tesis> tesisList = new ArrayList<>();
        String sql = "SELECT t.*, " +
                    "estu.nombre as estudiante_nombre, estu.apellido as estudiante_apellido, " +
                    "doc.nombre as docente_nombre, doc.apellido as docente_apellido, " +
                    "c.nombre as carrera_nombre " +
                    "FROM tesis t " +
                    "LEFT JOIN usuarios estu ON t.estudiante_id = estu.id " +
                    "LEFT JOIN usuarios doc ON t.docente_id = doc.id " +
                    "LEFT JOIN carreras c ON t.carrera_id = c.id " +
                    "ORDER BY t.fecha_creacion DESC";
        
        try (Connection conn = (Connection) DatabaseConnection.getConnection();
             PreparedStatement stmt = conn.prepareStatement(sql);
             ResultSet rs = stmt.executeQuery()) {
            while (rs.next()) {
                tesisList.add(mapearTesis(rs));
            }
        } catch (SQLException e) {
            throw new RuntimeException("Error al obtener todas las tesis: " + e.getMessage(), e);
        }
        return tesisList;
    }
    
    /**
     * Obtiene tesis por estado (con parámetro String para compatibilidad con controlador)
     * 
     * @param estado Estado de la tesis como String
     * @return Lista de tesis con el estado especificado
     */
    public List<Tesis> obtenerTesisPorEstado(String estado) {
        List<Tesis> tesisList = new ArrayList<>();
        String sql = "SELECT t.*, " +
                    "estu.nombre as estudiante_nombre, estu.apellido as estudiante_apellido, " +
                    "doc.nombre as docente_nombre, doc.apellido as docente_apellido, " +
                    "c.nombre as carrera_nombre " +
                    "FROM tesis t " +
                    "LEFT JOIN usuarios estu ON t.estudiante_id = estu.id " +
                    "LEFT JOIN usuarios doc ON t.docente_id = doc.id " +
                    "LEFT JOIN carreras c ON t.carrera_id = c.id " +
                    "WHERE t.estado = ? " +
                    "ORDER BY t.fecha_creacion DESC";
        
        try (Connection conn = (Connection) DatabaseConnection.getConnection();
             PreparedStatement stmt = conn.prepareStatement(sql)) {
            stmt.setString(1, estado);
            try (ResultSet rs = stmt.executeQuery()) {
                while (rs.next()) {
                    tesisList.add(mapearTesis(rs));
                }
            }
        } catch (SQLException e) {
            throw new RuntimeException("Error al obtener tesis por estado: " + e.getMessage(), e);
        }
        return tesisList;
    }
    
    /**
     * Obtiene tesis por estado (versión con enum)
     * 
     * @param estado Estado de la tesis como enum
     * @return Lista de tesis con el estado especificado
     */
    public List<Tesis> obtenerTesisPorEstado(EstadoTesis estado) {
        return obtenerTesisPorEstado(estado.name());
    }
    
    /**
     * Obtiene una tesis por su ID
     * 
     * @param id ID de la tesis
     * @return Tesis encontrada o null si no existe
     */
    public Tesis obtenerTesisPorId(int id) {
        String sql = "SELECT t.*, " +
                    "estu.nombre as estudiante_nombre, estu.apellido as estudiante_apellido, " +
                    "doc.nombre as docente_nombre, doc.apellido as docente_apellido, " +
                    "c.nombre as carrera_nombre " +
                    "FROM tesis t " +
                    "LEFT JOIN usuarios estu ON t.estudiante_id = estu.id " +
                    "LEFT JOIN usuarios doc ON t.docente_id = doc.id " +
                    "LEFT JOIN carreras c ON t.carrera_id = c.id " +
                    "WHERE t.id = ?";
        
        try (Connection conn = (Connection) DatabaseConnection.getConnection();
             PreparedStatement stmt = conn.prepareStatement(sql)) {
            stmt.setInt(1, id);
            try (ResultSet rs = stmt.executeQuery()) {
                if (rs.next()) {
                    return mapearTesis(rs);
                }
            }
        } catch (SQLException e) {
            throw new RuntimeException("Error al obtener tesis por ID: " + e.getMessage(), e);
        }
        return null;
    }
    
    /**
     * Obtiene tesis por estudiante
     * 
     * @param estudianteId ID del estudiante
     * @return Lista de tesis del estudiante
     */
    public List<Tesis> obtenerTesisPorEstudiante(int estudianteId) {
        List<Tesis> tesisList = new ArrayList<>();
        String sql = "SELECT t.*, " +
                    "estu.nombre as estudiante_nombre, estu.apellido as estudiante_apellido, " +
                    "doc.nombre as docente_nombre, doc.apellido as docente_apellido, " +
                    "c.nombre as carrera_nombre " +
                    "FROM tesis t " +
                    "LEFT JOIN usuarios estu ON t.estudiante_id = estu.id " +
                    "LEFT JOIN usuarios doc ON t.docente_id = doc.id " +
                    "LEFT JOIN carreras c ON t.carrera_id = c.id " +
                    "WHERE t.estudiante_id = ? " +
                    "ORDER BY t.fecha_creacion DESC";
        
        try (Connection conn = (Connection) DatabaseConnection.getConnection();
             PreparedStatement stmt = conn.prepareStatement(sql)) {
            stmt.setInt(1, estudianteId);
            try (ResultSet rs = stmt.executeQuery()) {
                while (rs.next()) {
                    tesisList.add(mapearTesis(rs));
                }
            }
        } catch (SQLException e) {
            throw new RuntimeException("Error al obtener tesis por estudiante: " + e.getMessage(), e);
        }
        return tesisList;
    }
    
    /**
     * Obtiene tesis por docente
     * 
     * @param docenteId ID del docente
     * @return Lista de tesis asignadas al docente
     */
    public List<Tesis> obtenerTesisPorDocente(int docenteId) {
        List<Tesis> tesisList = new ArrayList<>();
        String sql = "SELECT t.*, " +
                    "estu.nombre as estudiante_nombre, estu.apellido as estudiante_apellido, " +
                    "doc.nombre as docente_nombre, doc.apellido as docente_apellido, " +
                    "c.nombre as carrera_nombre " +
                    "FROM tesis t " +
                    "LEFT JOIN usuarios estu ON t.estudiante_id = estu.id " +
                    "LEFT JOIN usuarios doc ON t.docente_id = doc.id " +
                    "LEFT JOIN carreras c ON t.carrera_id = c.id " +
                    "WHERE t.docente_id = ? " +
                    "ORDER BY t.fecha_creacion DESC";
        
        try (Connection conn = (Connection) DatabaseConnection.getConnection();
             PreparedStatement stmt = conn.prepareStatement(sql)) {
            stmt.setInt(1, docenteId);
            try (ResultSet rs = stmt.executeQuery()) {
                while (rs.next()) {
                    tesisList.add(mapearTesis(rs));
                }
            }
        } catch (SQLException e) {
            throw new RuntimeException("Error al obtener tesis por docente: " + e.getMessage(), e);
        }
        return tesisList;
    }
    
    /**
     * Crea una nueva tesis
     * 
     * @param tesis Objeto Tesis a crear
     * @return ID de la tesis creada, -1 si falla
     */
    public int crearTesis(Tesis tesis) {
        String sql = "INSERT INTO tesis (estudiante_id, docente_id, titulo, descripcion, " +
                    "estado, archivo, fecha_creacion, fecha_limite_revision, area_estudio, carrera_id) " +
                    "VALUES (?, ?, ?, ?, ?, ?, NOW(), ?, ?, ?)";
        
        try (Connection conn = (Connection) DatabaseConnection.getConnection();
             PreparedStatement stmt = conn.prepareStatement(sql, Statement.RETURN_GENERATED_KEYS)) {
            
            stmt.setInt(1, tesis.getEstudianteId());
            stmt.setObject(2, tesis.getDocenteId() > 0 ? tesis.getDocenteId() : null);
            stmt.setString(3, tesis.getTitulo());
            stmt.setString(4, tesis.getDescripcion());
            stmt.setString(5, tesis.getEstado());
            stmt.setString(6, tesis.getArchivo());
            
            if (tesis.getFechaLimiteRevision() != null) {
                stmt.setDate(7, new java.sql.Date(tesis.getFechaLimiteRevision().getTime()));
            } else {
                stmt.setNull(7, java.sql.Types.DATE);
            }
            
            stmt.setString(8, tesis.getAreaEstudio());
            stmt.setInt(9, tesis.getCarreraId());
            
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
            throw new RuntimeException("Error al crear tesis: " + e.getMessage(), e);
        }
    }
    
    /**
     * Actualiza una tesis existente
     * 
     * @param tesis Objeto Tesis con los datos actualizados
     * @return true si se actualizó correctamente, false en caso contrario
     */
    public boolean actualizarTesis(Tesis tesis) {
        String sql = "UPDATE tesis SET titulo = ?, descripcion = ?, estado = ?, " +
                    "area_estudio = ?, carrera_id = ?, docente_id = ?, comentarios = ?, " +
                    "calificacion = ?, fecha_limite_revision = ?, archivo = ? WHERE id = ?";
        
        try (Connection conn = (Connection) DatabaseConnection.getConnection();
             PreparedStatement stmt = conn.prepareStatement(sql)) {
            
            stmt.setString(1, tesis.getTitulo());
            stmt.setString(2, tesis.getDescripcion());
            stmt.setString(3, tesis.getEstado());
            stmt.setString(4, tesis.getAreaEstudio());
            stmt.setInt(5, tesis.getCarreraId());
            stmt.setObject(6, tesis.getDocenteId() > 0 ? tesis.getDocenteId() : null);
            stmt.setString(7, tesis.getComentarios());
            stmt.setDouble(8, tesis.getCalificacion());
            
            if (tesis.getFechaLimiteRevision() != null) {
                stmt.setDate(9, new java.sql.Date(tesis.getFechaLimiteRevision().getTime()));
            } else {
                stmt.setNull(9, java.sql.Types.DATE);
            }
            
            stmt.setString(10, tesis.getArchivo());
            stmt.setInt(11, tesis.getId());
            
            return stmt.executeUpdate() > 0;
        } catch (SQLException e) {
            throw new RuntimeException("Error al actualizar tesis: " + e.getMessage(), e);
        }
    }
    
    /**
     * Actualiza solo el estado de una tesis (método usado por el controlador)
     * 
     * @param tesisId ID de la tesis
     * @param estado Nuevo estado
     * @return true si se actualizó correctamente, false en caso contrario
     */
    public boolean actualizarEstado(int tesisId, String estado) {
        String sql = "UPDATE tesis SET estado = ? WHERE id = ?";
        
        try (Connection conn = (Connection) DatabaseConnection.getConnection();
             PreparedStatement stmt = conn.prepareStatement(sql)) {
            
            stmt.setString(1, estado);
            stmt.setInt(2, tesisId);
            
            return stmt.executeUpdate() > 0;
        } catch (SQLException e) {
            throw new RuntimeException("Error al actualizar estado de tesis: " + e.getMessage(), e);
        }
    }
    
    /**
     * Elimina una tesis
     * 
     * @param id ID de la tesis a eliminar
     * @return true si se eliminó correctamente, false en caso contrario
     */
    public boolean eliminarTesis(int id) {
        String sql = "DELETE FROM tesis WHERE id = ?";
        
        try (Connection conn = (Connection) DatabaseConnection.getConnection();
             PreparedStatement stmt = conn.prepareStatement(sql)) {
            stmt.setInt(1, id);
            return stmt.executeUpdate() > 0;
        } catch (SQLException e) {
            throw new RuntimeException("Error al eliminar tesis: " + e.getMessage(), e);
        }
    }
    
    /**
     * Asigna un docente a una tesis y establece fecha límite
     * 
     * @param tesisId ID de la tesis
     * @param docenteId ID del docente
     * @param fechaLimite Fecha límite para la revisión
     * @return true si se asignó correctamente, false en caso contrario
     */
    public boolean asignarDocenteATesis(int tesisId, int docenteId, java.util.Date fechaLimite) {
        String sql = "UPDATE tesis SET docente_id = ?, estado = 'EN_REVISION', " +
                    "fecha_limite_revision = ? WHERE id = ?";
        
        try (Connection conn = (Connection) DatabaseConnection.getConnection();
             PreparedStatement stmt = conn.prepareStatement(sql)) {
            
            stmt.setInt(1, docenteId);
            stmt.setDate(2, new java.sql.Date(fechaLimite.getTime()));
            stmt.setInt(3, tesisId);
            
            return stmt.executeUpdate() > 0;
        } catch (SQLException e) {
            throw new RuntimeException("Error al asignar docente a tesis: " + e.getMessage(), e);
        }
    }
    
    /**
     * Cuenta el total de tesis
     * 
     * @return Número total de tesis
     */
    public int contarTesisTotales() {
        String sql = "SELECT COUNT(*) as total FROM tesis";
        
        try (Connection conn = (Connection) DatabaseConnection.getConnection();
             PreparedStatement stmt = conn.prepareStatement(sql);
             ResultSet rs = stmt.executeQuery()) {
            if (rs.next()) {
                return rs.getInt("total");
            }
        } catch (SQLException e) {
            throw new RuntimeException("Error al contar tesis totales: " + e.getMessage(), e);
        }
        return 0;
    }
    
    /**
     * Cuenta las tesis sin asignar (estado PENDIENTE)
     * 
     * @return Número de tesis sin asignar
     */
    public int contarTesisSinAsignar() {
        String sql = "SELECT COUNT(*) as total FROM tesis WHERE estado = 'PENDIENTE'";
        
        try (Connection conn = (Connection) DatabaseConnection.getConnection();
             PreparedStatement stmt = conn.prepareStatement(sql);
             ResultSet rs = stmt.executeQuery()) {
            if (rs.next()) {
                return rs.getInt("total");
            }
        } catch (SQLException e) {
            throw new RuntimeException("Error al contar tesis sin asignar: " + e.getMessage(), e);
        }
        return 0;
    }
    
    /**
     * Obtiene el porcentaje de tesis aprobadas
     * 
     * @return Porcentaje de tesis aprobadas
     */
    public int obtenerPorcentajeCompletadas() {
        String sql = "SELECT ROUND((COUNT(CASE WHEN estado = 'APROBADA' THEN 1 END) * 100.0 / " +
                    "GREATEST(COUNT(*), 1)), 0) as porcentaje FROM tesis";
        
        try (Connection conn = (Connection) DatabaseConnection.getConnection();
             PreparedStatement stmt = conn.prepareStatement(sql);
             ResultSet rs = stmt.executeQuery()) {
            if (rs.next()) {
                return rs.getInt("porcentaje");
            }
        } catch (SQLException e) {
            throw new RuntimeException("Error al obtener porcentaje de completadas: " + e.getMessage(), e);
        }
        return 0;
    }
    
    /**
     * Obtiene las tesis pendientes de asignación (alias para obtenerTesisPorEstado("PENDIENTE"))
     * 
     * @return Lista de tesis pendientes
     */
    public List<Tesis> obtenerPendientes() {
        return obtenerTesisPorEstado("PENDIENTE");
    }
    
    /**
     * Obtiene las tesis en revisión
     * 
     * @return Lista de tesis en revisión
     */
    public List<Tesis> obtenerEnRevision() {
        return obtenerTesisPorEstado("EN_REVISION");
    }
    
    /**
     * Obtiene las tesis evaluadas
     * 
     * @return Lista de tesis evaluadas
     */
    public List<Tesis> obtenerEvaluadas() {
        return obtenerTesisPorEstado("EVALUADA");
    }
    
    /**
     * Obtiene estadísticas de tesis por estado
     * 
     * @return Mapa con estadísticas por estado
     */
    public java.util.Map<String, Integer> obtenerEstadisticasPorEstado() {
        java.util.Map<String, Integer> estadisticas = new java.util.HashMap<>();
        String sql = "SELECT estado, COUNT(*) as cantidad FROM tesis GROUP BY estado";
        
        try (Connection conn = (Connection) DatabaseConnection.getConnection();
             PreparedStatement stmt = conn.prepareStatement(sql);
             ResultSet rs = stmt.executeQuery()) {
            while (rs.next()) {
                estadisticas.put(rs.getString("estado"), rs.getInt("cantidad"));
            }
        } catch (SQLException e) {
            throw new RuntimeException("Error al obtener estadísticas por estado: " + e.getMessage(), e);
        }
        return estadisticas;
    }
    
    /**
     * Obtiene las tesis que están atrasadas (fecha límite pasada y estado EN_REVISION)
     * 
     * @return Lista de tesis atrasadas
     */
    public List<Tesis> obtenerTesisAtrasadas() {
        List<Tesis> tesisList = new ArrayList<>();
        String sql = "SELECT t.*, " +
                    "estu.nombre as estudiante_nombre, estu.apellido as estudiante_apellido, " +
                    "doc.nombre as docente_nombre, doc.apellido as docente_apellido, " +
                    "c.nombre as carrera_nombre " +
                    "FROM tesis t " +
                    "LEFT JOIN usuarios estu ON t.estudiante_id = estu.id " +
                    "LEFT JOIN usuarios doc ON t.docente_id = doc.id " +
                    "LEFT JOIN carreras c ON t.carrera_id = c.id " +
                    "WHERE t.estado = 'EN_REVISION' AND t.fecha_limite_revision < CURDATE() " +
                    "ORDER BY t.fecha_limite_revision ASC";
        
        try (Connection conn = (Connection) DatabaseConnection.getConnection();
             PreparedStatement stmt = conn.prepareStatement(sql);
             ResultSet rs = stmt.executeQuery()) {
            while (rs.next()) {
                tesisList.add(mapearTesis(rs));
            }
        } catch (SQLException e) {
            throw new RuntimeException("Error al obtener tesis atrasadas: " + e.getMessage(), e);
        }
        return tesisList;
    }
    
    /**
     * Mapea un ResultSet a un objeto Tesis
     * 
     * @param rs ResultSet de la consulta
     * @return Objeto Tesis mapeado
     * @throws SQLException Si hay error al acceder a los datos
     */
    private Tesis mapearTesis(ResultSet rs) throws SQLException {
        Tesis tesis = new Tesis();
        tesis.setId(rs.getInt("id"));
        tesis.setEstudianteId(rs.getInt("estudiante_id"));
        tesis.setDocenteId(rs.getInt("docente_id"));
        tesis.setTitulo(rs.getString("titulo"));
        tesis.setDescripcion(rs.getString("descripcion"));
        tesis.setEstado(rs.getString("estado"));
        tesis.setArchivo(rs.getString("archivo"));
        
        Timestamp fechaEntrega = rs.getTimestamp("fecha_entrega");
        if (fechaEntrega != null) {
            tesis.setFechaEntrega(new java.util.Date(fechaEntrega.getTime()));
        }
        
        java.sql.Date fechaLimite = rs.getDate("fecha_limite_revision");
        if (fechaLimite != null) {
            tesis.setFechaLimiteRevision(new java.util.Date(fechaLimite.getTime()));
        }
        
        tesis.setAreaEstudio(rs.getString("area_estudio"));
        tesis.setCarreraId(rs.getInt("carrera_id"));
        tesis.setComentarios(rs.getString("comentarios"));
        tesis.setCalificacion(rs.getDouble("calificacion"));
        
        Timestamp fechaCreacion = rs.getTimestamp("fecha_creacion");
        if (fechaCreacion != null) {
            tesis.setFechaCreacion(new java.util.Date(fechaCreacion.getTime()));
        }
        
        Timestamp fechaModificacion = rs.getTimestamp("fecha_ultima_modificacion");
        if (fechaModificacion != null) {
            tesis.setFechaUltimaModificacion(new java.util.Date(fechaModificacion.getTime()));
        }
        
        // Información adicional de relaciones
        String estudianteNombre = rs.getString("estudiante_nombre");
        String estudianteApellido = rs.getString("estudiante_apellido");
        if (estudianteNombre != null && estudianteApellido != null) {
            tesis.setEstudianteNombre(estudianteNombre + " " + estudianteApellido);
        }
        
        String docenteNombre = rs.getString("docente_nombre");
        String docenteApellido = rs.getString("docente_apellido");
        if (docenteNombre != null && docenteApellido != null) {
            tesis.setDocenteNombre(docenteNombre + " " + docenteApellido);
        }
        
        String carreraNombre = rs.getString("carrera_nombre");
        if (carreraNombre != null) {
            tesis.setCarreraNombre(carreraNombre);
        }
        
        return tesis;
    }
    
    /**
 * Verifica si un estudiante existe en la base de datos
 */
public boolean existeEstudiante(int estudianteId) {
    String sql = "SELECT COUNT(*) FROM usuarios WHERE id = ? AND rol = 'ESTUDIANTE'";
    
    try (Connection conn = (Connection) DatabaseConnection.getConnection();
         PreparedStatement stmt = conn.prepareStatement(sql)) {
        stmt.setInt(1, estudianteId);
        try (ResultSet rs = stmt.executeQuery()) {
            if (rs.next()) {
                return rs.getInt(1) > 0;
            }
        }
    } catch (SQLException e) {
        throw new RuntimeException("Error al verificar estudiante: " + e.getMessage(), e);
    }
    return false;
}

/**
 * Crea una tesis con la estructura que muestras en el error
 * (con campos: estudiante_id, titulo, resumen, palabras_clave, estado, nivel_estudio, semestre, ano_academico)
 */
public int crearTesisConEstructura(int estudianteId, String titulo, String resumen, 
                                  String palabrasClave, String nivelEstudio, 
                                  int semestre, int anoAcademico) {
    String sql = "INSERT INTO tesis (estudiante_id, titulo, resumen, palabras_clave, " +
                 "estado, nivel_estudio, semestre, ano_academico) " +
                 "VALUES (?, ?, ?, ?, 'BORRADOR', ?, ?, ?)";
    
    try (Connection conn = (Connection) DatabaseConnection.getConnection();
         PreparedStatement stmt = conn.prepareStatement(sql, Statement.RETURN_GENERATED_KEYS)) {
        
        stmt.setInt(1, estudianteId);
        stmt.setString(2, titulo);
        stmt.setString(3, resumen != null ? resumen : "");
        stmt.setString(4, palabrasClave != null ? palabrasClave : "");
        stmt.setString(5, nivelEstudio);
        stmt.setInt(6, semestre);
        stmt.setInt(7, anoAcademico);
        
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
        System.err.println("❌ Error al crear tesis: " + e.getMessage());
        e.printStackTrace();
        throw new RuntimeException("Error al crear tesis: " + e.getMessage(), e);
    }
}


/**
 * Actualiza el estado de tesis de un estudiante
 */
public void actualizarEstadoEstudiante(int estudianteId, String estado) throws SQLException {
    String sql = "UPDATE usuarios SET estado_tesis = ? WHERE id = ?";
    
    try (Connection conn = (Connection) DatabaseConnection.getConnection();
         PreparedStatement stmt = conn.prepareStatement(sql)) {
        
        stmt.setString(1, estado);
        stmt.setInt(2, estudianteId);
        
        stmt.executeUpdate();
    }
}

/**
 * Obtiene el año académico actual
 */
private int obtenerAnoAcademicoActual() {
    java.util.Calendar cal = java.util.Calendar.getInstance();
    return cal.get(java.util.Calendar.YEAR);
}

/**
 * Verifica si ya existe una tesis para un estudiante
 */
public boolean tieneTesisActiva(int estudianteId) {
    String sql = "SELECT COUNT(*) FROM tesis WHERE estudiante_id = ? " +
                 "AND estado IN ('BORRADOR', 'EN_REVISION', 'PENDIENTE')";
    
    try (Connection conn = (Connection) DatabaseConnection.getConnection();
         PreparedStatement stmt = conn.prepareStatement(sql)) {
        stmt.setInt(1, estudianteId);
        try (ResultSet rs = stmt.executeQuery()) {
            if (rs.next()) {
                return rs.getInt(1) > 0;
            }
        }
    } catch (SQLException e) {
        throw new RuntimeException("Error al verificar tesis activa: " + e.getMessage(), e);
    }
    return false;
}

   /**
     * Obtiene todas las tesis donde el docente es el asesor
     * @param idAsesor ID del docente asesor
     * @return Lista de tesis asesoradas
     */
    public List<Tesis> obtenerTesisPorAsesor(int idAsesor) {
        List<Tesis> tesisList = new ArrayList<>();
        String sql = "SELECT t.*, " +
                     "e.nombre as nombre_estudiante, e.apellido as apellido_estudiante, " +
                     "c.nombre as carrera_nombre, " +
                     "d.nombre as nombre_docente, d.apellido as apellido_docente " +
                     "FROM tesis t " +
                     "INNER JOIN estudiantes e ON t.id_estudiante = e.id " +
                     "LEFT JOIN carreras c ON e.id_carrera = c.id " +
                     "LEFT JOIN docentes d ON t.id_docente = d.id " +
                     "WHERE t.id_asesor = ? " +
                     "ORDER BY t.fecha_creacion DESC";
        
        try (Connection conn = DatabaseConnection.getConnection();
             PreparedStatement stmt = conn.prepareStatement(sql)) {
            
            stmt.setInt(1, idAsesor);
            ResultSet rs = stmt.executeQuery();
            
            while (rs.next()) {
                Tesis tesis = mapTesisFromResultSet(rs);
                tesisList.add(tesis);
            }
            
        } catch (SQLException e) {
            System.err.println("Error al obtener tesis por asesor: " + e.getMessage());
            e.printStackTrace();
        }
        
        return tesisList;
    }
    
    /**
     * Método auxiliar para mapear un ResultSet a un objeto Tesis
     */
   // Método corregido para mapear fechas correctamente
private Tesis mapTesisFromResultSet(ResultSet rs) throws SQLException {
    Tesis tesis = new Tesis();
    
    // Mapear los campos básicos
    tesis.setId(rs.getInt("id"));
    tesis.setTitulo(rs.getString("titulo"));
    tesis.setDescripcion(rs.getString("descripcion"));
    tesis.setResumen(rs.getString("resumen"));
    tesis.setPalabrasClave(rs.getString("palabras_clave"));
    tesis.setAreaEstudio(rs.getString("area_estudio"));
    tesis.setCarrera(rs.getString("carrera"));
    tesis.setNivelEstudio(rs.getString("nivel_estudio"));
    tesis.setEstado(rs.getString("estado"));
    tesis.setCalificacion(rs.getDouble("calificacion"));
    tesis.setComentarios(rs.getString("comentarios"));
    
    // Campos de fechas - CORREGIDO
    java.sql.Date fechaCreacion = rs.getDate("fecha_creacion");
    if (fechaCreacion != null) {
        tesis.setFechaCreacion(new Date(fechaCreacion.getTime())); // Convertir java.sql.Date a java.util.Date
    }
    
    java.sql.Date fechaEntrega = rs.getDate("fecha_entrega");
    if (fechaEntrega != null) {
        tesis.setFechaEntrega(new Date(fechaEntrega.getTime()));
    }
    
    java.sql.Date fechaLimite = rs.getDate("fecha_limite_revision");
    if (fechaLimite != null) {
        tesis.setFechaLimiteRevision(new Date(fechaLimite.getTime()));
    }
    
    // IDs de relaciones
    tesis.setEstudianteId(rs.getInt("id_estudiante"));
    tesis.setDocenteId(rs.getInt("id_docente"));
    
    // NUEVO: Campo para asesor
    tesis.setAsesorId(rs.getInt("id_asesor"));
    
    // Nombres completos
    String nombreEstudiante = rs.getString("nombre_estudiante");
    String apellidoEstudiante = rs.getString("apellido_estudiante");
    if (nombreEstudiante != null && apellidoEstudiante != null) {
        tesis.setEstudianteNombre(nombreEstudiante + " " + apellidoEstudiante);
    }
    
    String nombreDocente = rs.getString("nombre_docente");
    String apellidoDocente = rs.getString("apellido_docente");
    if (nombreDocente != null && apellidoDocente != null) {
        tesis.setDocenteNombre(nombreDocente + " " + apellidoDocente);
    }
    
    // Información de carrera
    tesis.setCarreraNombre(rs.getString("carrera_nombre"));
    
    // Otros campos
    tesis.setSemestre(rs.getInt("semestre"));
    tesis.setAnoAcademico(rs.getInt("ano_academico"));
    tesis.setArchivo(rs.getString("archivo"));
    
    return tesis;
}
    
    /**
     * Método alternativo si no tienes la tabla 'carreras' separada
     */
    
    /**
     * Cuenta el número de tesis que un docente está asesorando
     */
    public int contarTesisPorAsesor(int idAsesor) {
        String sql = "SELECT COUNT(*) as total FROM tesis WHERE id_asesor = ?";
        
        try (Connection conn = DatabaseConnection.getConnection();
             PreparedStatement stmt = conn.prepareStatement(sql)) {
            
            stmt.setInt(1, idAsesor);
            ResultSet rs = stmt.executeQuery();
            
            if (rs.next()) {
                return rs.getInt("total");
            }
            
        } catch (SQLException e) {
            System.err.println("Error al contar tesis por asesor: " + e.getMessage());
            e.printStackTrace();
        }
        
        return 0;
    }
    
    /**
     * Obtiene estadísticas de tesis asesoradas por estado
     */
    public Map<String, Integer> obtenerEstadisticasAsesorias(int idAsesor) {
        Map<String, Integer> estadisticas = new HashMap<>();
        String sql = "SELECT estado, COUNT(*) as cantidad " +
                     "FROM tesis " +
                     "WHERE id_asesor = ? " +
                     "GROUP BY estado";
        
        try (Connection conn = DatabaseConnection.getConnection();
             PreparedStatement stmt = conn.prepareStatement(sql)) {
            
            stmt.setInt(1, idAsesor);
            ResultSet rs = stmt.executeQuery();
            
            while (rs.next()) {
                String estado = rs.getString("estado");
                int cantidad = rs.getInt("cantidad");
                estadisticas.put(estado, cantidad);
            }
            
        } catch (SQLException e) {
            System.err.println("Error al obtener estadísticas de asesorías: " + e.getMessage());
            e.printStackTrace();
        }
        
        return estadisticas;
    }
}