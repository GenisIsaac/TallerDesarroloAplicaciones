package Controlador;

import DAO.TesisDAO;
import DB.DatabaseConnection;
import Modelos.Tesis;
import Modelos.EstadoTesis;
import jakarta.servlet.*;
import jakarta.servlet.http.*;
import jakarta.servlet.annotation.*;
import java.io.*;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;
import java.text.SimpleDateFormat;
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
                    response.sendRedirect("admin/administrador.jsp");
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
        System.out.println("=== TesisController.doPost ===");
        System.out.println("Acción recibida: " + action);
        
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
                case "upload_thesis":
                    // Si vienes del formulario antiguo con action=upload_thesis
                    crearTesis(request, response);
                    break;
                default:
                    System.out.println("Acción no reconocida, redirigiendo...");
                    response.sendRedirect("administrador.jsp");
            }
        } catch (Exception e) {
            e.printStackTrace();
            manejarError(request, response, "Error en el sistema: " + e.getMessage());
        }
    }
    
    // ============= MÉTODO PRINCIPAL PARA CREAR TESIS =============
    private void crearTesis(HttpServletRequest request, HttpServletResponse response) 
            throws ServletException, IOException {
        
        request.setCharacterEncoding("UTF-8");
        System.out.println("=== INICIANDO CREAR TESIS ===");
        
        try {
            // 1. Obtener parámetros del formulario
            String estudianteIdStr = request.getParameter("estudiante_id");
            String titulo = request.getParameter("titulo");
            String resumen = request.getParameter("descripcion"); // En tu JSP el campo se llama "descripcion"
            String palabrasClave = request.getParameter("palabras_clave");
            
            System.out.println("Parámetros recibidos:");
            System.out.println("- estudiante_id: " + estudianteIdStr);
            System.out.println("- titulo: " + titulo);
            System.out.println("- descripcion (resumen): " + (resumen != null ? resumen.substring(0, Math.min(50, resumen.length())) : "null"));
            System.out.println("- palabras_clave: " + palabrasClave);
            
            // 2. Validaciones básicas
            if (estudianteIdStr == null || estudianteIdStr.trim().isEmpty()) {
                manejarError(request, response, "El ID del estudiante es obligatorio");
                return;
            }
            
            if (titulo == null || titulo.trim().isEmpty()) {
                manejarError(request, response, "El título es obligatorio");
                return;
            }
            
            // 3. Convertir ID
            int estudianteId;
            try {
                estudianteId = Integer.parseInt(estudianteIdStr.trim());
            } catch (NumberFormatException e) {
                manejarError(request, response, "ID de estudiante inválido: " + estudianteIdStr);
                return;
            }
            
            // 4. Procesar archivo
            Part filePart = request.getPart("archivo");
            String nombreArchivo = null;
            long tamanoArchivo = 0;
            String tipoArchivo = null;
            
            if (filePart != null && filePart.getSize() > 0) {
                nombreArchivo = getFileName(filePart);
                tamanoArchivo = filePart.getSize();
                tipoArchivo = filePart.getContentType();
                
                System.out.println("Archivo recibido:");
                System.out.println("- Nombre: " + nombreArchivo);
                System.out.println("- Tamaño: " + tamanoArchivo);
                System.out.println("- Tipo: " + tipoArchivo);
                
                // Validar tipo de archivo
                if (!validarTipoArchivo(tipoArchivo)) {
                    manejarError(request, response, "Tipo de archivo no permitido. Solo se aceptan PDF, DOC y DOCX.");
                    return;
                }
                
                // Guardar archivo en el servidor
                String uploadPath = getServletContext().getRealPath("") + "uploads/tesis/";
                File uploadDir = new File(uploadPath);
                if (!uploadDir.exists()) {
                    uploadDir.mkdirs();
                    System.out.println("Directorio creado: " + uploadPath);
                }
                
                String uniqueFileName = System.currentTimeMillis() + "_" + nombreArchivo;
                String filePath = uploadPath + File.separator + uniqueFileName;
                filePart.write(filePath);
                
                nombreArchivo = uniqueFileName; // Usar nombre único para la BD
                System.out.println("Archivo guardado en: " + filePath);
            } else {
                manejarError(request, response, "El archivo de tesis es obligatorio");
                return;
            }
            
            // 5. Crear objeto Tesis
            Tesis tesis = new Tesis();
            tesis.setEstudianteId(estudianteId);
            tesis.setTitulo(titulo);
            tesis.setDescripcion(resumen != null ? resumen : "");
            tesis.setPalabrasClave(palabrasClave != null ? palabrasClave : "");
            tesis.setEstado("BORRADOR");
            tesis.setNivelEstudio("PREGRADO");
            tesis.setSemestre(10); // Valor por defecto
            tesis.setAnoAcademico(java.util.Calendar.getInstance().get(java.util.Calendar.YEAR));
            
            // 6. Usar el método crearTesisCompleta para insertar en BD
            int tesisId = crearTesisCompleta(tesis, nombreArchivo, tamanoArchivo, tipoArchivo);
            
            if (tesisId > 0) {
                // 7. Actualizar estado del estudiante
                actualizarEstadoEstudiante(estudianteId, "BORRADOR");
                
                // 8. Registrar actividad
                registrarActividad(request, "CREACION_TESIS", 
                    "Tesis creada: " + titulo + " (ID: " + tesisId + ")");
                
                // 9. Redirigir con éxito
                HttpSession session = request.getSession();
                session.setAttribute("mensaje", "¡Tesis creada exitosamente! ID: " + tesisId);
                session.setAttribute("tipoMensaje", "success");
                
                System.out.println("✅ Tesis creada exitosamente con ID: " + tesisId);
                response.sendRedirect("administrador.jsp?mensaje=creada&tesisId=" + tesisId);
                
            } else {
                manejarError(request, response, "Error al crear tesis en la base de datos");
            }
            
        } catch (Exception e) {
            System.err.println("❌ Error en crearTesis:");
            e.printStackTrace();
            manejarError(request, response, "Error al crear tesis: " + e.getMessage());
        }
    }
    
    private int crearTesisCompleta(Tesis tesis, String nombreArchivo, long tamanoArchivo, String tipoArchivo) {
    
    System.out.println("=== CREAR TESIS COMPLETA EN BD ===");
    System.out.println("Insertando tesis para estudiante ID: " + tesis.getEstudianteId());
    
    Connection conn = null;
    PreparedStatement pstmt = null;
    ResultSet generatedKeys = null;
    
    try {
        // 1. Obtener conexión
        conn = DatabaseConnection.getConnection();
        if (conn == null || conn.isClosed()) {
            System.err.println("❌ Error: Conexión nula o cerrada");
            return -1;
        }
        
        // 2. Verificar estructura de la tabla
        System.out.println("Verificando estructura de la tabla 'tesis'...");
        try (Statement stmt = conn.createStatement()) {
            ResultSet rs = stmt.executeQuery("SHOW COLUMNS FROM tesis");
            System.out.println("Columnas de la tabla 'tesis':");
            while (rs.next()) {
                System.out.println(" - " + rs.getString("Field") + " (" + rs.getString("Type") + ")");
            }
        }
        
        // 3. SQL corregido - Ajusta según tu estructura real
        // NOTA: Ajusta los nombres de columnas según lo que viste en el DESCRIBE
        String sql = "INSERT INTO tesis (estudiante_id, titulo, descripcion, palabras_clave, estado, " +
                    "nivel_estudio, semestre, ano_academico, archivo, formato, " +
                    "tamano, fecha_creacion) " +
                    "VALUES (?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, NOW())";
        
        System.out.println("SQL de inserción: " + sql);
        
        // 4. Crear PreparedStatement
        pstmt = conn.prepareStatement(sql, Statement.RETURN_GENERATED_KEYS);
        
        // 5. Convertir tipo de archivo
        String formatoArchivo = convertirFormatoArchivo(tipoArchivo);
        
        // 6. Establecer parámetros con logs
        System.out.println("Estableciendo parámetros:");
        System.out.println("1. estudiante_id: " + tesis.getEstudianteId());
        System.out.println("2. titulo: " + tesis.getTitulo());
        System.out.println("3. descripcion: " + tesis.getDescripcion());
        System.out.println("4. palabras_clave: " + tesis.getPalabrasClave());
        System.out.println("5. estado: " + tesis.getEstado());
        System.out.println("6. nivel_estudio: " + tesis.getNivelEstudio());
        System.out.println("7. semestre: " + tesis.getSemestre());
        System.out.println("8. ano_academico: " + tesis.getAnoAcademico());
        System.out.println("9. archivo: " + nombreArchivo);
        System.out.println("10. formato: " + formatoArchivo);
        System.out.println("11. tamano: " + tamanoArchivo);
        
        pstmt.setInt(1, tesis.getEstudianteId());
        pstmt.setString(2, tesis.getTitulo());
        pstmt.setString(3, tesis.getDescripcion());
        pstmt.setString(4, tesis.getPalabrasClave());
        pstmt.setString(5, tesis.getEstado());
        pstmt.setString(6, tesis.getNivelEstudio());
        pstmt.setInt(7, tesis.getSemestre());
        pstmt.setInt(8, tesis.getAnoAcademico());
        pstmt.setString(9, nombreArchivo);
        pstmt.setString(10, formatoArchivo);
        pstmt.setLong(11, tamanoArchivo);
        
        // 7. Ejecutar inserción
        System.out.println("Ejecutando inserción...");
        int affectedRows = pstmt.executeUpdate();
        System.out.println("Filas afectadas: " + affectedRows);
        
        if (affectedRows > 0) {
            // Obtener ID generado
            generatedKeys = pstmt.getGeneratedKeys();
            if (generatedKeys != null && generatedKeys.next()) {
                int tesisId = generatedKeys.getInt(1);
                System.out.println("✅ Tesis insertada con ID: " + tesisId);
                
                // Verificar que se insertó correctamente
                try (Statement stmt = conn.createStatement()) {
                    ResultSet rs = stmt.executeQuery("SELECT * FROM tesis WHERE id = " + tesisId);
                    if (rs.next()) {
                        System.out.println("✅ Verificación exitosa - Tesis encontrada en BD");
                    }
                }
                
                return tesisId;
            }
        } else {
            System.err.println("❌ No se insertaron filas en la BD");
        }
        
        return -1;
        
    } catch (SQLException e) {
        System.err.println("❌ Error SQL al crear tesis:");
        System.err.println("   Código: " + e.getErrorCode());
        System.err.println("   Estado: " + e.getSQLState());
        System.err.println("   Mensaje: " + e.getMessage());
        e.printStackTrace();
        return -1;
    } catch (Exception e) {
        System.err.println("❌ Error general al crear tesis:");
        e.printStackTrace();
        return -1;
    } finally {
        DatabaseConnection.closeResources(conn, pstmt, generatedKeys);
    }
}
    // ============= MÉTODOS AUXILIARES =============
    
    private boolean validarTipoArchivo(String tipoArchivo) {
        if (tipoArchivo == null) return false;
        
        return tipoArchivo.equals("application/pdf") ||
               tipoArchivo.equals("application/msword") ||
               tipoArchivo.equals("application/vnd.openxmlformats-officedocument.wordprocessingml.document");
    }
    
    private String convertirFormatoArchivo(String tipoArchivo) {
        if (tipoArchivo == null) return "PDF";
        
        if (tipoArchivo.equals("application/pdf")) {
            return "PDF";
        } else if (tipoArchivo.equals("application/vnd.openxmlformats-officedocument.wordprocessingml.document")) {
            return "DOCX";
        } else if (tipoArchivo.equals("application/msword")) {
            return "DOC";
        }
        return "PDF";
    }
    
    private void actualizarEstadoEstudiante(int estudianteId, String estado) {
        System.out.println("Actualizando estado del estudiante ID: " + estudianteId + " a: " + estado);
        
        Connection conn = null;
        PreparedStatement pstmt = null;
        
        try {
            conn = DatabaseConnection.getConnection();
            
            // Primero verificar si la columna existe
            String sqlCheck = "SHOW COLUMNS FROM estudiantes LIKE 'estado_tesis'";
            Statement stmt = conn.createStatement();
            ResultSet rs = stmt.executeQuery(sqlCheck);
            
            if (!rs.next()) {
                // La columna no existe, crearla
                String sqlAlter = "ALTER TABLE estudiantes ADD COLUMN estado_tesis VARCHAR(20) DEFAULT 'SIN_ENVIAR'";
                stmt.executeUpdate(sqlAlter);
                System.out.println("Columna 'estado_tesis' creada en tabla estudiantes");
            }
            rs.close();
            stmt.close();
            
            // Ahora actualizar el estado
            String sqlUpdate = "UPDATE estudiantes SET estado_tesis = ? WHERE id = ?";
            pstmt = conn.prepareStatement(sqlUpdate);
            pstmt.setString(1, estado);
            pstmt.setInt(2, estudianteId);
            
            int rows = pstmt.executeUpdate();
            System.out.println("Estudiante actualizado: " + rows + " filas afectadas");
            
        } catch (Exception e) {
            System.err.println("Error al actualizar estado del estudiante: " + e.getMessage());
        } finally {
            DatabaseConnection.closeResources(conn, pstmt, null);
        }
    }
    
    // ============= MÉTODOS RESTANTES (sin cambios) =============
    
    private void listarTesis(HttpServletRequest request, HttpServletResponse response) 
            throws ServletException, IOException {
        // Mantener tu código existente
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
        
        if ("true".equals(request.getParameter("ajax"))) {
            enviarJSON(response, tesisList);
            return;
        }
        
        RequestDispatcher dispatcher = request.getRequestDispatcher("admin/listar-tesis.jsp");
        dispatcher.forward(request, response);
    }
    
    private void obtenerTesisPorId(HttpServletRequest request, HttpServletResponse response) 
            throws ServletException, IOException {
        // Mantener tu código existente
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
        // Mantener tu código existente
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
        // Mantener tu código existente
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
        // Mantener tu código existente
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
    
    private void actualizarTesis(HttpServletRequest request, HttpServletResponse response) 
            throws ServletException, IOException {
        // Mantener tu código existente
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
            
            String calificacionStr = request.getParameter("calificacion");
            if (calificacionStr != null && !calificacionStr.isEmpty()) {
                tesis.setCalificacion(Double.parseDouble(calificacionStr));
            }
            
            boolean actualizado = tesisDAO.actualizarTesis(tesis);
            
            if (actualizado) {
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
            request.getRequestDispatcher("administrador.jsp").forward(request, response);
        }
    }
    
    private void eliminarTesis(HttpServletRequest request, HttpServletResponse response) 
            throws ServletException, IOException {
        // Mantener tu código existente
        int id = Integer.parseInt(request.getParameter("id"));
        boolean eliminado = tesisDAO.eliminarTesis(id);
        
        if (eliminado) {
            registrarActividad(request, "ELIMINACION_TESIS", 
                "Tesis eliminada ID: " + id);
            
            response.sendRedirect("TesisController?action=listar&mensaje=Tesis+eliminada+exitosamente&tipo=success");
        } else {
            response.sendRedirect("TesisController?action=listar&mensaje=Error+al+eliminar+tesis&tipo=error");
        }
    }
    
    private void asignarDocenteATesis(HttpServletRequest request, HttpServletResponse response) 
            throws ServletException, IOException {
        // Mantener tu código existente
        try {
            int tesisId = Integer.parseInt(request.getParameter("tesis_id"));
            int docenteId = Integer.parseInt(request.getParameter("docente_id"));
            String fechaLimiteStr = request.getParameter("fecha_limite");
            
            SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd");
            Date fechaLimite = sdf.parse(fechaLimiteStr);
            
            boolean asignado = tesisDAO.asignarDocenteATesis(tesisId, docenteId, fechaLimite);
            
            if (asignado) {
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
        // Mantener tu código existente
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
        // Mantener tu código existente
        int totalTesis = tesisDAO.contarTesisTotales();
        int tesisSinAsignar = tesisDAO.contarTesisSinAsignar();
        int porcentajeCompletadas = tesisDAO.obtenerPorcentajeCompletadas();
        
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
        
        request.setAttribute("totalTesis", totalTesis);
        request.setAttribute("tesisSinAsignar", tesisSinAsignar);
        request.setAttribute("porcentajeCompletadas", porcentajeCompletadas);
    }
    
    private String getFileName(Part part) {
        // Mantener tu código existente
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
        // Mantener tu código existente
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
        // Mantener tu código existente
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
        // Mantener tu código existente
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
        // Mantener tu código existente
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
        // Mantener tu código existente
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
        // Mantener tu código existente
        request.setAttribute("error", mensaje);
        RequestDispatcher dispatcher = request.getRequestDispatcher("administrador.jsp");
        dispatcher.forward(request, response);
    }
    
    private void subirArchivoTesis(HttpServletRequest request, HttpServletResponse response) 
            throws ServletException, IOException {
        // Método para subir archivo independiente (puede ser para actualizar)
        System.out.println("Subir archivo tesis...");
        // Implementación pendiente
    }
    
    private void cambiarEstadoTesis(HttpServletRequest request, HttpServletResponse response) 
            throws ServletException, IOException {
        // Método para cambiar estado de tesis
        System.out.println("Cambiar estado tesis...");
        // Implementación pendiente
    }
}