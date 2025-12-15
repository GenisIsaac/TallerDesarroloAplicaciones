package Controlador;

import DAO.*;
import Modelos.*;
import jakarta.servlet.*;
import jakarta.servlet.http.*;
import jakarta.servlet.annotation.*;
import java.io.*;
import java.util.*;

@WebServlet("/EstudianteController")
public class EstudianteController extends HttpServlet {
    
    private UsuarioDAO usuarioDAO;
    private TesisDAO tesisDAO;
    private AsignacionDAO asignacionDAO;
    private MensajeDAO mensajeDAO;
    
    @Override
    public void init() throws ServletException {
        System.out.println("=== INICIALIZANDO ESTUDIANTECONTROLLER ===");
        try {
            usuarioDAO = new UsuarioDAO();
            tesisDAO = new TesisDAO();
            asignacionDAO = new AsignacionDAO();
            mensajeDAO = new MensajeDAO();
            System.out.println("✅ DAOs inicializados correctamente");
        } catch (Exception e) {
            System.err.println("❌ ERROR al inicializar DAOs: " + e.getMessage());
            throw new ServletException("Error al inicializar DAOs", e);
        }
    }
    
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) 
            throws ServletException, IOException {
        
        System.out.println("\n=== GET /EstudianteController ===");
        
        // Verificar sesión
        HttpSession session = request.getSession(false);
        if (session == null || session.getAttribute("usuario_id") == null) {
            System.out.println("❌ Sesión no encontrada, redirigiendo a index.jsp");
            response.sendRedirect("index.jsp");
            return;
        }
        
        Integer usuarioId = (Integer) session.getAttribute("usuario_id");
        String usuarioTipo = (String) session.getAttribute("usuario_tipo");
        
        System.out.println("📋 Datos de sesión:");
        System.out.println("  - usuario_id: " + usuarioId);
        System.out.println("  - usuario_tipo: " + usuarioTipo);
        
        // Verificar que sea estudiante
        if (!"ESTUDIANTE".equals(usuarioTipo)) {
            System.out.println("❌ No es estudiante, redirigiendo a index.jsp");
            response.sendRedirect("index.jsp");
            return;
        }
        
        try {
            // 1. Obtener datos del estudiante
            System.out.println("\n🔍 Obteniendo datos del estudiante...");
            Usuario estudiante = usuarioDAO.obtenerUsuarioPorId(usuarioId);
            
            if (estudiante == null) {
                System.out.println("❌ Estudiante no encontrado en BD");
                response.sendRedirect("index.jsp?error=Usuario no encontrado");
                return;
            }
            
            System.out.println("✅ Estudiante encontrado: " + estudiante.getNombre() + " " + estudiante.getApellido());
            System.out.println("   ID: " + estudiante.getId());
            System.out.println("   Email: " + estudiante.getEmail());
            
            // 2. Obtener tesis del estudiante
            System.out.println("\n🔍 Buscando tesis del estudiante...");
            Tesis tesis = null;
            try {
                List<Tesis> listaTesis = tesisDAO.obtenerTesisPorEstudiante(estudiante.getId());
                if (listaTesis != null && !listaTesis.isEmpty()) {
                    tesis = listaTesis.get(0);
                    System.out.println("✅ Tesis encontrada:");
                    System.out.println("   ID Tesis: " + tesis.getId());
                    System.out.println("   Título: " + tesis.getTitulo());
                    System.out.println("   Estado: " + tesis.getEstado());
                } else {
                    System.out.println("⚠️ No se encontró tesis para el estudiante");
                }
            } catch (Exception e) {
                System.err.println("❌ Error al obtener tesis: " + e.getMessage());
            }
            
            // 3. Obtener asignaciones (si hay tesis)
            List<Asignacion> asignaciones = new ArrayList<>();
            Docente docenteAsignado = null;
            
            if (tesis != null) {
                System.out.println("\n🔍 Obteniendo asignaciones de la tesis...");
                asignaciones = asignacionDAO.obtenerAsignacionesPorTesis(tesis.getId());
                System.out.println("✅ Asignaciones encontradas: " + asignaciones.size());
                
                // Buscar docente asignado (asesor o jurado)
                for (Asignacion asignacion : asignaciones) {
                    if (asignacion.getIdDocente() > 0 && 
                        ("ASESOR".equals(asignacion.getRol()) || "JURADO".equals(asignacion.getRol()))) {
                        docenteAsignado = usuarioDAO.obtenerDocentePorId(asignacion.getIdDocente());
                        if (docenteAsignado != null) {
                            System.out.println("✅ Docente asignado encontrado:");
                            System.out.println("   Nombre: " + docenteAsignado.getNombre());
                            System.out.println("   Rol: " + asignacion.getRol());
                            break;
                        }
                    }
                }
            }
            
            // 4. Obtener mensajes
            System.out.println("\n🔍 Obteniendo mensajes del estudiante...");
            List<Mensaje> mensajes = mensajeDAO.obtenerMensajesPorEstudiante(estudiante.getId());
            if (mensajes == null) mensajes = new ArrayList<>();
            System.out.println("✅ Mensajes encontrados: " + mensajes.size());
            
            // Contar mensajes no leídos
            int mensajesNoLeidos = 0;
            for (Mensaje mensaje : mensajes) {
                if (mensaje.getIdEstudiante() == estudiante.getId() && 
                    "no_leido".equalsIgnoreCase(mensaje.getEstado())) {
                    mensajesNoLeidos++;
                }
            }
            System.out.println("📬 Mensajes no leídos: " + mensajesNoLeidos);
            
            // 5. Obtener mensajes de éxito/error de la sesión
            String successMessage = (String) session.getAttribute("successMessage");
            String errorMessage = (String) session.getAttribute("errorMessage");
            
            if (successMessage != null) {
                System.out.println("📢 Success message from session: " + successMessage);
                request.setAttribute("successMessage", successMessage);
                session.removeAttribute("successMessage");
            }
            
            if (errorMessage != null) {
                System.out.println("📢 Error message from session: " + errorMessage);
                request.setAttribute("errorMessage", errorMessage);
                session.removeAttribute("errorMessage");
            }
            
            // 6. Colocar datos en el request
            request.setAttribute("estudiante", estudiante);
            request.setAttribute("tesis", tesis);
            request.setAttribute("asignaciones", asignaciones);
            request.setAttribute("docenteAsignado", docenteAsignado);
            request.setAttribute("mensajes", mensajes);
            request.setAttribute("mensajesNoLeidos", mensajesNoLeidos);
            
            // 7. Redirigir al JSP
            System.out.println("🚀 Redirigiendo a estudiante.jsp con todos los datos");
            RequestDispatcher dispatcher = request.getRequestDispatcher("estudiante.jsp");
            dispatcher.forward(request, response);
            
        } catch (Exception e) {
            System.err.println("❌ ERROR en doGet: " + e.getMessage());
            e.printStackTrace();
            request.setAttribute("error", "Error al cargar datos: " + e.getMessage());
            request.getRequestDispatcher("error.jsp").forward(request, response);
        }
    }
    
    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) 
            throws ServletException, IOException {
        
        System.out.println("\n=== POST /EstudianteController ===");
        
        // Configurar encoding
        request.setCharacterEncoding("UTF-8");
        response.setContentType("text/html;charset=UTF-8");
        
        String action = request.getParameter("action");
        HttpSession session = request.getSession(false);
        
        if (session == null || session.getAttribute("usuario_id") == null) {
            System.out.println("❌ Sesión no válida en POST");
            response.sendRedirect("index.jsp");
            return;
        }
        
        Integer usuarioId = (Integer) session.getAttribute("usuario_id");
        System.out.println("📋 Acción POST: " + action);
        System.out.println("📋 usuario_id: " + usuarioId);
        
        try {
            if ("enviarMensaje".equals(action)) {
                enviarMensaje(request, response, usuarioId);
            } else if ("subirTesis".equals(action)) {
                subirTesis(request, response, usuarioId);
            } else if ("actualizarTesis".equals(action)) {
                actualizarTesis(request, response, usuarioId);
            } else if ("marcarMensajeLeido".equals(action)) {
                marcarMensajeLeido(request, response, usuarioId);
            } else {
                System.out.println("⚠️ Acción no reconocida: " + action);
                session.setAttribute("errorMessage", "Acción no reconocida");
                response.sendRedirect("EstudianteController");
            }
        } catch (Exception e) {
            System.err.println("❌ ERROR en doPost: " + e.getMessage());
            e.printStackTrace();
            if (session != null) {
                session.setAttribute("errorMessage", "Error: " + e.getMessage());
            }
            response.sendRedirect("EstudianteController");
        }
    }
    
    private void enviarMensaje(HttpServletRequest request, HttpServletResponse response, int estudianteId) 
            throws ServletException, IOException {
        
        System.out.println("\n📤 Procesando envío de mensaje...");
        
        HttpSession session = request.getSession(false);
        if (session == null) {
            response.sendRedirect("index.jsp");
            return;
        }
        
        try {
            // Obtener parámetros
            String idAsignacionStr = request.getParameter("idAsignacion");
            String idDocenteStr = request.getParameter("idDocente");
            String contenido = request.getParameter("contenido");
            String asunto = request.getParameter("asunto");
            
            System.out.println("📋 Parámetros recibidos:");
            System.out.println("  - idAsignacion: " + idAsignacionStr);
            System.out.println("  - idDocente: " + idDocenteStr);
            System.out.println("  - contenido: " + contenido);
            System.out.println("  - asunto: " + asunto);
            
            // Validar parámetros requeridos
            if (idAsignacionStr == null || idDocenteStr == null || contenido == null || contenido.trim().isEmpty()) {
                System.out.println("❌ Parámetros inválidos");
                session.setAttribute("errorMessage", "Faltan parámetros requeridos");
                response.sendRedirect("EstudianteController");
                return;
            }
            
            int idAsignacion = Integer.parseInt(idAsignacionStr);
            int idDocente = Integer.parseInt(idDocenteStr);
            contenido = contenido.trim();
            
            if (asunto == null || asunto.trim().isEmpty()) {
                asunto = "Consulta sobre tesis";
            }
            
            // Crear objeto mensaje
            Mensaje mensaje = new Mensaje();
            mensaje.setIdAsignacion(idAsignacion);
            mensaje.setIdEstudiante(estudianteId);
            mensaje.setIdDocente(idDocente);
            mensaje.setAsunto(asunto);
            mensaje.setContenido(contenido);
            mensaje.setTipoMensaje("consulta");
            mensaje.setEstado("no_leido");
            mensaje.setFechaEnvio(new java.util.Date());
            mensaje.setAdjuntos("");
            
            System.out.println("📝 Mensaje creado:");
            System.out.println("  - De estudiante: " + estudianteId);
            System.out.println("  - Para docente: " + idDocente);
            System.out.println("  - Asignación: " + idAsignacion);
            
            // Guardar mensaje en BD
            boolean enviado = mensajeDAO.crearMensaje(mensaje);
            
            if (enviado) {
                System.out.println("✅ Mensaje guardado exitosamente");
                session.setAttribute("successMessage", "Mensaje enviado exitosamente");
            } else {
                System.out.println("❌ Error al guardar mensaje");
                session.setAttribute("errorMessage", "Error al enviar mensaje");
            }
            
            // Redirigir al controlador para mostrar la página actualizada
            response.sendRedirect("EstudianteController");
            
        } catch (NumberFormatException e) {
            System.err.println("❌ Error de formato numérico: " + e.getMessage());
            session.setAttribute("errorMessage", "Error en el formato de los datos");
            response.sendRedirect("EstudianteController");
        } catch (Exception e) {
            System.err.println("❌ Error al enviar mensaje: " + e.getMessage());
            e.printStackTrace();
            session.setAttribute("errorMessage", "Error al enviar mensaje: " + e.getMessage());
            response.sendRedirect("EstudianteController");
        }
    }
    
    private void marcarMensajeLeido(HttpServletRequest request, HttpServletResponse response, int estudianteId) 
            throws ServletException, IOException {
        
        System.out.println("\n📤 Procesando marcado de mensaje como leído...");
        
        HttpSession session = request.getSession(false);
        if (session == null) {
            response.sendRedirect("index.jsp");
            return;
        }
        
        try {
            String idMensajeStr = request.getParameter("idMensaje");
            System.out.println("📋 ID Mensaje a marcar: " + idMensajeStr);
            
            if (idMensajeStr == null || idMensajeStr.trim().isEmpty()) {
                session.setAttribute("errorMessage", "ID de mensaje inválido");
                response.sendRedirect("EstudianteController");
                return;
            }
            
            int idMensaje = Integer.parseInt(idMensajeStr);
            boolean marcado = mensajeDAO.marcarComoLeido(idMensaje);
            
            if (marcado) {
                System.out.println("✅ Mensaje marcado como leído");
                session.setAttribute("successMessage", "Mensaje marcado como leído");
            } else {
                System.out.println("❌ Error al marcar mensaje");
                session.setAttribute("errorMessage", "Error al marcar mensaje");
            }
            
            response.sendRedirect("EstudianteController");
            
        } catch (Exception e) {
            System.err.println("❌ Error: " + e.getMessage());
            session.setAttribute("errorMessage", "Error: " + e.getMessage());
            response.sendRedirect("EstudianteController");
        }
    }
    
    private void subirTesis(HttpServletRequest request, HttpServletResponse response, int estudianteId) 
            throws ServletException, IOException {
        // Implementar subida de tesis
        HttpSession session = request.getSession(false);
        session.setAttribute("successMessage", "Función de subir tesis en desarrollo");
        response.sendRedirect("EstudianteController");
    }
    
    private void actualizarTesis(HttpServletRequest request, HttpServletResponse response, int estudianteId) 
            throws ServletException, IOException {
        // Implementar actualización de tesis
        HttpSession session = request.getSession(false);
        session.setAttribute("successMessage", "Función de actualizar tesis en desarrollo");
        response.sendRedirect("EstudianteController");
    }
}