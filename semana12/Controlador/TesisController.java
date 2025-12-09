package Controlador;

import DAO.TesisDAO;
import Modelos.Tesis;
import Modelos.EstadoTesis;
import jakarta.servlet.*;
import jakarta.servlet.http.*;
import jakarta.servlet.annotation.*;
import java.io.*;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Date;
import java.util.List;

@WebServlet("/TesisController")
@MultipartConfig(
    fileSizeThreshold = 1024 * 1024 * 1,
    maxFileSize = 1024 * 1024 * 50,
    maxRequestSize = 1024 * 1024 * 100
)
public class TesisController extends HttpServlet {
    
    private TesisDAO tesisDAO;
    
    @Override
    public void init() {
        tesisDAO = new TesisDAO();
    }
    
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) 
            throws ServletException, IOException {
        
        String action = request.getParameter("action");
        if (action == null) action = "listar";
        
        try {
            switch (action) {
                case "listar":
                    listarTesis(request, response);
                    break;
                case "obtenerPorId":
                    obtenerTesisPorId(request, response);
                    break;
                case "obtenerPorEstudiante":
                    obtenerTesisPorEstudiante(request, response);
                    break;
                case "obtenerPorDocente":
                    obtenerTesisPorDocente(request, response);
                    break;
                case "obtenerPorEstado":
                    obtenerTesisPorEstado(request, response);
                    break;
                case "estadisticas":
                    obtenerEstadisticasTesis(request, response);
                    break;
                case "descargar":
                    descargarArchivoTesis(request, response);
                    break;
                default:
                    response.sendRedirect("admin/admin-dashboard.jsp");
            }
        } catch (Exception e) {
            e.printStackTrace();
            manejarError(request, response, "Error en el sistema: " + e.getMessage());
        }
    }
    
    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) 
            throws ServletException, IOException {
        
        String action = request.getParameter("action");
        if (action == null) action = "crear";
        
        try {
            switch (action) {
                case "crear":
                    crearTesis(request, response);
                    break;
                case "actualizar":
                    actualizarTesis(request, response);
                    break;
                case "eliminar":
                    eliminarTesis(request, response);
                    break;
                case "asignarDocente":
                    asignarDocenteATesis(request, response);
                    break;
                case "subirArchivo":
                    subirArchivoTesis(request, response);
                    break;
                case "cambiarEstado":
                    cambiarEstadoTesis(request, response);
                    break;
                default:
                    response.sendRedirect("admin/crear-tesis.jsp");
            }
        } catch (Exception e) {
            e.printStackTrace();
            manejarError(request, response, "Error en el sistema: " + e.getMessage());
        }
    }
    
    // ============= MÉTODOS PRIVADOS =============
    
    private void listarTesis(HttpServletRequest request, HttpServletResponse response) 
            throws ServletException, IOException {
        
        String estadoParam = request.getParameter("estado");
        List<Tesis> tesisList;
        
        if (estadoParam != null && !estadoParam.isEmpty()) {
            try {
                EstadoTesis estado = EstadoTesis.valueOf(estadoParam);
                tesisList = tesisDAO.obtenerTesisPorEstado(estado);
                request.setAttribute("estadoFiltro", estadoParam);
            } catch (IllegalArgumentException e) {
                tesisList = tesisDAO.obtenerTodasTesis();
            }
        } else {
            tesisList = tesisDAO.obtenerTodasTesis();
        }
        
        request.setAttribute("tesisList", tesisList);
        
        // Para AJAX
        if ("true".equals(request.getParameter("ajax"))) {
            enviarJSON(response, tesisList);
            return;
        }
        
        RequestDispatcher dispatcher = request.getRequestDispatcher("admin/listar-tesis.jsp");
        dispatcher.forward(request, response);
    }
    
    private void obtenerTesisPorId(HttpServletRequest request, HttpServletResponse response) 
            throws ServletException, IOException {
        
        int id = Integer.parseInt(request.getParameter("id"));
        Tesis tesis = tesisDAO.obtenerTesisPorId(id);
        
        if (tesis != null) {
            request.setAttribute("tesis", tesis);
            
            if ("true".equals(request.getParameter("ajax"))) {
                enviarJSON(response, tesis);
                return;
            }
        }
        
        RequestDispatcher dispatcher = request.getRequestDispatcher("admin/detalle-tesis.jsp");
        dispatcher.forward(request, response);
    }
    
    private void obtenerTesisPorEstudiante(HttpServletRequest request, HttpServletResponse response) 
            throws ServletException, IOException {
        
        int estudianteId = Integer.parseInt(request.getParameter("estudiante_id"));
        List<Tesis> tesisList = tesisDAO.obtenerTesisPorEstudiante(estudianteId);
        
        if ("true".equals(request.getParameter("ajax"))) {
            enviarJSON(response, tesisList);
            return;
        }
        
        request.setAttribute("tesisList", tesisList);
    }
    
    private void obtenerTesisPorDocente(HttpServletRequest request, HttpServletResponse response) 
            throws ServletException, IOException {
        
        int docenteId = Integer.parseInt(request.getParameter("docente_id"));
        List<Tesis> tesisList = tesisDAO.obtenerTesisPorDocente(docenteId);
        
        if ("true".equals(request.getParameter("ajax"))) {
            enviarJSON(response, tesisList);
            return;
        }
        
        request.setAttribute("tesisList", tesisList);
    }
    
    private void obtenerTesisPorEstado(HttpServletRequest request, HttpServletResponse response) 
            throws ServletException, IOException {
        
        String estadoParam = request.getParameter("estado");
        try {
            EstadoTesis estado = EstadoTesis.valueOf(estadoParam);
            List<Tesis> tesisList = tesisDAO.obtenerTesisPorEstado(estado);
            
            if ("true".equals(request.getParameter("ajax"))) {
                enviarJSON(response, tesisList);
                return;
            }
            
            request.setAttribute("tesisList", tesisList);
            request.setAttribute("estadoFiltro", estadoParam);
            
        } catch (IllegalArgumentException e) {
            if ("true".equals(request.getParameter("ajax"))) {
                response.sendError(HttpServletResponse.SC_BAD_REQUEST, "Estado no válido");
            } else {
                request.setAttribute("error", "Estado no válido");
            }
        }
    }
    
   // En TesisController.java - Modifica el método crearTesis
