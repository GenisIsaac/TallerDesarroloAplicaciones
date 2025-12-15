package Controlador;

import DAO.UsuarioDAO;
import Modelos.Usuario;
import jakarta.servlet.*;
import jakarta.servlet.http.*;
import jakarta.servlet.annotation.*;
import java.io.IOException;

@WebServlet("/LoginController")
public class LoginController extends HttpServlet {
    
    private UsuarioDAO usuarioDAO;
    
    @Override
    public void init() {
        usuarioDAO = new UsuarioDAO();
    }
    
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) 
            throws ServletException, IOException {
        
        // Cerrar sesión
        String action = request.getParameter("action");
        if ("logout".equals(action)) {
            System.out.println("=== CERRANDO SESIÓN ===");
            request.getSession().invalidate();
            response.sendRedirect("index.jsp");
            return;
        }
        
        response.sendRedirect("index.jsp");
    }
    
    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) 
            throws ServletException, IOException {
        
        String email = request.getParameter("email");
        String password = request.getParameter("password");
        
        System.out.println("🔐 Intento de login para: " + email);
        
        // Validar campos
        if (email == null || password == null || email.trim().isEmpty() || password.trim().isEmpty()) {
            System.out.println("❌ Campos vacíos");
            request.setAttribute("error", "Email y contraseña son obligatorios");
            request.getRequestDispatcher("index.jsp").forward(request, response);
            return;
        }
        
        // Autenticar usuario
        Usuario usuario = usuarioDAO.login(email.trim(), password.trim());
        
        if (usuario != null) {
            System.out.println("✅ Login exitoso: " + usuario.getNombre() + " | Tipo: " + usuario.getTipo());
            
            // Crear sesión CON LOS ATRIBUTOS CORRECTOS
            HttpSession session = request.getSession();
            session.setAttribute("usuario_id", usuario.getId());
            session.setAttribute("usuario_nombre", usuario.getNombre() + " " + usuario.getApellido());
            session.setAttribute("usuario_email", usuario.getEmail());
            session.setAttribute("usuario_tipo", usuario.getTipo().toString()); // Convertir a String
            
            System.out.println("📝 Atributos de sesión establecidos:");
            System.out.println("   - usuario_id: " + session.getAttribute("usuario_id"));
            System.out.println("   - usuario_nombre: " + session.getAttribute("usuario_nombre"));
            System.out.println("   - usuario_tipo: " + session.getAttribute("usuario_tipo"));
            
            // Actualizar último acceso
            usuarioDAO.actualizarUltimoAcceso(usuario.getId());
            
            // Redirigir según tipo de usuario
            String tipoUsuario = usuario.getTipo().toString();
            System.out.println("🔄 Redirigiendo según tipo: " + tipoUsuario);
            
            switch (tipoUsuario) {
                case "ADMINISTRADOR":
                    response.sendRedirect("admin/admin-dashboard.jsp");
                    break;
                case "DOCENTE":
                    response.sendRedirect("docente/dashboard.jsp");
                    break;
                case "ESTUDIANTE":
                    // IMPORTANTE: Redirigir al EstudianteController, no al JSP directamente
                    System.out.println("🎓 Redirigiendo a EstudianteController");
                    response.sendRedirect("EstudianteController");
                    break;
                default:
                    System.out.println("⚠️ Tipo de usuario desconocido");
                    response.sendRedirect("index.jsp");
            }
        } else {
            System.out.println("❌ Login fallido para: " + email);
            request.setAttribute("error", "Credenciales incorrectas");
            request.getRequestDispatcher("index.jsp").forward(request, response);
        }
    }
}