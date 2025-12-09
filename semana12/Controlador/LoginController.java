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
            request.getSession().invalidate();
            response.sendRedirect("index.jsp");
            return;
        }
        
        response.sendRedirect("login.jsp");
    }
    
    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) 
            throws ServletException, IOException {
        
        String email = request.getParameter("email");
        String password = request.getParameter("password");
        
        System.out.println("🔐 Login attempt: " + email);
        
        // Validar campos
        if (email == null || password == null || email.trim().isEmpty() || password.trim().isEmpty()) {
            request.setAttribute("error", "Email y contraseña son obligatorios");
            request.getRequestDispatcher("index.jsp").forward(request, response);
            return;
        }
        
        // Autenticar usuario
        Usuario usuario = usuarioDAO.login(email.trim(), password.trim());
        
        if (usuario != null) {
            System.out.println("✅ Login successful for: " + usuario.getNombre());
            
            // Crear sesión
            HttpSession session = request.getSession();
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
                    response.sendRedirect("index.jsp");
            }
        } else {
            System.out.println("❌ Login failed for: " + email);
            request.setAttribute("error", "Credenciales incorrectas");
            request.getRequestDispatcher("index.jsp").forward(request, response);
        }
    }
}