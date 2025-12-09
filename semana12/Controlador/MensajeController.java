package Controlador;

import Modelos.Mensaje;
import Modelos.Usuario;
import DAO.MensajeDAO;
import DAO.AsignacionDAO;
import jakarta.servlet.*;
import jakarta.servlet.http.*;
import jakarta.servlet.annotation.*;
import java.io.IOException;
import java.util.Date;

@WebServlet("/MensajeController")
public class MensajeController extends HttpServlet {
    
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
        }
    }
    
    private void enviarMensaje(HttpServletRequest request, HttpServletResponse response, 
                              Usuario docente) throws IOException {
        response.setContentType("application/json");
        response.setCharacterEncoding("UTF-8");
        
        try {
            // Obtener parámetros del formulario
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