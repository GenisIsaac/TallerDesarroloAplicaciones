package Controlador;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import java.io.IOException;

@WebServlet("/logout")
public class LogoutServlet extends HttpServlet {
    
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) 
            throws ServletException, IOException {
        cerrarSesionYRedirigir(request, response);
    }
    
    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) 
            throws ServletException, IOException {
        cerrarSesionYRedirigir(request, response);
    }
    
    private void cerrarSesionYRedirigir(HttpServletRequest request, HttpServletResponse response) 
            throws IOException {
        
        HttpSession session = request.getSession(false);
        
        if (session != null) {
            // Registrar el cierre de sesión (opcional)
            String usuarioNombre = (String) session.getAttribute("usuarioNombre");
            System.out.println("Cerrando sesión para usuario: " + usuarioNombre);
            
            // Invalidar la sesión
            session.invalidate();
            
            // Eliminar cookie de sesión del navegador
            jakarta.servlet.http.Cookie[] cookies = request.getCookies();
            if (cookies != null) {
                for (jakarta.servlet.http.Cookie cookie : cookies) {
                    if ("JSESSIONID".equals(cookie.getName())) {
                        cookie.setMaxAge(0);
                        cookie.setPath(request.getContextPath());
                        response.addCookie(cookie);
                        break;
                    }
                }
            }
        }
        
        // Redirigir al index.jsp
        response.sendRedirect(request.getContextPath() + "/index.jsp");
    }
}