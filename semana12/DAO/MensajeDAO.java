package DAO;

import Modelos.Mensaje;
import DB.DatabaseConnection;
import java.sql.*;
import java.util.ArrayList;
import java.util.List;

public class MensajeDAO {
    private Connection connection;
    
    public MensajeDAO() throws SQLException {
        connection = DatabaseConnection.getConnection();
    }
    
    // Crear un nuevo mensaje
    // Método estático para crear mensaje (como se llama en el controlador)
// Método estático para crear mensaje
public static boolean crearMensaje(Mensaje mensaje) {
    String sql = "INSERT INTO mensajes (id_asignacion, id_docente, id_estudiante, asunto, contenido, tipo_mensaje, fecha_envio, estado, adjuntos) VALUES (?, ?, ?, ?, ?, ?, ?, ?, ?)";
    
    try (Connection conn = DatabaseConnection.getConnection();
         PreparedStatement ps = conn.prepareStatement(sql)) {
        
        System.out.println("Guardando mensaje en BD con datos:");
        System.out.println("id_asignacion: " + mensaje.getIdAsignacion());
        System.out.println("id_docente: " + mensaje.getIdDocente());
        System.out.println("id_estudiante: " + mensaje.getIdEstudiante());
        System.out.println("asunto: " + mensaje.getAsunto());
        System.out.println("contenido: " + mensaje.getContenido());
        System.out.println("tipo_mensaje: " + mensaje.getTipoMensaje());
        System.out.println("fecha_envio: " + mensaje.getFechaEnvio());
        System.out.println("estado: " + mensaje.getEstado());
        System.out.println("adjuntos: " + mensaje.getAdjuntos());
        
        ps.setInt(1, mensaje.getIdAsignacion());
        ps.setInt(2, mensaje.getIdDocente());
        ps.setInt(3, mensaje.getIdEstudiante());
        ps.setString(4, mensaje.getAsunto());
        ps.setString(5, mensaje.getContenido());
        ps.setString(6, mensaje.getTipoMensaje());
        ps.setTimestamp(7, new Timestamp(mensaje.getFechaEnvio().getTime()));
        ps.setString(8, mensaje.getEstado());
        ps.setString(9, mensaje.getAdjuntos());
        
        int rowsAffected = ps.executeUpdate();
        System.out.println("Filas afectadas: " + rowsAffected);
        
        return rowsAffected > 0;
        
    } catch (SQLException e) {
        System.err.println("Error SQL al crear mensaje: " + e.getMessage());
        e.printStackTrace();
        return false;
    }
}
    
    // Obtener mensajes por estudiante
    public List<Mensaje> obtenerMensajesPorEstudiante(int idEstudiante) {
        List<Mensaje> mensajes = new ArrayList<>();
        String sql = "SELECT m.*, u.nombre as nombre_docente FROM mensajes m " +
                     "JOIN usuarios u ON m.id_docente = u.id " +
                     "WHERE m.id_estudiante = ? ORDER BY m.fecha_envio DESC";
        
        try (PreparedStatement ps = connection.prepareStatement(sql)) {
            ps.setInt(1, idEstudiante);
            ResultSet rs = ps.executeQuery();
            
            while (rs.next()) {
                mensajes.add(mapResultSetToMensaje(rs));
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        
        return mensajes;
    }
    
    // Obtener mensajes por docente
    public List<Mensaje> obtenerMensajesPorDocente(int idDocente) {
        List<Mensaje> mensajes = new ArrayList<>();
        String sql = "SELECT m.*, u.nombre as nombre_estudiante FROM mensajes m " +
                     "JOIN usuarios u ON m.id_estudiante = u.id " +
                     "WHERE m.id_docente = ? ORDER BY m.fecha_envio DESC";
        
        try (PreparedStatement ps = connection.prepareStatement(sql)) {
            ps.setInt(1, idDocente);
            ResultSet rs = ps.executeQuery();
            
            while (rs.next()) {
                mensajes.add(mapResultSetToMensaje(rs));
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        
        return mensajes;
    }
    
    // Obtener mensajes por asignación
    public List<Mensaje> obtenerMensajesPorAsignacion(int idAsignacion) {
    List<Mensaje> mensajes = new ArrayList<>();
    String sql = "SELECT m.*, d.nombre as nombre_docente, e.nombre as nombre_estudiante " +
                 "FROM mensajes m " +
                 "JOIN usuarios d ON m.id_docente = d.id " +
                 "JOIN usuarios e ON m.id_estudiante = e.id " +
                 "WHERE m.id_asignacion = ? " +
                 "ORDER BY m.fecha_envio ASC";
    
    try (PreparedStatement ps = connection.prepareStatement(sql)) {
        ps.setInt(1, idAsignacion);
        ResultSet rs = ps.executeQuery();
        
        while (rs.next()) {
            mensajes.add(mapResultSetToMensaje(rs));
        }
    } catch (SQLException e) {
        e.printStackTrace();
    }
    
    return mensajes;
}
    
    // Marcar mensaje como leído
    public boolean marcarComoLeido(int idMensaje) {
        String sql = "UPDATE mensajes SET estado = 'leido' WHERE id_mensaje = ?";
        
        try (PreparedStatement ps = connection.prepareStatement(sql)) {
            ps.setInt(1, idMensaje);
            return ps.executeUpdate() > 0;
        } catch (SQLException e) {
            e.printStackTrace();
            return false;
        }
    }
    
    // Eliminar mensaje
    public boolean eliminarMensaje(int idMensaje) {
        String sql = "DELETE FROM mensajes WHERE id_mensaje = ?";
        
        try (PreparedStatement ps = connection.prepareStatement(sql)) {
            ps.setInt(1, idMensaje);
            return ps.executeUpdate() > 0;
        } catch (SQLException e) {
            e.printStackTrace();
            return false;
        }
    }
    
    // Contar mensajes no leídos por estudiante
    public int contarMensajesNoLeidos(int idEstudiante) {
        String sql = "SELECT COUNT(*) FROM mensajes WHERE id_estudiante = ? AND estado = 'no_leido'";
        
        try (PreparedStatement ps = connection.prepareStatement(sql)) {
            ps.setInt(1, idEstudiante);
            ResultSet rs = ps.executeQuery();
            
            if (rs.next()) {
                return rs.getInt(1);
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        
        return 0;
    }
    
    // Método auxiliar para mapear ResultSet a objeto Mensaje
    private Mensaje mapResultSetToMensaje(ResultSet rs) throws SQLException {
        Mensaje mensaje = new Mensaje();
        mensaje.setId(rs.getInt("id_mensaje"));
        mensaje.setIdAsignacion(rs.getInt("id_asignacion"));
        mensaje.setIdDocente(rs.getInt("id_docente"));
        mensaje.setIdEstudiante(rs.getInt("id_estudiante"));
        mensaje.setAsunto(rs.getString("asunto"));
        mensaje.setContenido(rs.getString("contenido"));
        mensaje.setTipoMensaje(rs.getString("tipo_mensaje"));
        mensaje.setFechaEnvio(rs.getTimestamp("fecha_envio"));
        mensaje.setEstado(rs.getString("estado"));
        mensaje.setAdjuntos(rs.getString("adjuntos"));
        
        return mensaje;
    }
}