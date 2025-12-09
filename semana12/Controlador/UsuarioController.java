package Controlador;

import DAO.UsuarioDAO;
import Modelos.Usuario;
import Modelos.Estudiante;
import Modelos.Docente;
import jakarta.servlet.*;
import jakarta.servlet.http.*;
import jakarta.servlet.annotation.*;
import java.io.*;
import java.util.List;

@WebServlet("/UsuarioController")
public class UsuarioController extends HttpServlet {
    
    private UsuarioDAO usuarioDAO;
    
    @Override
    public void init() {
        usuarioDAO = new UsuarioDAO();
    }
    
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) 
            throws ServletException, IOException {
        
        String action = request.getParameter("action");
        if (action == null) action = "listar";
        
        try {
            switch (action) {
                case "listar":
                    listarUsuarios(request, response);
                    break;
                case "obtenerPorId":
                    obtenerUsuarioPorId(request, response);
                    break;
                case "obtenerPorEmail":
                    obtenerUsuarioPorEmail(request, response);
                    break;
                case "estudiantes":
                    listarEstudiantes(request, response);
                    break;
                case "docentes":
                    listarDocentes(request, response);
                    break;
                case "docentesDisponibles":
                    listarDocentesDisponibles(request, response);
                    break;
                case "estadisticas":
                    obtenerEstadisticas(request, response);
                    break;
                case "testBD":
                    testBaseDatos(request, response);
                    break;
                case "loginPage":
                    mostrarLogin(request, response);
                    break;
                default:
                    response.sendRedirect("admin/admin-dashboard.jsp");
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
        if (action == null) action = "login";
        
        try {
            switch (action) {
                case "crear":
                    crearUsuario(request, response);
                    break;
                case "actualizar":
                    actualizarUsuario(request, response);
                    break;
                case "eliminar":
                    eliminarUsuario(request, response);
                    break;
                case "cambiarEstado":
                    cambiarEstadoUsuario(request, response);
                    break;
                case "actualizarPassword":
                    actualizarPassword(request, response);
                    break;
                case "login":
                    login(request, response);
                    break;
                default:
                    response.sendRedirect("login.jsp");
            }
        } catch (Exception e) {
            e.printStackTrace();
            request.setAttribute("error", "Error en el sistema: " + e.getMessage());
            request.getRequestDispatcher("error.jsp").forward(request, response);
        }
    }
    
    // ============= MÉTODOS DE AUTENTICACIÓN =============
    
    private void mostrarLogin(HttpServletRequest request, HttpServletResponse response) 
            throws ServletException, IOException {
        request.getRequestDispatcher("login.jsp").forward(request, response);
    }
    
    private void login(HttpServletRequest request, HttpServletResponse response) 
            throws ServletException, IOException {
        
        String email = request.getParameter("email");
        String password = request.getParameter("password");
        
        System.out.println("🔐 Intento de login: " + email);
        
        // Validar campos
        if (email == null || password == null || email.trim().isEmpty() || password.trim().isEmpty()) {
            request.setAttribute("error", "Email y contraseña son obligatorios");
            request.getRequestDispatcher("index.jsp").forward(request, response);
            return;
        }
        
        // Limpiar datos
        email = email.trim().toLowerCase();
        password = password.trim();
        
        // Autenticar usuario usando el DAO
        Usuario usuario = usuarioDAO.login(email, password);
        
        if (usuario != null) {
            System.out.println("✅ Login exitoso para: " + usuario.getNombre());
            
            // Crear sesión
            HttpSession session = request.getSession(true);
            session.setAttribute("usuario_id", usuario.getId());
            session.setAttribute("usuario_nombre", usuario.getNombre() + " " + usuario.getApellido());
            session.setAttribute("usuario_email", usuario.getEmail());
            session.setAttribute("usuario_tipo", usuario.getTipo());
            
            // Actualizar último acceso
            usuarioDAO.actualizarUltimoAcceso(usuario.getId());
            
            // Redirigir según tipo de usuario
            switch (usuario.getTipo()) {
                case ADMINISTRADOR:
                    response.sendRedirect("admin/admin-dashboard.jsp");
                    break;
                case DOCENTE:
                    response.sendRedirect("docente/dashboard.jsp");
                    break;
                case ESTUDIANTE:
                    response.sendRedirect("estudiante/dashboard.jsp");
                    break;
                default:
                    response.sendRedirect("login.jsp");
            }
        } else {
            System.out.println("❌ Login fallido para: " + email);
            request.setAttribute("error", "Credenciales incorrectas");
            request.getRequestDispatcher("index.jsp").forward(request, response);
        }
    }
    
    // ============= MÉTODOS CRUD =============
    
    private void crearUsuario(HttpServletRequest request, HttpServletResponse response) 
            throws ServletException, IOException {
        
        request.setCharacterEncoding("UTF-8");
        String tipoUsuario = request.getParameter("tipo_usuario");
        String mensaje = "";
        
        try {
            if ("ESTUDIANTE".equalsIgnoreCase(tipoUsuario)) {
                mensaje = crearEstudiante(request);
            } else if ("DOCENTE".equalsIgnoreCase(tipoUsuario)) {
                mensaje = crearDocente(request);
            } else {
                mensaje = "Tipo de usuario no válido";
            }
            
            if (mensaje.startsWith("✅")) {
                response.sendRedirect("admin/admin-dashboard.jsp?mensaje=" + 
                    mensaje.substring(2) + "&tipo=success");
            } else {
                request.setAttribute("error", mensaje);
                request.getRequestDispatcher("admin/crear-usuario.jsp").forward(request, response);
            }
            
        } catch (Exception e) {
            e.printStackTrace();
            request.setAttribute("error", "Error al crear usuario: " + e.getMessage());
            request.getRequestDispatcher("admin/crear-usuario.jsp").forward(request, response);
        }
    }
    
    private String crearEstudiante(HttpServletRequest request) {
        String email = request.getParameter("email");
        String codigo = request.getParameter("codigo_estudiante");
        
        // Validar email único
        if (usuarioDAO.existeEmail(email)) {
            return "El email ya está registrado";
        }
        
        // Validar código estudiante único
        if (usuarioDAO.existeCodigoEstudiante(codigo)) {
            return "El código de estudiante ya existe";
        }
        
        // Crear usuario base
        Usuario usuario = new Usuario();
        usuario.setNombre(request.getParameter("nombre"));
        usuario.setApellido(request.getParameter("apellido"));
        usuario.setEmail(email);
        usuario.setPassword(request.getParameter("password"));
        usuario.setTipo(Usuario.Tipo.ESTUDIANTE);
        usuario.setEstado(Usuario.Estado.ACTIVO);
        usuario.setAvatar("default-avatar.png");
        
        // Crear usuario en base de datos
        int userId = usuarioDAO.crearUsuario(usuario);
        if (userId > 0) {
            // Crear estudiante
            Estudiante estudiante = new Estudiante();
            estudiante.setId(userId);
            estudiante.setCodigoEstudiante(codigo);
            estudiante.setCarreraId(Integer.parseInt(request.getParameter("carrera_id")));
            estudiante.setEstadoTesis("SIN_ENVIAR");
            
            usuarioDAO.crearEstudiante(estudiante);
            
            // Registrar actividad
            registrarActividad(request, "CREACION_ESTUDIANTE", 
                "Estudiante creado: " + usuario.getNombre() + " " + usuario.getApellido());
            
            return "✅ Estudiante creado exitosamente";
        }
        
        return "Error al crear estudiante";
    }
    
    private String crearDocente(HttpServletRequest request) {
        String email = request.getParameter("email");
        
        // Validar email único
        if (usuarioDAO.existeEmail(email)) {
            return "El email ya está registrado";
        }
        
        // Crear usuario base
        Usuario usuario = new Usuario();
        usuario.setNombre(request.getParameter("nombre"));
        usuario.setApellido(request.getParameter("apellido"));
        usuario.setEmail(email);
        usuario.setPassword(request.getParameter("password"));
        usuario.setTipo(Usuario.Tipo.DOCENTE);
        usuario.setEstado(Usuario.Estado.ACTIVO);
        usuario.setAvatar("default-avatar.png");
        
        // Crear usuario en base de datos
        int userId = usuarioDAO.crearUsuario(usuario);
        if (userId > 0) {
            // Crear docente
            Docente docente = new Docente();
            docente.setId(userId);
            docente.setEspecialidad(request.getParameter("especialidad"));
            docente.setTitulo(request.getParameter("titulo"));
            docente.setCapacidadMaxima(Integer.parseInt(request.getParameter("capacidad_maxima")));
            docente.setTesisAsignadas(0);
            docente.setCargaTrabajo(0.0);
            docente.setActivo(true);
            
            usuarioDAO.crearDocente(docente);
            
            // Registrar actividad
            registrarActividad(request, "CREACION_DOCENTE", 
                "Docente creado: " + usuario.getNombre() + " " + usuario.getApellido());
            
            return "✅ Docente creado exitosamente";
        }
        
        return "Error al crear docente";
    }
    
    private void listarUsuarios(HttpServletRequest request, HttpServletResponse response) 
            throws ServletException, IOException {
        
        String tipo = request.getParameter("tipo");
        
        if ("ESTUDIANTE".equalsIgnoreCase(tipo)) {
            List<Estudiante> estudiantes = usuarioDAO.obtenerTodosEstudiantes();
            request.setAttribute("usuarios", estudiantes);
        } else if ("DOCENTE".equalsIgnoreCase(tipo)) {
            List<Docente> docentes = usuarioDAO.obtenerTodosDocentes();
            request.setAttribute("usuarios", docentes);
        } else {
            List<Usuario> usuarios = usuarioDAO.obtenerTodosUsuarios();
            request.setAttribute("usuarios", usuarios);
        }
        
        request.setAttribute("tipoFiltro", tipo);
        
        // Para AJAX - JSON manual
        if ("true".equals(request.getParameter("ajax"))) {
            enviarJSON(response, request.getAttribute("usuarios"));
            return;
        }
        
        RequestDispatcher dispatcher = request.getRequestDispatcher("admin/listar-usuarios.jsp");
        dispatcher.forward(request, response);
    }
    
    private void obtenerUsuarioPorId(HttpServletRequest request, HttpServletResponse response) 
            throws ServletException, IOException {
        
        int id = Integer.parseInt(request.getParameter("id"));
        Usuario usuario = usuarioDAO.obtenerUsuarioPorId(id);
        
        if (usuario != null) {
            request.setAttribute("usuario", usuario);
            
            if ("true".equals(request.getParameter("ajax"))) {
                enviarJSON(response, usuario);
                return;
            }
        }
        
        RequestDispatcher dispatcher = request.getRequestDispatcher("admin/detalle-usuario.jsp");
        dispatcher.forward(request, response);
    }
    
    private void obtenerUsuarioPorEmail(HttpServletRequest request, HttpServletResponse response) 
            throws ServletException, IOException {
        
        String email = request.getParameter("email");
        Usuario usuario = usuarioDAO.obtenerUsuarioPorEmail(email);
        
        if (usuario != null) {
            enviarJSON(response, usuario);
        } else {
            response.setStatus(HttpServletResponse.SC_NOT_FOUND);
            response.getWriter().write("{\"error\": \"Usuario no encontrado\"}");
        }
    }
    
    private void listarEstudiantes(HttpServletRequest request, HttpServletResponse response) 
            throws ServletException, IOException {
        
        List<Estudiante> estudiantes = usuarioDAO.obtenerTodosEstudiantes();
        request.setAttribute("estudiantes", estudiantes);
        
        if ("true".equals(request.getParameter("ajax"))) {
            enviarJSON(response, estudiantes);
            return;
        }
        
        RequestDispatcher dispatcher = request.getRequestDispatcher("admin/listar-estudiantes.jsp");
        dispatcher.forward(request, response);
    }
    
    private void listarDocentes(HttpServletRequest request, HttpServletResponse response) 
            throws ServletException, IOException {
        
        List<Docente> docentes = usuarioDAO.obtenerTodosDocentes();
        request.setAttribute("docentes", docentes);
        
        if ("true".equals(request.getParameter("ajax"))) {
            enviarJSON(response, docentes);
            return;
        }
        
        RequestDispatcher dispatcher = request.getRequestDispatcher("admin/listar-docentes.jsp");
        dispatcher.forward(request, response);
    }
    
    private void listarDocentesDisponibles(HttpServletRequest request, HttpServletResponse response) 
            throws ServletException, IOException {
        
        List<Docente> docentes = usuarioDAO.obtenerDocentesDisponibles();
        
        if ("true".equals(request.getParameter("ajax"))) {
            enviarJSON(response, docentes);
            return;
        }
        
        request.setAttribute("docentesDisponibles", docentes);
    }
    
    private void obtenerEstadisticas(HttpServletRequest request, HttpServletResponse response) 
            throws ServletException, IOException {
        
        int estudiantesActivos = usuarioDAO.contarEstudiantesActivos();
        int docentesActivos = usuarioDAO.contarDocentesActivos();
        double cargaPromedio = usuarioDAO.obtenerCargaPromedioDocentes();
        
        // Para AJAX - JSON manual
        if ("true".equals(request.getParameter("ajax"))) {
            response.setContentType("application/json");
            response.setCharacterEncoding("UTF-8");
            PrintWriter out = response.getWriter();
            
            String json = String.format(
                "{\"estudiantesActivos\":%d, \"docentesActivos\":%d, \"cargaPromedio\":%.2f}",
                estudiantesActivos, docentesActivos, cargaPromedio
            );
            out.print(json);
            out.flush();
            return;
        }
        
        // Para vista JSP
        request.setAttribute("estudiantesActivos", estudiantesActivos);
        request.setAttribute("docentesActivos", docentesActivos);
        request.setAttribute("cargaPromedio", cargaPromedio);
    }
    
    private void testBaseDatos(HttpServletRequest request, HttpServletResponse response) 
            throws ServletException, IOException {
        
        String resultado = usuarioDAO.testDatabase();
        request.setAttribute("resultado", resultado);
        
        RequestDispatcher dispatcher = request.getRequestDispatcher("admin/test-db.jsp");
        dispatcher.forward(request, response);
    }
    
    // ============= MÉTODOS AUXILIARES =============
    
    /**
     * Método para enviar objetos como JSON manualmente
     */
    private void enviarJSON(HttpServletResponse response, Object obj) throws IOException {
        response.setContentType("application/json");
        response.setCharacterEncoding("UTF-8");
        PrintWriter out = response.getWriter();
        
        if (obj instanceof List) {
            out.print(convertirListaAJSON((List<?>) obj));
        } else if (obj instanceof Usuario) {
            out.print(convertirUsuarioAJSON((Usuario) obj));
        } else if (obj instanceof Estudiante) {
            out.print(convertirEstudianteAJSON((Estudiante) obj));
        } else if (obj instanceof Docente) {
            out.print(convertirDocenteAJSON((Docente) obj));
        } else {
            out.print("{\"error\": \"Tipo de objeto no soportado\"}");
        }
        
        out.flush();
    }
    
    /**
     * Convertir lista a JSON manualmente
     */
    private String convertirListaAJSON(List<?> lista) {
        StringBuilder json = new StringBuilder("[");
        
        for (int i = 0; i < lista.size(); i++) {
            Object obj = lista.get(i);
            
            if (obj instanceof Usuario) {
                json.append(convertirUsuarioAJSON((Usuario) obj));
            } else if (obj instanceof Estudiante) {
                json.append(convertirEstudianteAJSON((Estudiante) obj));
            } else if (obj instanceof Docente) {
                json.append(convertirDocenteAJSON((Docente) obj));
            }
            
            if (i < lista.size() - 1) {
                json.append(",");
            }
        }
        
        json.append("]");
        return json.toString();
    }
    
    /**
     * Convertir Usuario a JSON manualmente
     */
    private String convertirUsuarioAJSON(Usuario usuario) {
        return String.format(
            "{\"id\":%d,\"nombre\":\"%s\",\"apellido\":\"%s\",\"email\":\"%s\",\"tipo\":\"%s\",\"estado\":\"%s\"}",
            usuario.getId(),
            escapeJSON(usuario.getNombre()),
            escapeJSON(usuario.getApellido()),
            escapeJSON(usuario.getEmail()),
            usuario.getTipo(),
            usuario.getEstado()
        );
    }
    
    /**
     * Convertir Estudiante a JSON manualmente
     */
    private String convertirEstudianteAJSON(Estudiante estudiante) {
        return String.format(
            "{\"id\":%d,\"nombre\":\"%s\",\"apellido\":\"%s\",\"email\":\"%s\",\"codigo\":\"%s\",\"carrera\":\"%s\"}",
            estudiante.getId(),
            escapeJSON(estudiante.getNombre()),
            escapeJSON(estudiante.getApellido()),
            escapeJSON(estudiante.getEmail()),
            escapeJSON(estudiante.getCodigoEstudiante()),
            escapeJSON(estudiante.getCarrera())
        );
    }
    
    /**
     * Convertir Docente a JSON manualmente
     */
    private String convertirDocenteAJSON(Docente docente) {
        return String.format(
            "{\"id\":%d,\"nombre\":\"%s\",\"apellido\":\"%s\",\"email\":\"%s\",\"especialidad\":\"%s\",\"carga\":%.2f}",
            docente.getId(),
            escapeJSON(docente.getNombre()),
            escapeJSON(docente.getApellido()),
            escapeJSON(docente.getEmail()),
            escapeJSON(docente.getEspecialidad()),
            docente.getCargaTrabajo()
        );
    }
    
    /**
     * Escapar caracteres especiales para JSON
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
    
    private void registrarActividad(HttpServletRequest request, String tipoAccion, String descripcion) {
        HttpSession session = request.getSession(false);
        if (session != null) {
            Integer usuarioId = (Integer) session.getAttribute("usuario_id");
            if (usuarioId != null) {
                System.out.println("📝 Actividad [" + tipoAccion + "]: " + descripcion + " (Usuario ID: " + usuarioId + ")");
            }
        }
    }
    
    // Métodos pendientes (para completar según necesidad)
    private void actualizarUsuario(HttpServletRequest request, HttpServletResponse response) 
            throws ServletException, IOException {
        // Implementar actualización
    }
    
    private void eliminarUsuario(HttpServletRequest request, HttpServletResponse response) 
            throws ServletException, IOException {
        // Implementar eliminación
    }
    
    private void cambiarEstadoUsuario(HttpServletRequest request, HttpServletResponse response) 
            throws ServletException, IOException {
        // Implementar cambio de estado
    }
    
    private void actualizarPassword(HttpServletRequest request, HttpServletResponse response) 
            throws ServletException, IOException {
        // Implementar actualización de contraseña
    }
}