package Controlador;

import Modelos.Mensaje;
import Modelos.Usuario;
import DAO.MensajeDAO;
import DAO.AsignacionDAO;
import jakarta.servlet.*;
import jakarta.servlet.http.*;
import jakarta.servlet.annotation.*;
import java.io.IOException;
import java.io.PrintWriter;
import java.util.Date;
import java.util.List;
import java.text.SimpleDateFormat;

@WebServlet("/MensajeController")
public class MensajeController extends HttpServlet {
    
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String action = request.getParameter("action");
        HttpSession session = request.getSession();
        Usuario docente = (Usuario) session.getAttribute("usuario");
        
        if (docente == null) {
            response.sendRedirect("index.jsp");
            return;
        }
        
        if ("obtener".equals(action)) {
            obtenerMensajes(request, response, docente);
        }
    }
    
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String action = request.getParameter("action");
        HttpSession session = request.getSession();
        Usuario docente = (Usuario) session.getAttribute("usuario");
        
        if (docente == null) {
            response.sendRedirect("index.jsp");
            return;
        }
        
        switch (action) {
            case "enviar":
                enviarMensaje(request, response, docente);
                break;
            case "marcarLeido":
                marcarComoLeido(request, response);
                break;
            case "eliminar":
                eliminarMensaje(request, response);
                break;
            case "marcarLeidoPorAsignacion":
                marcarComoLeidoPorAsignacion(request, response);
                break;
            case "typing":
                manejarTyping(request, response, docente);
                break;
        }
    }
    
    private void obtenerMensajes(HttpServletRequest request, HttpServletResponse response, Usuario docente) throws IOException {
        response.setContentType("application/json");
        response.setCharacterEncoding("UTF-8");
        
        try {
            int idAsignacion = Integer.parseInt(request.getParameter("idAsignacion"));
            int lastId = request.getParameter("lastId") != null ? 
                         Integer.parseInt(request.getParameter("lastId")) : 0;
            
            System.out.println("Obteniendo mensajes para asignación: " + idAsignacion + ", lastId: " + lastId);
            
            // Validar que el docente tiene permiso para ver mensajes de esta asignación
            AsignacionDAO asignacionDAO = new AsignacionDAO();
            boolean tienePermiso = asignacionDAO.verificarAsignacionDocente(idAsignacion, docente.getId());
            
            if (!tienePermiso) {
                response.getWriter().write("[]");
                return;
            }
            
            MensajeDAO mensajeDAO = new MensajeDAO();
            List<Mensaje> mensajes;
            
            if (lastId > 0) {
                mensajes = mensajeDAO.obtenerTodosMensajesPorAsignacion(idAsignacion);
            } else {
                mensajes = mensajeDAO.obtenerTodosMensajesPorAsignacion(idAsignacion);
            }
            
            // Convertir a JSON manualmente
            String json = convertirMensajesAJson(mensajes);
            response.getWriter().write(json);
            
        } catch (NumberFormatException e) {
            e.printStackTrace();
            response.getWriter().write("[]");
        } catch (Exception e) {
            e.printStackTrace();
            response.getWriter().write("[]");
        }
    }
    
    private String convertirMensajesAJson(List<Mensaje> mensajes) {
        StringBuilder json = new StringBuilder("[");
        SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
        
        for (int i = 0; i < mensajes.size(); i++) {
            Mensaje m = mensajes.get(i);
            json.append("{");
            json.append("\"id\":").append(m.getId()).append(",");
            json.append("\"idAsignacion\":").append(m.getIdAsignacion()).append(",");
            json.append("\"idDocente\":").append(m.getIdDocente()).append(",");
            json.append("\"idEstudiante\":").append(m.getIdEstudiante()).append(",");
            json.append("\"asunto\":\"").append(escapeJson(m.getAsunto())).append("\",");
            json.append("\"contenido\":\"").append(escapeJson(m.getContenido())).append("\",");
            json.append("\"tipoMensaje\":\"").append(escapeJson(m.getTipoMensaje())).append("\",");
            json.append("\"fechaEnvio\":\"").append(m.getFechaEnvio() != null ? sdf.format(m.getFechaEnvio()) : "").append("\",");
            json.append("\"estado\":\"").append(escapeJson(m.getEstado())).append("\",");
            json.append("\"adjuntos\":\"").append(escapeJson(m.getAdjuntos())).append("\"");
            json.append("}");
            
            if (i < mensajes.size() - 1) {
                json.append(",");
            }
        }
        
        json.append("]");
        return json.toString();
    }
    
    private String escapeJson(String text) {
        if (text == null) return "";
        return text.replace("\\", "\\\\")
                   .replace("\"", "\\\"")
                   .replace("\b", "\\b")
                   .replace("\f", "\\f")
                   .replace("\n", "\\n")
                   .replace("\r", "\\r")
                   .replace("\t", "\\t");
    }
    
    private void enviarMensaje(HttpServletRequest request, HttpServletResponse response, 
                              Usuario docente) throws IOException {
        response.setContentType("application/json");
        response.setCharacterEncoding("UTF-8");
        
        try {
            int idAsignacion = Integer.parseInt(request.getParameter("idAsignacion"));
            int idEstudiante = Integer.parseInt(request.getParameter("idEstudiante"));
            String asunto = request.getParameter("asunto");
            String contenido = request.getParameter("contenido");
            String tipoMensaje = request.getParameter("tipoMensaje");
            
            System.out.println("Datos recibidos para mensaje:");
            System.out.println("idAsignacion: " + idAsignacion);
            System.out.println("idEstudiante: " + idEstudiante);
            System.out.println("asunto: " + asunto);
            System.out.println("contenido: " + contenido);
            System.out.println("tipoMensaje: " + tipoMensaje);
            
            // Validar que el docente tiene permiso para enviar mensaje a esta asignación
            AsignacionDAO asignacionDAO = new AsignacionDAO();
            boolean tienePermiso = asignacionDAO.verificarAsignacionDocente(idAsignacion, docente.getId());
            
            if (!tienePermiso) {
                response.getWriter().write("{\"success\": false, \"error\": \"No autorizado para enviar mensaje a esta asignación\"}");
                return;
            }
            
            // Crear el objeto Mensaje con todos los campos necesarios
            Mensaje mensaje = new Mensaje();
            mensaje.setIdAsignacion(idAsignacion);
            mensaje.setIdDocente(docente.getId());
            mensaje.setIdEstudiante(idEstudiante);
            mensaje.setAsunto(asunto);
            mensaje.setContenido(contenido);
            mensaje.setTipoMensaje(tipoMensaje != null ? tipoMensaje : "general");
            mensaje.setFechaEnvio(new Date());
            mensaje.setEstado("no_leido");
            mensaje.setAdjuntos("");
            
            // Usar el método estático para crear el mensaje
            boolean enviado = MensajeDAO.crearMensaje(mensaje);
            
            if (enviado) {
                System.out.println("Mensaje guardado exitosamente en la base de datos");
                response.getWriter().write("{\"success\": true, \"message\": \"Mensaje enviado exitosamente\"}");
            } else {
                System.out.println("Error al guardar el mensaje en la base de datos");
                response.getWriter().write("{\"success\": false, \"error\": \"Error al guardar el mensaje en la base de datos\"}");
            }
            
        } catch (NumberFormatException e) {
            e.printStackTrace();
            response.getWriter().write("{\"success\": false, \"error\": \"Formato de datos inválido\"}");
        } catch (Exception e) {
            e.printStackTrace();
            response.getWriter().write("{\"success\": false, \"error\": \"Error interno: " + e.getMessage() + "\"}");
        }
    }
    
    private void marcarComoLeido(HttpServletRequest request, HttpServletResponse response) throws IOException {
        try {
            int idMensaje = Integer.parseInt(request.getParameter("idMensaje"));
            MensajeDAO mensajeDAO = new MensajeDAO();
            boolean actualizado = mensajeDAO.marcarComoLeido(idMensaje);
            
            if (actualizado) {
                response.getWriter().write("{\"success\": true}");
            } else {
                response.getWriter().write("{\"success\": false, \"error\": \"No se pudo marcar como leído\"}");
            }
        } catch (Exception e) {
            e.printStackTrace();
            response.getWriter().write("{\"success\": false, \"error\": \"Error interno\"}");
        }
    }
    
    private void marcarComoLeidoPorAsignacion(HttpServletRequest request, HttpServletResponse response) throws IOException {
        try {
            int idAsignacion = Integer.parseInt(request.getParameter("idAsignacion"));
            int idEstudiante = Integer.parseInt(request.getParameter("idEstudiante"));
            
            MensajeDAO mensajeDAO = new MensajeDAO();
            boolean actualizado = mensajeDAO.marcarComoLeidoPorAsignacion(idAsignacion, idEstudiante);
            
            if (actualizado) {
                response.getWriter().write("{\"success\": true}");
            } else {
                response.getWriter().write("{\"success\": false, \"error\": \"No se pudo marcar como leído\"}");
            }
        } catch (Exception e) {
            e.printStackTrace();
            response.getWriter().write("{\"success\": false, \"error\": \"Error interno\"}");
        }
    }
    
    private void manejarTyping(HttpServletRequest request, HttpServletResponse response, Usuario docente) throws IOException {
        response.setContentType("application/json");
        response.setCharacterEncoding("UTF-8");
        
        try {
            int idAsignacion = Integer.parseInt(request.getParameter("idAsignacion"));
            boolean typing = Boolean.parseBoolean(request.getParameter("typing"));
            
            // Aquí podrías guardar en una tabla temporal de typing
            // Por ahora solo devolvemos éxito
            response.getWriter().write("{\"success\": true, \"typing\": " + typing + "}");
            
        } catch (Exception e) {
            e.printStackTrace();
            response.getWriter().write("{\"success\": false}");
        }
    }
    
    private void eliminarMensaje(HttpServletRequest request, HttpServletResponse response) throws IOException {
        try {
            int idMensaje = Integer.parseInt(request.getParameter("idMensaje"));
            MensajeDAO mensajeDAO = new MensajeDAO();
            boolean eliminado = mensajeDAO.eliminarMensaje(idMensaje);
            
            if (eliminado) {
                response.getWriter().write("{\"success\": true}");
            } else {
                response.getWriter().write("{\"success\": false, \"error\": \"No se pudo eliminar el mensaje\"}");
            }
        } catch (Exception e) {
            e.printStackTrace();
            response.getWriter().write("{\"success\": false, \"error\": \"Error interno\"}");
        }
    }
}