private void crearTesis(HttpServletRequest request, HttpServletResponse response) 
        throws ServletException, IOException {
    
    request.setCharacterEncoding("UTF-8");
    
    try {
        // 1. Obtener parámetros
        String estudianteIdStr = request.getParameter("estudiante_id");
        String titulo = request.getParameter("titulo");
        String resumen = request.getParameter("resumen");
        String palabrasClave = request.getParameter("palabras_clave");
        
        // 2. Validaciones básicas
        if (estudianteIdStr == null || estudianteIdStr.trim().isEmpty()) {
            request.setAttribute("error", "El ID del estudiante es obligatorio");
            request.getRequestDispatcher("admin/crear-tesis.jsp").forward(request, response);
            return;
        }
        
        if (titulo == null || titulo.trim().isEmpty()) {
            request.setAttribute("error", "El título es obligatorio");
            request.getRequestDispatcher("admin/crear-tesis.jsp").forward(request, response);
            return;
        }
        
        // 3. Convertir ID
        int estudianteId;
        try {
            estudianteId = Integer.parseInt(estudianteIdStr.trim());
        } catch (NumberFormatException e) {
            request.setAttribute("error", "ID de estudiante inválido");
            request.getRequestDispatcher("admin/crear-tesis.jsp").forward(request, response);
            return;
        }
        
        // 4. Verificar si estudiante existe
        if (!tesisDAO.existeEstudiante(estudianteId)) {
            request.setAttribute("error", "El estudiante con ID " + estudianteId + " no existe");
            request.getRequestDispatcher("admin/crear-tesis.jsp").forward(request, response);
            return;
        }
        
        // 5. Verificar si ya tiene tesis activa
        if (tesisDAO.tieneTesisActiva(estudianteId)) {
            request.setAttribute("error", "El estudiante ya tiene una tesis activa");
            request.getRequestDispatcher("admin/crear-tesis.jsp").forward(request, response);
            return;
        }
        
        // 6. Crear objeto Tesis
        Tesis tesis = new Tesis();
        tesis.setEstudianteId(estudianteId);
        tesis.setTitulo(titulo);
        tesis.setDescripcion(resumen != null ? resumen : "");
        tesis.setPalabrasClave(palabrasClave != null ? palabrasClave : "");
        tesis.setEstado("BORRADOR"); // O usar enum EstadoTesis.BORRADOR
        tesis.setNivelEstudio("PREGRADO");
        tesis.setSemestre(10); // Valor por defecto
        tesis.setAnoAcademico(java.util.Calendar.getInstance().get(java.util.Calendar.YEAR));
        
        // 7. Guardar tesis (usa el método adecuado según tu estructura)
        int tesisId;
        
        // Opción A: Si tu tabla tiene la estructura del error original
        tesisId = tesisDAO.crearTesis(tesis);
        
        // Opción B: Si tu tabla tiene la estructura del TesisDAO actual
        // tesisId = tesisDAO.crearTesis(tesis);
        
        if (tesisId > 0) {
            // 8. Actualizar estado del estudiante
            tesisDAO.actualizarEstadoEstudiante(estudianteId, "BORRADOR");
            
            // 9. Registrar actividad
            registrarActividad(request, "CREACION_TESIS", 
                "Tesis creada: " + titulo + " (ID: " + tesisId + ")");
            
            // 10. Redirigir con éxito
            HttpSession session = request.getSession();
            session.setAttribute("mensaje", "¡Tesis creada exitosamente!");
            session.setAttribute("tipoMensaje", "success");
            
            response.sendRedirect("admin/dashboard.jsp?accion=tesis&mensaje=creada");
        } else {
            request.setAttribute("error", "Error al crear tesis en la base de datos");
            request.getRequestDispatcher("admin/crear-tesis.jsp").forward(request, response);
        }
        
    } catch (Exception e) {
        e.printStackTrace();
        request.setAttribute("error", "Error al crear tesis: " + e.getMessage());
        request.getRequestDispatcher("admin/crear-tesis.jsp").forward(request, response);
    }
}
    
    private void actualizarTesis(HttpServletRequest request, HttpServletResponse response) 
            throws ServletException, IOException {
        
        request.setCharacterEncoding("UTF-8");
        
        try {
            int tesisId = Integer.parseInt(request.getParameter("id"));
            Tesis tesis = tesisDAO.obtenerTesisPorId(tesisId);
            
            if (tesis == null) {
                response.sendRedirect("TesisController?action=listar&mensaje=Tesis+no+encontrada&tipo=error");
                return;
            }
            
            // Actualizar campos
            tesis.setTitulo(request.getParameter("titulo"));
            tesis.setDescripcion(request.getParameter("descripcion"));
            tesis.setAreaEstudio(request.getParameter("area_estudio"));
            tesis.setCarrera(request.getParameter("carrera"));
            tesis.setComentarios(request.getParameter("comentarios"));
            
            String calificacionStr = request.getParameter("calificacion");
            if (calificacionStr != null && !calificacionStr.isEmpty()) {
                tesis.setCalificacion(Double.parseDouble(calificacionStr));
            }
            
            String fechaLimiteStr = request.getParameter("fecha_limite_revision");
            if (fechaLimiteStr != null && !fechaLimiteStr.isEmpty()) {
                SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd");
                tesis.setFechaLimiteRevision(sdf.parse(fechaLimiteStr));
            }
            
            // Procesar archivo si se sube uno nuevo
            Part filePart = request.getPart("archivo");
            if (filePart != null && filePart.getSize() > 0) {
                String fileName = getFileName(filePart);
                
                // Guardar archivo
                String uploadPath = getServletContext().getRealPath("") + "uploads/tesis/";
                File uploadDir = new File(uploadPath);
                if (!uploadDir.exists()) {
                    uploadDir.mkdirs();
                }
                
                String filePath = uploadPath + System.currentTimeMillis() + "_" + fileName;
                filePart.write(filePath);
                
                // Eliminar archivo anterior si existe
                if (tesis.getArchivo() != null && !tesis.getArchivo().isEmpty()) {
                    File oldFile = new File(uploadPath + tesis.getArchivo());
                    if (oldFile.exists()) {
                        oldFile.delete();
                    }
                }
                
                tesis.setArchivo(fileName);
            }
            
            boolean actualizado = tesisDAO.actualizarTesis(tesis);
            
            if (actualizado) {
                // Registrar actividad
                registrarActividad(request, "ACTUALIZACION_TESIS", 
                    "Tesis actualizada ID: " + tesisId);
                
                response.sendRedirect("TesisController?action=obtenerPorId&id=" + tesisId + 
                    "&mensaje=Tesis+actualizada+exitosamente&tipo=success");
            } else {
                response.sendRedirect("TesisController?action=obtenerPorId&id=" + tesisId + 
                    "&mensaje=Error+al+actualizar+tesis&tipo=error");
            }
            
        } catch (Exception e) {
            e.printStackTrace();
            request.setAttribute("error", "Error al actualizar tesis: " + e.getMessage());
            request.getRequestDispatcher("admin/editar-tesis.jsp").forward(request, response);
        }
    }
    
    private void eliminarTesis(HttpServletRequest request, HttpServletResponse response) 
            throws ServletException, IOException {
        
        int id = Integer.parseInt(request.getParameter("id"));
        boolean eliminado = tesisDAO.eliminarTesis(id);
        
        if (eliminado) {
            // Registrar actividad
            registrarActividad(request, "ELIMINACION_TESIS", 
                "Tesis eliminada ID: " + id);
            
            response.sendRedirect("TesisController?action=listar&mensaje=Tesis+eliminada+exitosamente&tipo=success");
        } else {
            response.sendRedirect("TesisController?action=listar&mensaje=Error+al+eliminar+tesis&tipo=error");
        }
    }
    
    private void asignarDocenteATesis(HttpServletRequest request, HttpServletResponse response) 
            throws ServletException, IOException {
        
        try {
            int tesisId = Integer.parseInt(request.getParameter("tesis_id"));
            int docenteId = Integer.parseInt(request.getParameter("docente_id"));
            String fechaLimiteStr = request.getParameter("fecha_limite");
            
            SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd");
            Date fechaLimite = sdf.parse(fechaLimiteStr);
            
            boolean asignado = tesisDAO.asignarDocenteATesis(tesisId, docenteId, fechaLimite);
            
            if (asignado) {
                // Registrar actividad
                registrarActividad(request, "ASIGNACION_DOCENTE", 
                    "Docente " + docenteId + " asignado a tesis " + tesisId);
                
                response.sendRedirect("TesisController?action=obtenerPorId&id=" + tesisId + 
                    "&mensaje=Docente+asignado+exitosamente&tipo=success");
            } else {
                response.sendRedirect("TesisController?action=obtenerPorId&id=" + tesisId + 
                    "&mensaje=Error+al+asignar+docente&tipo=error");
            }
            
        } catch (Exception e) {
            e.printStackTrace();
            response.sendRedirect("TesisController?action=listar&mensaje=Error+en+asignacion&tipo=error");
        }
    }
    
    private void descargarArchivoTesis(HttpServletRequest request, HttpServletResponse response) 
            throws ServletException, IOException {
        
        int tesisId = Integer.parseInt(request.getParameter("id"));
        Tesis tesis = tesisDAO.obtenerTesisPorId(tesisId);
        
        if (tesis != null && tesis.getArchivo() != null && !tesis.getArchivo().isEmpty()) {
            String uploadPath = getServletContext().getRealPath("") + "uploads/tesis/";
            File file = new File(uploadPath + tesis.getArchivo());
            
            if (file.exists()) {
                response.setContentType("application/octet-stream");
                response.setHeader("Content-Disposition", 
                    "attachment; filename=\"" + tesis.getArchivo() + "\"");
                response.setContentLength((int) file.length());
                
                try (FileInputStream in = new FileInputStream(file);
                     OutputStream out = response.getOutputStream()) {
                    
                    byte[] buffer = new byte[4096];
                    int bytesRead;
                    
                    while ((bytesRead = in.read(buffer)) != -1) {
                        out.write(buffer, 0, bytesRead);
                    }
                    
                    out.flush();
                }
                return;
            }
        }
        
        response.sendRedirect("TesisController?action=listar&mensaje=Archivo+no+encontrado&tipo=error");
    }
    
    private void obtenerEstadisticasTesis(HttpServletRequest request, HttpServletResponse response) 
            throws ServletException, IOException {
        
        int totalTesis = tesisDAO.contarTesisTotales();
        int tesisSinAsignar = tesisDAO.contarTesisSinAsignar();
        int porcentajeCompletadas = tesisDAO.obtenerPorcentajeCompletadas();
        
        // Para AJAX
        if ("true".equals(request.getParameter("ajax"))) {
            response.setContentType("application/json");
            response.setCharacterEncoding("UTF-8");
            PrintWriter out = response.getWriter();
            
            String json = String.format(
                "{\"totalTesis\":%d, \"tesisSinAsignar\":%d, \"porcentajeCompletadas\":%d}",
                totalTesis, tesisSinAsignar, porcentajeCompletadas
            );
            out.print(json);
            out.flush();
            return;
        }
        
        // Para vista JSP
        request.setAttribute("totalTesis", totalTesis);
        request.setAttribute("tesisSinAsignar", tesisSinAsignar);
        request.setAttribute("porcentajeCompletadas", porcentajeCompletadas);
    }
    
    // ============= MÉTODOS AUXILIARES =============
    
    private String getFileName(Part part) {
        String contentDisp = part.getHeader("content-disposition");
        String[] tokens = contentDisp.split(";");
        
        for (String token : tokens) {
            if (token.trim().startsWith("filename")) {
                return token.substring(token.indexOf('=') + 2, token.length() - 1);
            }
        }
        return "";
    }
    
    private void enviarJSON(HttpServletResponse response, Object obj) throws IOException {
        response.setContentType("application/json");
        response.setCharacterEncoding("UTF-8");
        PrintWriter out = response.getWriter();
        
        if (obj instanceof List) {
            out.print(convertirListaTesisAJSON((List<Tesis>) obj));
        } else if (obj instanceof Tesis) {
            out.print(convertirTesisAJSON((Tesis) obj));
        } else {
            out.print("{\"error\": \"Tipo de objeto no soportado\"}");
        }
        
        out.flush();
    }
    
    private String convertirTesisAJSON(Tesis tesis) {
        if (tesis == null) return "null";
        
        SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd");
        
        StringBuilder json = new StringBuilder("{");
        json.append("\"id\":").append(tesis.getId()).append(",");
        json.append("\"titulo\":\"").append(escapeJSON(tesis.getTitulo())).append("\",");
        json.append("\"descripcion\":\"").append(escapeJSON(tesis.getDescripcion())).append("\",");
        json.append("\"nombreEstudiante\":\"").append(escapeJSON(tesis.getNombreEstudiante())).append("\",");
        json.append("\"nombreDocente\":\"").append(escapeJSON(tesis.getNombreDocente())).append("\",");
        json.append("\"estado\":\"").append(tesis.getEstado()).append("\",");
        json.append("\"carrera\":\"").append(escapeJSON(tesis.getCarrera())).append("\",");
        json.append("\"areaEstudio\":\"").append(escapeJSON(tesis.getAreaEstudio())).append("\"");
        
        if (tesis.getFechaEntrega() != null) {
            json.append(",\"fechaEntrega\":\"").append(sdf.format(tesis.getFechaEntrega())).append("\"");
        }
        
        if (tesis.getFechaLimiteRevision() != null) {
            json.append(",\"fechaLimiteRevision\":\"").append(sdf.format(tesis.getFechaLimiteRevision())).append("\"");
        }
        
        if (tesis.getCalificacion() > 0) {
            json.append(",\"calificacion\":").append(tesis.getCalificacion());
        }
        
        json.append("}");
        
        return json.toString();
    }
    
    private String convertirListaTesisAJSON(List<Tesis> tesisList) {
        StringBuilder json = new StringBuilder("[");
        
        for (int i = 0; i < tesisList.size(); i++) {
            json.append(convertirTesisAJSON(tesisList.get(i)));
            if (i < tesisList.size() - 1) {
                json.append(",");
            }
        }
        
        json.append("]");
        return json.toString();
    }
    
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
    
    private void registrarActividad(HttpServletRequest request, String tipoAccion, String descripcion) {
        HttpSession session = request.getSession(false);
        if (session != null) {
            Integer usuarioId = (Integer) session.getAttribute("usuario_id");
            if (usuarioId != null) {
                System.out.println("📝 Actividad [" + tipoAccion + "]: " + descripcion + " (Usuario ID: " + usuarioId + ")");
            }
        }
    }
    
    private void manejarError(HttpServletRequest request, HttpServletResponse response, String mensaje) 
            throws ServletException, IOException {
        request.setAttribute("error", mensaje);
        RequestDispatcher dispatcher = request.getRequestDispatcher("error.jsp");
        dispatcher.forward(request, response);
    }
    
    // Métodos pendientes (para completar según necesidad)
    private void subirArchivoTesis(HttpServletRequest request, HttpServletResponse response) 
            throws ServletException, IOException {
        // Implementar subida de archivo independiente
    }
    
    private void cambiarEstadoTesis(HttpServletRequest request, HttpServletResponse response) 
            throws ServletException, IOException {
        // Implementar cambio de estado
    }
    
    // En TesisController.java - Añade este método

