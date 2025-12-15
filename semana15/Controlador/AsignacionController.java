package Controlador;

import DAO.AsignacionDAO;
import DAO.TesisDAO;
import DAO.UsuarioDAO;
import Modelos.Asignacion;
import Modelos.Tesis;
import Modelos.Docente;
import jakarta.servlet.*;
import jakarta.servlet.http.*;
import jakarta.servlet.annotation.*;
import java.io.*;
import java.text.SimpleDateFormat;
import java.util.Date;
import java.util.List;
import java.util.Map;
import java.math.BigDecimal;

@WebServlet("/AsignacionController")
public class AsignacionController extends HttpServlet {
    
    private AsignacionDAO asignacionDAO;
    private TesisDAO tesisDAO;
    private UsuarioDAO usuarioDAO;
    
    @Override
    public void init() {
        asignacionDAO = new AsignacionDAO();
        tesisDAO = new TesisDAO();
        usuarioDAO = new UsuarioDAO();
    }
    
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) 
            throws ServletException, IOException {
        
        String action = request.getParameter("action");
        if (action == null) action = "listarPendientes";
        
        try {
            switch (action) {
                case "listarPendientes":
                    listarTesisPendientes(request, response);
                    break;
                case "listarAsignaciones":
                    listarAsignaciones(request, response);
                    break;
                case "obtenerPorId":
                    obtenerAsignacionPorId(request, response);
                    break;
                case "obtenerPorDocente":
                    obtenerAsignacionesPorDocente(request, response);
                    break;
                case "obtenerPorTesis":
                    obtenerAsignacionesPorTesis(request, response);
                    break;
                case "estadisticas":
                    obtenerEstadisticasAsignaciones(request, response);
                    break;
                case "eliminar":
                    eliminarAsignacion(request, response);
                    break;
                case "eficiencia":
                    obtenerEficienciaSistema(request, response);
                    break;
                case "estadisticasDocente":
                    obtenerEstadisticasDocente(request, response);
                    break;
                default:
                    response.sendRedirect("admin/asignar-tesis.jsp");
            }
        } catch (Exception e) {
            e.printStackTrace();
            request.setAttribute("error", "Error en el sistema: " + e.getMessage());
            request.getRequestDispatcher("error.jsp").forward(request, response);
        }
    }
    
    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) 
            throws ServletException, IOException {
        
        String action = request.getParameter("action");
        if (action == null) action = "asignar";
        
        try {
            switch (action) {
                case "asignar":
                    asignarTesis(request, response);
                    break;
                case "asignarAsesoria":
                    asignarAsesoria(request, response);
                    break;
                case "actualizar":
                    actualizarAsignacion(request, response);
                    break;
                case "completar":
                    completarAsignacion(request, response);
                    break;
                case "completarConCalificacion":
                    completarAsignacionConCalificacion(request, response);
                    break;
                case "cancelar":
                    cancelarAsignacion(request, response);
                    break;
                default:
                    response.sendRedirect("admin/asignar-tesis.jsp");
            }
        } catch (Exception e) {
            e.printStackTrace();
            request.setAttribute("error", "Error en el sistema: " + e.getMessage());
            request.getRequestDispatcher("error.jsp").forward(request, response);
        }
    }
    
    // ============= MÉTODOS PRIVADOS =============
    
    /**
     * Lista las tesis pendientes de asignación
     */
    private void listarTesisPendientes(HttpServletRequest request, HttpServletResponse response) 
            throws ServletException, IOException {
        
        // Obtener tesis pendientes de asignación
        List<Tesis> tesisPendientes = tesisDAO.obtenerTesisPorEstado("PENDIENTE");
        
        // Para AJAX
        if ("true".equals(request.getParameter("ajax"))) {
            enviarJSONTesis(response, tesisPendientes);
            return;
        }
        
        request.setAttribute("tesisPendientes", tesisPendientes);
        request.getRequestDispatcher("admin/asignar-tesis.jsp").forward(request, response);
    }
    
    /**
     * Lista todas las asignaciones
     */
    private void listarAsignaciones(HttpServletRequest request, HttpServletResponse response) 
            throws ServletException, IOException {
        
        List<Asignacion> asignaciones = asignacionDAO.obtenerTodasAsignaciones();
        
        // Para AJAX
        if ("true".equals(request.getParameter("ajax"))) {
            enviarJSONAsignaciones(response, asignaciones);
            return;
        }
        
        request.setAttribute("asignaciones", asignaciones);
        request.getRequestDispatcher("admin/listar-asignaciones.jsp").forward(request, response);
    }
    
    /**
     * Obtiene una asignación por su ID
     */
    private void obtenerAsignacionPorId(HttpServletRequest request, HttpServletResponse response) 
            throws ServletException, IOException {
        
        int id = Integer.parseInt(request.getParameter("id"));
        Asignacion asignacion = asignacionDAO.obtenerAsignacionPorId(id);
        
        if (asignacion != null) {
            // Para AJAX
            if ("true".equals(request.getParameter("ajax"))) {
                enviarJSONAsignacion(response, asignacion);
                return;
            }
            
            request.setAttribute("asignacion", asignacion);
        }
        
        request.getRequestDispatcher("admin/detalle-asignacion.jsp").forward(request, response);
    }
    
    /**
     * Obtiene las asignaciones de un docente específico
     */
    private void obtenerAsignacionesPorDocente(HttpServletRequest request, HttpServletResponse response) 
            throws ServletException, IOException {
        
        int docenteId = Integer.parseInt(request.getParameter("docente_id"));
        List<Asignacion> asignaciones = asignacionDAO.obtenerAsignacionesPorDocente(docenteId);
        
        // Para AJAX
        if ("true".equals(request.getParameter("ajax"))) {
            enviarJSONAsignaciones(response, asignaciones);
            return;
        }
        
        request.setAttribute("asignaciones", asignaciones);
        request.getRequestDispatcher("docente/mis-asignaciones.jsp").forward(request, response);
    }
    
    /**
     * Obtiene las asignaciones de una tesis específica
     */
    private void obtenerAsignacionesPorTesis(HttpServletRequest request, HttpServletResponse response) 
            throws ServletException, IOException {
        
        int tesisId = Integer.parseInt(request.getParameter("tesis_id"));
        List<Asignacion> asignaciones = asignacionDAO.obtenerAsignacionesPorTesis(tesisId);
        
        // Para AJAX
        if ("true".equals(request.getParameter("ajax"))) {
            enviarJSONAsignaciones(response, asignaciones);
            return;
        }
        
        request.setAttribute("asignaciones", asignaciones);
        request.getRequestDispatcher("admin/asignaciones-tesis.jsp").forward(request, response);
    }
    
    /**
     * Asigna una tesis a un docente como JURADO (método existente)
     */
    private void asignarTesis(HttpServletRequest request, HttpServletResponse response) 
            throws ServletException, IOException {
        
        request.setCharacterEncoding("UTF-8");
        
        try {
            // Obtener parámetros
            int tesisId = Integer.parseInt(request.getParameter("tesis_id"));
            int docenteId = Integer.parseInt(request.getParameter("docente_id"));
            String fechaLimiteStr = request.getParameter("fecha_limite");
            String comentariosAdmin = request.getParameter("comentarios_admin");
            
            // Obtener información de la tesis
            Tesis tesis = tesisDAO.obtenerTesisPorId(tesisId);
            if (tesis == null) {
                request.setAttribute("error", "Tesis no encontrada");
                request.getRequestDispatcher("admin/asignar-tesis.jsp").forward(request, response);
                return;
            }
            
            // Validar fecha
            SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd");
            Date fechaLimite = sdf.parse(fechaLimiteStr);
            Date hoy = new Date();
            
            if (fechaLimite.before(hoy)) {
                request.setAttribute("error", "La fecha límite no puede ser anterior a hoy");
                request.getRequestDispatcher("admin/asignar-tesis.jsp").forward(request, response);
                return;
            }
            
            // Verificar disponibilidad del docente
            Docente docente = usuarioDAO.obtenerDocentePorId(docenteId);
            if (docente == null || !docente.isActivo()) {
                request.setAttribute("error", "El docente no está disponible");
                request.getRequestDispatcher("admin/asignar-tesis.jsp").forward(request, response);
                return;
            }
            
            // Verificar que el docente tenga disponibilidad
            if (!usuarioDAO.tieneDisponibilidadDocente(docenteId)) {
                request.setAttribute("error", "El docente no tiene disponibilidad para más tesis");
                request.getRequestDispatcher("admin/asignar-tesis.jsp").forward(request, response);
                return;
            }
            
            // Crear asignación
            Asignacion asignacion = new Asignacion();
            asignacion.setIdTesis(tesisId);
            asignacion.setIdDocente(docenteId);
            asignacion.setIdEstudiante(tesis.getEstudianteId());
            asignacion.setFechaLimite(fechaLimite);
            asignacion.setEstado("ASIGNADA");
            asignacion.setComentariosAdmin(comentariosAdmin);
            // Establecer rol como JURADO (para jurado de tesis)
            asignacion.setRol("JURADO");
            
            // Guardar asignación
            int asignacionId = asignacionDAO.crearAsignacion(asignacion);
            
            if (asignacionId > 0) {
                // Actualizar estado de la tesis
                tesisDAO.actualizarEstado(tesisId, "EN_REVISION");
                
                // Incrementar el contador de tesis asignadas al docente
                usuarioDAO.incrementarTesisAsignadas(docenteId);
                
                // Registrar actividad
                registrarActividad(request, "ASIGNACION_TESIS", 
                    "Tesis " + tesisId + " asignada al docente " + docenteId + " como JURADO");
                
                // Redirigir con mensaje de éxito
                HttpSession session = request.getSession();
                session.setAttribute("mensaje", "Tesis asignada exitosamente como JURADO");
                session.setAttribute("tipoMensaje", "success");
                
                response.sendRedirect("AsignacionController?action=listarAsignaciones");
            } else {
                request.setAttribute("error", "Error al asignar tesis");
                request.getRequestDispatcher("admin/asignar-tesis.jsp").forward(request, response);
            }
            
        } catch (Exception e) {
            e.printStackTrace();
            request.setAttribute("error", "Error al asignar tesis: " + e.getMessage());
            request.getRequestDispatcher("admin/asignar-tesis.jsp").forward(request, response);
        }
    }
    
    /**
     * Asigna una asesoría a un docente (NUEVO MÉTODO PARA ASESORÍAS)
     */
    private void asignarAsesoria(HttpServletRequest request, HttpServletResponse response) 
            throws ServletException, IOException {
        
        request.setCharacterEncoding("UTF-8");
        
        try {
            // Obtener parámetros
            int tesisId = Integer.parseInt(request.getParameter("tesis_id"));
            int docenteId = Integer.parseInt(request.getParameter("docente_id"));
            String fechaLimiteStr = request.getParameter("fecha_limite");
            String observaciones = request.getParameter("observaciones");
            String rol = request.getParameter("rol"); // Puede ser "ASESOR" o "JURADO"
            
            // Obtener información de la tesis
            Tesis tesis = tesisDAO.obtenerTesisPorId(tesisId);
            if (tesis == null) {
                request.setAttribute("error", "Tesis no encontrada");
                request.getRequestDispatcher("admin/asignar-asesoria.jsp").forward(request, response);
                return;
            }
            
            // Validar fecha
            SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd");
            Date fechaLimite = null;
            if (fechaLimiteStr != null && !fechaLimiteStr.isEmpty()) {
                fechaLimite = sdf.parse(fechaLimiteStr);
                Date hoy = new Date();
                
                if (fechaLimite.before(hoy)) {
                    request.setAttribute("error", "La fecha límite no puede ser anterior a hoy");
                    request.getRequestDispatcher("admin/asignar-asesoria.jsp").forward(request, response);
                    return;
                }
            }
            
            // Verificar disponibilidad del docente
            Docente docente = usuarioDAO.obtenerDocentePorId(docenteId);
            if (docente == null || !docente.isActivo()) {
                request.setAttribute("error", "El docente no está disponible");
                request.getRequestDispatcher("admin/asignar-asesoria.jsp").forward(request, response);
                return;
            }
            
            // Crear asignación
            Asignacion asignacion = new Asignacion();
            asignacion.setIdTesis(tesisId);
            asignacion.setIdDocente(docenteId);
            asignacion.setIdEstudiante(tesis.getEstudianteId());
            asignacion.setFechaLimite(fechaLimite);
            asignacion.setEstado("ASIGNADA");
            asignacion.setObservaciones(observaciones);
            asignacion.setRol(rol != null ? rol : "ASESOR");
            
            // Guardar asignación
            int asignacionId = asignacionDAO.crearAsignacion(asignacion);
            
            if (asignacionId > 0) {
                // Si es asesor, no cambiamos el estado de la tesis
                if ("ASESOR".equals(rol)) {
                    // Solo registrar la asignación
                    registrarActividad(request, "ASIGNACION_ASESORIA", 
                        "Asesoría asignada para tesis " + tesisId + " al docente " + docenteId);
                } else {
                    // Si es jurado, actualizar estado de la tesis
                    tesisDAO.actualizarEstado(tesisId, "EN_REVISION");
                    registrarActividad(request, "ASIGNACION_JURADO", 
                        "Jurado asignado para tesis " + tesisId + " al docente " + docenteId);
                }
                
                // Redirigir con mensaje de éxito
                HttpSession session = request.getSession();
                session.setAttribute("mensaje", "Asignación creada exitosamente como " + 
                    (rol != null ? rol : "ASESOR"));
                session.setAttribute("tipoMensaje", "success");
                
                response.sendRedirect("AsignacionController?action=listarAsignaciones");
            } else {
                request.setAttribute("error", "Error al crear asignación");
                request.getRequestDispatcher("admin/asignar-asesoria.jsp").forward(request, response);
            }
            
        } catch (Exception e) {
            e.printStackTrace();
            request.setAttribute("error", "Error al asignar: " + e.getMessage());
            request.getRequestDispatcher("admin/asignar-asesoria.jsp").forward(request, response);
        }
    }
    
    /**
     * Actualiza una asignación existente
     */
    private void actualizarAsignacion(HttpServletRequest request, HttpServletResponse response) 
            throws ServletException, IOException {
        
        request.setCharacterEncoding("UTF-8");
        
        try {
            int id = Integer.parseInt(request.getParameter("id"));
            String fechaLimiteStr = request.getParameter("fecha_limite");
            String estado = request.getParameter("estado");
            String observaciones = request.getParameter("observaciones");
            String feedback = request.getParameter("feedback");
            String calificacionStr = request.getParameter("calificacion");
            
            // Obtener asignación existente
            Asignacion asignacion = asignacionDAO.obtenerAsignacionPorId(id);
            if (asignacion == null) {
                request.setAttribute("error", "Asignación no encontrada");
                request.getRequestDispatcher("admin/listar-asignaciones.jsp").forward(request, response);
                return;
            }
            
            // Obtener estado anterior
            String estadoAnterior = asignacion.getEstado();
            
            // Actualizar campos
            SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd");
            Date fechaLimite = null;
            if (fechaLimiteStr != null && !fechaLimiteStr.isEmpty()) {
                fechaLimite = sdf.parse(fechaLimiteStr);
            }
            
            asignacion.setFechaLimite(fechaLimite);
            asignacion.setEstado(estado);
            asignacion.setObservaciones(observaciones);
            asignacion.setFeedback(feedback);
            
            if (calificacionStr != null && !calificacionStr.isEmpty()) {
                BigDecimal calificacion = new BigDecimal(calificacionStr);
                asignacion.setCalificacion(calificacion);
            }
            
            // Si se marca como completada, establecer fecha de completado
            if ("COMPLETADA".equals(estado) && !"COMPLETADA".equals(estadoAnterior)) {
                asignacion.setFechaCompletada(new Date());
            }
            
            // Guardar cambios
            boolean actualizado = asignacionDAO.actualizarAsignacion(asignacion);
            
            if (actualizado) {
                // Si la asignación se completó y es de tipo JURADO, actualizar estado de la tesis
                if ("COMPLETADA".equals(estado) && !"COMPLETADA".equals(estadoAnterior) 
                    && "JURADO".equals(asignacion.getRol())) {
                    tesisDAO.actualizarEstado(asignacion.getIdTesis(), "EVALUADA");
                }
                
                // Registrar actividad
                registrarActividad(request, "ACTUALIZACION_ASIGNACION", 
                    "Asignación " + id + " actualizada");
                
                HttpSession session = request.getSession();
                session.setAttribute("mensaje", "Asignación actualizada exitosamente");
                session.setAttribute("tipoMensaje", "success");
                
                response.sendRedirect("AsignacionController?action=listarAsignaciones");
            } else {
                request.setAttribute("error", "Error al actualizar asignación");
                request.getRequestDispatcher("admin/editar-asignacion.jsp?id=" + id).forward(request, response);
            }
            
        } catch (Exception e) {
            e.printStackTrace();
            request.setAttribute("error", "Error al actualizar asignación: " + e.getMessage());
            request.getRequestDispatcher("admin/editar-asignacion.jsp").forward(request, response);
        }
    }
    
    /**
     * Marca una asignación como completada
     */
    private void completarAsignacion(HttpServletRequest request, HttpServletResponse response) 
            throws ServletException, IOException {
        
        try {
            int id = Integer.parseInt(request.getParameter("id"));
            
            Asignacion asignacion = asignacionDAO.obtenerAsignacionPorId(id);
            if (asignacion != null) {
                // Solo completar si no está ya completada
                if (!"COMPLETADA".equals(asignacion.getEstado())) {
                    asignacion.setEstado("COMPLETADA");
                    asignacion.setFechaCompletada(new Date());
                    boolean actualizado = asignacionDAO.actualizarAsignacion(asignacion);
                    
                    if (actualizado) {
                        // Actualizar estado de la tesis si es JURADO
                        if ("JURADO".equals(asignacion.getRol())) {
                            tesisDAO.actualizarEstado(asignacion.getIdTesis(), "EVALUADA");
                        }
                        
                        registrarActividad(request, "COMPLETAR_ASIGNACION", 
                            "Asignación " + id + " completada");
                        
                        HttpSession session = request.getSession();
                        session.setAttribute("mensaje", "Asignación marcada como completada");
                        session.setAttribute("tipoMensaje", "success");
                    }
                } else {
                    HttpSession session = request.getSession();
                    session.setAttribute("mensaje", "La asignación ya está completada");
                    session.setAttribute("tipoMensaje", "info");
                }
            }
            
            response.sendRedirect("AsignacionController?action=listarAsignaciones");
            
        } catch (Exception e) {
            e.printStackTrace();
            request.setAttribute("error", "Error al completar asignación: " + e.getMessage());
            request.getRequestDispatcher("admin/listar-asignaciones.jsp").forward(request, response);
        }
    }
    
    /**
     * Completa una asignación con calificación y feedback (NUEVO MÉTODO)
     */
    private void completarAsignacionConCalificacion(HttpServletRequest request, HttpServletResponse response) 
            throws ServletException, IOException {
        
        request.setCharacterEncoding("UTF-8");
        
        try {
            int id = Integer.parseInt(request.getParameter("id"));
            double calificacion = Double.parseDouble(request.getParameter("calificacion"));
            String feedback = request.getParameter("feedback");
            
            // Completar la asignación con calificación
            boolean completado = asignacionDAO.completarAsignacion(id, calificacion, feedback);
            
            if (completado) {
                // Obtener la asignación para verificar el rol
                Asignacion asignacion = asignacionDAO.obtenerAsignacionPorId(id);
                
                // Actualizar estado de la tesis si es JURADO
                if (asignacion != null && "JURADO".equals(asignacion.getRol())) {
                    tesisDAO.actualizarEstado(asignacion.getIdTesis(), "EVALUADA");
                }
                
                registrarActividad(request, "COMPLETAR_CON_CALIFICACION", 
                    "Asignación " + id + " completada con calificación: " + calificacion);
                
                HttpSession session = request.getSession();
                session.setAttribute("mensaje", "Asignación completada con calificación: " + calificacion);
                session.setAttribute("tipoMensaje", "success");
            } else {
                HttpSession session = request.getSession();
                session.setAttribute("mensaje", "Error al completar asignación");
                session.setAttribute("tipoMensaje", "error");
            }
            
            response.sendRedirect("AsignacionController?action=listarAsignaciones");
            
        } catch (Exception e) {
            e.printStackTrace();
            request.setAttribute("error", "Error al completar asignación: " + e.getMessage());
            request.getRequestDispatcher("admin/listar-asignaciones.jsp").forward(request, response);
        }
    }
    
    /**
     * Cancela una asignación
     */
    private void cancelarAsignacion(HttpServletRequest request, HttpServletResponse response) 
            throws ServletException, IOException {
        
        try {
            int id = Integer.parseInt(request.getParameter("id"));
            
            Asignacion asignacion = asignacionDAO.obtenerAsignacionPorId(id);
            if (asignacion != null) {
                // Solo cancelar si no está ya cancelada o completada
                if (!"CANCELADA".equals(asignacion.getEstado()) && !"COMPLETADA".equals(asignacion.getEstado())) {
                    asignacion.setEstado("CANCELADA");
                    boolean actualizado = asignacionDAO.actualizarAsignacion(asignacion);
                    
                    if (actualizado) {
                        // Si es JURADO y se cancela, actualizar estado de la tesis a PENDIENTE para reasignación
                        if ("JURADO".equals(asignacion.getRol())) {
                            tesisDAO.actualizarEstado(asignacion.getIdTesis(), "PENDIENTE");
                        }
                        
                        registrarActividad(request, "CANCELAR_ASIGNACION", 
                            "Asignación " + id + " cancelada");
                        
                        HttpSession session = request.getSession();
                        session.setAttribute("mensaje", "Asignación cancelada");
                        session.setAttribute("tipoMensaje", "warning");
                    }
                } else {
                    HttpSession session = request.getSession();
                    session.setAttribute("mensaje", "La asignación ya está " + asignacion.getEstado().toLowerCase());
                    session.setAttribute("tipoMensaje", "info");
                }
            }
            
            response.sendRedirect("AsignacionController?action=listarAsignaciones");
            
        } catch (Exception e) {
            e.printStackTrace();
            request.setAttribute("error", "Error al cancelar asignación: " + e.getMessage());
            request.getRequestDispatcher("admin/listar-asignaciones.jsp").forward(request, response);
        }
    }
    
    /**
     * Elimina una asignación
     */
    private void eliminarAsignacion(HttpServletRequest request, HttpServletResponse response) 
            throws ServletException, IOException {
        
        try {
            int id = Integer.parseInt(request.getParameter("id"));
            
            // Obtener asignación primero para registrar actividades y ajustar contadores
            Asignacion asignacion = asignacionDAO.obtenerAsignacionPorId(id);
            
            if (asignacion != null) {
                // Si la asignación estaba activa y es JURADO, restaurar estado de la tesis
                if ("ASIGNADA".equals(asignacion.getEstado()) && "JURADO".equals(asignacion.getRol())) {
                    tesisDAO.actualizarEstado(asignacion.getIdTesis(), "PENDIENTE");
                }
                
                // Registrar actividad antes de eliminar
                registrarActividad(request, "ELIMINAR_ASIGNACION", 
                    "Asignación " + id + " eliminada");
            }
            
            boolean eliminado = asignacionDAO.eliminarAsignacion(id);
            
            if (eliminado) {                
                HttpSession session = request.getSession();
                session.setAttribute("mensaje", "Asignación eliminada exitosamente");
                session.setAttribute("tipoMensaje", "success");
            } else {
                HttpSession session = request.getSession();
                session.setAttribute("mensaje", "Error al eliminar asignación");
                session.setAttribute("tipoMensaje", "error");
            }
            
            response.sendRedirect("AsignacionController?action=listarAsignaciones");
            
        } catch (Exception e) {
            e.printStackTrace();
            request.setAttribute("error", "Error al eliminar asignación: " + e.getMessage());
            request.getRequestDispatcher("admin/listar-asignaciones.jsp").forward(request, response);
        }
    }
    
    /**
     * Obtiene estadísticas de asignaciones
     */
    private void obtenerEstadisticasAsignaciones(HttpServletRequest request, HttpServletResponse response) 
            throws ServletException, IOException {
        
        List<Asignacion> asignaciones = asignacionDAO.obtenerTodasAsignaciones();
        
        // Calcular estadísticas básicas
        int total = asignaciones.size();
        int completadas = 0;
        int asignadas = 0;
        int enRevision = 0;
        int enProgreso = 0;
        int canceladas = 0;
        int evaluadas = 0;
        int atrasadas = 0;
        int jurados = 0;
        int asesores = 0;
        
        for (Asignacion a : asignaciones) {
            String estado = a.getEstado();
            String rol = a.getRol();
            
            // Contar por rol
            if ("JURADO".equals(rol)) {
                jurados++;
            } else if ("ASESOR".equals(rol)) {
                asesores++;
            }
            
            // Contar por estado
            switch (estado) {
                case "COMPLETADA":
                    completadas++;
                    break;
                case "ASIGNADA":
                    asignadas++;
                    break;
                case "EN_REVISION":
                    enRevision++;
                    break;
                case "EN_PROGRESO":
                    enProgreso++;
                    break;
                case "CANCELADA":
                    canceladas++;
                    break;
                case "EVALUADA":
                    evaluadas++;
                    break;
            }
            
            // Verificar si está atrasada
            if (("ASIGNADA".equals(estado) || "EN_PROGRESO".equals(estado) || "EN_REVISION".equals(estado)) 
                && a.getFechaLimite() != null 
                && a.getFechaLimite().before(new Date())) {
                atrasadas++;
            }
        }
        
        // Calcular porcentajes
        double porcentajeCompletadas = total > 0 ? (completadas * 100.0) / total : 0;
        double porcentajeAtrasadas = total > 0 ? (atrasadas * 100.0) / total : 0;
        
        // Para AJAX
        if ("true".equals(request.getParameter("ajax"))) {
            response.setContentType("application/json");
            response.setCharacterEncoding("UTF-8");
            PrintWriter out = response.getWriter();
            
            StringBuilder json = new StringBuilder("{");
            json.append("\"total\":").append(total).append(",");
            json.append("\"completadas\":").append(completadas).append(",");
            json.append("\"asignadas\":").append(asignadas).append(",");
            json.append("\"en_revision\":").append(enRevision).append(",");
            json.append("\"en_progreso\":").append(enProgreso).append(",");
            json.append("\"canceladas\":").append(canceladas).append(",");
            json.append("\"evaluadas\":").append(evaluadas).append(",");
            json.append("\"atrasadas\":").append(atrasadas).append(",");
            json.append("\"jurados\":").append(jurados).append(",");
            json.append("\"asesores\":").append(asesores).append(",");
            json.append("\"porcentaje_completadas\":").append(String.format("%.2f", porcentajeCompletadas)).append(",");
            json.append("\"porcentaje_atrasadas\":").append(String.format("%.2f", porcentajeAtrasadas)).append(",");
            json.append("\"eficiencia\":").append(asignacionDAO.calcularEficienciaSistema());
            json.append("}");
            
            out.print(json.toString());
            out.flush();
            return;
        }
        
        request.setAttribute("totalAsignaciones", total);
        request.setAttribute("completadas", completadas);
        request.setAttribute("asignadas", asignadas);
        request.setAttribute("enRevision", enRevision);
        request.setAttribute("enProgreso", enProgreso);
        request.setAttribute("canceladas", canceladas);
        request.setAttribute("evaluadas", evaluadas);
        request.setAttribute("atrasadas", atrasadas);
        request.setAttribute("jurados", jurados);
        request.setAttribute("asesores", asesores);
        request.setAttribute("porcentajeCompletadas", String.format("%.2f", porcentajeCompletadas));
        request.setAttribute("porcentajeAtrasadas", String.format("%.2f", porcentajeAtrasadas));
        request.getRequestDispatcher("admin/estadisticas.jsp").forward(request, response);
    }
    
    /**
     * Obtiene la eficiencia del sistema
     */
    private void obtenerEficienciaSistema(HttpServletRequest request, HttpServletResponse response) 
            throws ServletException, IOException {
        
        int eficiencia = asignacionDAO.calcularEficienciaSistema();
        
        if ("true".equals(request.getParameter("ajax"))) {
            response.setContentType("application/json");
            response.setCharacterEncoding("UTF-8");
            PrintWriter out = response.getWriter();
            out.print("{\"eficiencia\":" + eficiencia + "}");
            out.flush();
            return;
        }
        
        request.setAttribute("eficiencia", eficiencia);
        request.getRequestDispatcher("admin/estadisticas.jsp").forward(request, response);
    }
    
    /**
     * Obtiene estadísticas de asignaciones por docente (NUEVO MÉTODO)
     */
    private void obtenerEstadisticasDocente(HttpServletRequest request, HttpServletResponse response) 
            throws ServletException, IOException {
        
        int docenteId = Integer.parseInt(request.getParameter("docente_id"));
        List<Object[]> estadisticas = asignacionDAO.obtenerEstadisticasPorDocente(docenteId);
        
        if ("true".equals(request.getParameter("ajax"))) {
            response.setContentType("application/json");
            response.setCharacterEncoding("UTF-8");
            PrintWriter out = response.getWriter();
            
            if (!estadisticas.isEmpty()) {
                Object[] stats = estadisticas.get(0);
                StringBuilder json = new StringBuilder("{");
                json.append("\"total\":").append(stats[0]).append(",");
                json.append("\"asignadas\":").append(stats[1]).append(",");
                json.append("\"en_revision\":").append(stats[2]).append(",");
                json.append("\"en_progreso\":").append(stats[3]).append(",");
                json.append("\"completadas\":").append(stats[4]);
                json.append("}");
                out.print(json.toString());
            } else {
                out.print("{\"total\":0,\"asignadas\":0,\"en_revision\":0,\"en_progreso\":0,\"completadas\":0}");
            }
            out.flush();
            return;
        }
        
        if (!estadisticas.isEmpty()) {
            Object[] stats = estadisticas.get(0);
            request.setAttribute("estadisticasDocente", stats);
        }
        request.getRequestDispatcher("docente/estadisticas.jsp").forward(request, response);
    }
    
    // ============= MÉTODOS AUXILIARES =============
    
    /**
     * Envía una asignación en formato JSON
     */
    private void enviarJSONAsignacion(HttpServletResponse response, Asignacion asignacion) 
            throws IOException {
        
        response.setContentType("application/json");
        response.setCharacterEncoding("UTF-8");
        PrintWriter out = response.getWriter();
        
        SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd");
        
        StringBuilder json = new StringBuilder("{");
        json.append("\"id\":").append(asignacion.getId()).append(",");
        json.append("\"tesisId\":").append(asignacion.getIdTesis()).append(",");
        json.append("\"tesisTitulo\":\"").append(escapeJSON(asignacion.getTesisTitulo())).append("\",");
        json.append("\"docenteId\":").append(asignacion.getIdDocente()).append(",");
        json.append("\"docenteNombre\":\"").append(escapeJSON(asignacion.getNombreDocente())).append("\",");
        json.append("\"estudianteId\":").append(asignacion.getIdEstudiante()).append(",");
        json.append("\"estudianteNombre\":\"").append(escapeJSON(asignacion.getNombreEstudiante())).append("\",");
        
        if (asignacion.getFechaAsignacion() != null) {
            json.append("\"fechaAsignacion\":\"").append(sdf.format(asignacion.getFechaAsignacion())).append("\",");
        }
        
        if (asignacion.getFechaLimite() != null) {
            json.append("\"fechaLimite\":\"").append(sdf.format(asignacion.getFechaLimite())).append("\",");
        }
        
        if (asignacion.getFechaCompletada() != null) {
            json.append("\"fechaCompletada\":\"").append(sdf.format(asignacion.getFechaCompletada())).append("\",");
        }
        
        json.append("\"rol\":\"").append(escapeJSON(asignacion.getRol())).append("\",");
        json.append("\"estado\":\"").append(escapeJSON(asignacion.getEstado())).append("\",");
        json.append("\"observaciones\":\"").append(escapeJSON(asignacion.getObservaciones())).append("\",");
        json.append("\"calificacion\":").append(asignacion.getCalificacion() != null ? asignacion.getCalificacion() : "null").append(",");
        json.append("\"feedback\":\"").append(escapeJSON(asignacion.getFeedback())).append("\",");
        json.append("\"comentariosAdmin\":\"").append(escapeJSON(asignacion.getComentariosAdmin())).append("\"");
        json.append("}");
        
        out.print(json.toString());
        out.flush();
    }
    
    /**
     * Envía una lista de asignaciones en formato JSON
     */
    private void enviarJSONAsignaciones(HttpServletResponse response, List<Asignacion> asignaciones) 
            throws IOException {
        
        response.setContentType("application/json");
        response.setCharacterEncoding("UTF-8");
        PrintWriter out = response.getWriter();
        
        StringBuilder json = new StringBuilder("[");
        SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd");
        
        for (int i = 0; i < asignaciones.size(); i++) {
            Asignacion asignacion = asignaciones.get(i);
            
            json.append("{");
            json.append("\"id\":").append(asignacion.getId()).append(",");
            json.append("\"tesisId\":").append(asignacion.getIdTesis()).append(",");
            json.append("\"tesisTitulo\":\"").append(escapeJSON(asignacion.getTesisTitulo())).append("\",");
            json.append("\"docenteNombre\":\"").append(escapeJSON(asignacion.getNombreDocente())).append("\",");
            json.append("\"estudianteNombre\":\"").append(escapeJSON(asignacion.getNombreEstudiante())).append("\",");
            
            if (asignacion.getFechaAsignacion() != null) {
                json.append("\"fechaAsignacion\":\"").append(sdf.format(asignacion.getFechaAsignacion())).append("\",");
            }
            
            if (asignacion.getFechaLimite() != null) {
                json.append("\"fechaLimite\":\"").append(sdf.format(asignacion.getFechaLimite())).append("\",");
            }
            
            json.append("\"rol\":\"").append(escapeJSON(asignacion.getRol())).append("\",");
            json.append("\"estado\":\"").append(escapeJSON(asignacion.getEstado())).append("\",");
            json.append("\"calificacion\":").append(asignacion.getCalificacion() != null ? asignacion.getCalificacion() : "null");
            json.append("}");
            
            if (i < asignaciones.size() - 1) {
                json.append(",");
            }
        }
        
        json.append("]");
        out.print(json.toString());
        out.flush();
    }
    
    /**
     * Envía una lista de tesis en formato JSON
     */
    private void enviarJSONTesis(HttpServletResponse response, List<Tesis> tesisList) 
            throws IOException {
        
        response.setContentType("application/json");
        response.setCharacterEncoding("UTF-8");
        PrintWriter out = response.getWriter();
        
        StringBuilder json = new StringBuilder("[");
        
        for (int i = 0; i < tesisList.size(); i++) {
            Tesis tesis = tesisList.get(i);
            
            json.append("{");
            json.append("\"id\":").append(tesis.getId()).append(",");
            json.append("\"titulo\":\"").append(escapeJSON(tesis.getTitulo())).append("\",");
            json.append("\"estudianteId\":").append(tesis.getEstudianteId()).append(",");
            json.append("\"estudianteNombre\":\"").append(escapeJSON(tesis.getEstudianteNombre())).append("\",");
            json.append("\"carreraNombre\":\"").append(escapeJSON(tesis.getCarreraNombre())).append("\",");
            json.append("\"fechaCreacion\":\"").append(tesis.getFechaCreacion()).append("\",");
            json.append("\"estado\":\"").append(escapeJSON(tesis.getEstado())).append("\"");
            json.append("}");
            
            if (i < tesisList.size() - 1) {
                json.append(",");
            }
        }
        
        json.append("]");
        out.print(json.toString());
        out.flush();
    }
    
    /**
     * Escapa caracteres especiales para JSON
     */
    private String escapeJSON(String input) {
        if (input == null) return "";
        return input.replace("\"", "\\\"")
                   .replace("\\", "\\\\")
                   .replace("\b", "\\b")
                   .replace("\f", "\\f")
                   .replace("\n", "\\n")
                   .replace("\r", "\\r")
                   .replace("\t", "\\t");
    }
    
    /**
     * Registra una actividad en el sistema
     */
    private void registrarActividad(HttpServletRequest request, String tipoAccion, String descripcion) {
        HttpSession session = request.getSession(false);
        if (session != null) {
            Integer usuarioId = (Integer) session.getAttribute("usuario_id");
            String usuarioNombre = (String) session.getAttribute("usuario_nombre");
            if (usuarioId != null) {
                System.out.println("📝 Actividad [" + tipoAccion + "]: " + descripcion + 
                                 " (Usuario: " + usuarioNombre + ", ID: " + usuarioId + ")");
            }
        }
    }
}