/**
 * Método específico para crear tesis con la estructura del formulario original
 * Este maneja la acción "uploadThesis" que tenías en tu código
 */
private void uploadThesisAction(HttpServletRequest request, HttpServletResponse response) 
        throws ServletException, IOException {
    
    String message = "";
    String messageType = "error";
    
    try {
        System.out.println("=== PROCESANDO UPLOAD_THESIS DESDE CONTROLLER ===");
        
        // Debug: mostrar todos los parámetros
        java.util.Enumeration<String> paramNames = request.getParameterNames();
        while (paramNames.hasMoreElements()) {
            String paramName = paramNames.nextElement();
            System.out.println("Parámetro: " + paramName + " = " + request.getParameter(paramName));
        }
        
        // Obtener parámetros con validación
        String estudianteIdStr = request.getParameter("estudiante_id");
        String titulo = request.getParameter("titulo");
        String resumen = request.getParameter("resumen");
        String palabrasClave = request.getParameter("palabras_clave");
        
        // Validar que no sean nulos
        if (estudianteIdStr == null || estudianteIdStr.trim().isEmpty()) {
            message = "Error: El ID del estudiante es obligatorio";
            messageType = "error";
            System.out.println("ERROR: estudiante_id es null o vacío");
            
            request.setAttribute("message", message);
            request.setAttribute("messageType", messageType);
            request.getRequestDispatcher("admin/crear-tesis.jsp").forward(request, response);
            return;
        }
        
        if (titulo == null || titulo.trim().isEmpty()) {
            message = "Error: El título es obligatorio";
            messageType = "error";
            System.out.println("ERROR: titulo es null o vacío");
            
            request.setAttribute("message", message);
            request.setAttribute("messageType", messageType);
            request.getRequestDispatcher("admin/crear-tesis.jsp").forward(request, response);
            return;
        }
        
        // Convertir y validar ID
        int estudianteId;
        try {
            estudianteId = Integer.parseInt(estudianteIdStr.trim());
        } catch (NumberFormatException e) {
            message = "Error: ID de estudiante inválido";
            messageType = "error";
            System.out.println("ERROR: No se puede convertir estudiante_id a número: " + estudianteIdStr);
            
            request.setAttribute("message", message);
            request.setAttribute("messageType", messageType);
            request.getRequestDispatcher("admin/crear-tesis.jsp").forward(request, response);
            return;
        }
        
        // Verificar que el estudiante existe usando TesisDAO
        if (!tesisDAO.existeEstudiante(estudianteId)) {
            message = "Error: El estudiante con ID " + estudianteId + " no existe";
            messageType = "error";
            System.out.println("ERROR: Estudiante no existe en la base de datos");
            
            request.setAttribute("message", message);
            request.setAttribute("messageType", messageType);
            request.getRequestDispatcher("admin/crear-tesis.jsp").forward(request, response);
            return;
        }
        
        // Obtener año académico actual
        java.util.Calendar cal = java.util.Calendar.getInstance();
        int anoAcademico = cal.get(java.util.Calendar.YEAR);
        
        System.out.println("Valores para inserción:");
        System.out.println("  estudiante_id: " + estudianteId);
        System.out.println("  titulo: " + titulo);
        System.out.println("  resumen: " + (resumen != null ? resumen.substring(0, Math.min(resumen.length(), 50)) + "..." : "null"));
        System.out.println("  palabras_clave: " + palabrasClave);
        System.out.println("  ano_academico: " + anoAcademico);
        
        // Crear tesis usando TesisDAO
        int tesisId = tesisDAO.crearTesisConEstructura(
            estudianteId, 
            titulo, 
            resumen != null ? resumen : "",
            palabrasClave != null ? palabrasClave : "",
            "PREGRADO",
            10,
            anoAcademico
        );
        
        System.out.println("Tesis creada con ID: " + tesisId);
        
        if (tesisId > 0) {
            // Actualizar estado del estudiante
            tesisDAO.actualizarEstadoEstudiante(estudianteId, "BORRADOR");
            
            message = "¡Tesis creada exitosamente!";
            messageType = "success";
            System.out.println("SUCCESS: Tesis creada correctamente con ID: " + tesisId);
            
            // Registrar actividad
            registrarActividad(request, "CREACION_TESIS", 
                "Tesis creada: " + titulo + " (ID: " + tesisId + ")");
            
            // Guardar en sesión para mostrar mensaje
            HttpSession session = request.getSession();
            session.setAttribute("successMessage", message);
            session.setAttribute("messageType", messageType);
            
            response.sendRedirect("admin/dashboard.jsp?success=true&tesisId=" + tesisId);
            
        } else {
            message = "Error: No se pudo crear la tesis";
            messageType = "error";
            System.out.println("ERROR: No se pudo crear la tesis");
            
            request.setAttribute("message", message);
            request.setAttribute("messageType", messageType);
            request.getRequestDispatcher("admin/crear-tesis.jsp").forward(request, response);
        }
        
    } catch (Exception e) {
        e.printStackTrace();
        message = "Error inesperado: " + e.getMessage();
        messageType = "error";
        
        request.setAttribute("message", message);
        request.setAttribute("messageType", messageType);
        request.getRequestDispatcher("admin/crear-tesis.jsp").forward(request, response);
    }
}
}