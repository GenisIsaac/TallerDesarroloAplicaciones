/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package Controlador;
import DAO.UsuarioDAO;
import Modelos.Usuario;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import java.io.IOException;
import java.io.PrintWriter;

@WebServlet(name = "LoginServlet", urlPatterns = {"/login"})
public class LoginServlet extends HttpServlet {
    
    private UsuarioDAO usuarioDAO;
    
    @Override
    public void init() throws ServletException {
        try {
            System.out.println("=== INICIALIZANDO LOGINSERVLET ===");
            usuarioDAO = new UsuarioDAO();
            System.out.println("UsuarioDAO creado exitosamente");
        } catch (Exception e) {
            System.err.println("ERROR CRÍTICO al inicializar LoginServlet: " + e.getMessage());
            e.printStackTrace();
            throw new ServletException("Error al inicializar LoginServlet", e);
        }
    }
    
    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) 
            throws ServletException, IOException {
        
        System.out.println("\n=== RECIBIENDO PETICIÓN POST EN /login ===");
        
        // Configurar respuesta
        response.setContentType("application/json");
        response.setCharacterEncoding("UTF-8");
        
        PrintWriter out = null;
        
        try {
            out = response.getWriter();
            
            // Verificar que tenemos parámetros
            System.out.println("Verificando parámetros...");
            
            String email = request.getParameter("email");
            String password = request.getParameter("password");
            
            System.out.println("Parámetro 'email': " + (email != null ? email : "NULL"));
            System.out.println("Parámetro 'password': " + (password != null ? "[PROVIDED]" : "NULL"));
            
            // Validar parámetros básicos
            if (email == null || email.trim().isEmpty()) {
                System.out.println("Email está vacío");
                out.print("{\"success\": false, \"message\": \"Email es requerido\"}");
                return;
            }
            
            if (password == null || password.trim().isEmpty()) {
                System.out.println("Password está vacío");
                out.print("{\"success\": false, \"message\": \"Contraseña es requerida\"}");
                return;
            }
            
            email = email.trim().toLowerCase();
            password = password.trim();
            
            System.out.println("Procesando login para: " + email);
            
            // Llamar al DAO
            Usuario usuario = null;
            try {
                System.out.println("Llamando a usuarioDAO.login()...");
                usuario = usuarioDAO.login(email, password);
            } catch (Exception e) {
                System.err.println("ERROR en usuarioDAO.login(): " + e.getMessage());
                e.printStackTrace();
                out.print("{\"success\": false, \"message\": \"Error al acceder a la base de datos: " + 
                          e.getMessage().replace("\"", "'") + "\"}");
                return;
            }
            
            if (usuario != null) {
                System.out.println("Usuario encontrado: " + usuario.getNombre() + " " + usuario.getApellido());
                System.out.println("Tipo: " + usuario.getTipo());
                System.out.println("Estado: " + usuario.getEstado());
                
                // Verificar estado
                if (!usuario.getEstado().toString().equals("ACTIVO")) {
                    System.out.println("Usuario inactivo");
                    out.print("{\"success\": false, \"message\": \"Tu cuenta no está activa\"}");
                    return;
                }
                
                // Crear sesión - IMPORTANTE: usar los nombres de atributos que espera EstudianteController
                HttpSession session = request.getSession(true);
                session.setAttribute("usuario", usuario);
                session.setAttribute("usuario_id", usuario.getId());  // ESTE es el atributo CRÍTICO que espera EstudianteController
                session.setAttribute("usuario_nombre", usuario.getNombre() + " " + usuario.getApellido());
                session.setAttribute("usuario_tipo", usuario.getTipo().toString());  // ESTE es el otro atributo crítico
                session.setAttribute("usuario_email", usuario.getEmail());
                
                System.out.println("Sesión creada para ID: " + usuario.getId());
                System.out.println("Atributos de sesión establecidos:");
                System.out.println("  - usuario_id: " + session.getAttribute("usuario_id"));
                System.out.println("  - usuario_tipo: " + session.getAttribute("usuario_tipo"));
                
                // Determinar redirección
                String redirectUrl = "";
                String tipoUsuario = usuario.getTipo().toString();
                
                switch (tipoUsuario) {
                    case "ADMINISTRADOR":
                        redirectUrl = "administrador.jsp";
                        break;
                    case "DOCENTE":
                        redirectUrl = "docente.jsp";
                        break;
                    case "ESTUDIANTE":
                        // CAMBIO CRÍTICO: Redirigir al EstudianteController, NO al JSP directamente
                       // Redirigir al controlador en lugar del JSP directamente
    redirectUrl = "estudiante.jsp";
                        break;
                    default:
                        redirectUrl = "index.jsp";
                }
                
                System.out.println("Redirigiendo a: " + redirectUrl);
                
                // Enviar respuesta exitosa
                String json = String.format(
                    "{\"success\": true, \"redirectUrl\": \"%s\", \"message\": \"Login exitoso\"}", 
                    redirectUrl
                );
                
                System.out.println("Enviando respuesta JSON: " + json);
                out.print(json);
                
            } else {
                System.out.println("Usuario no encontrado o credenciales incorrectas");
                out.print("{\"success\": false, \"message\": \"Email o contraseña incorrectos\"}");
            }
            
        } catch (Exception e) {
            System.err.println("ERROR GENERAL en doPost(): " + e.getMessage());
            e.printStackTrace();
            
            // Intentar enviar error
            try {
                if (out != null) {
                    out.print("{\"success\": false, \"message\": \"Error interno del servidor: " + 
                              e.getMessage().replace("\"", "'") + "\"}");
                } else {
                    response.getWriter().print("{\"success\": false, \"message\": \"Error interno\"}");
                }
            } catch (Exception ex) {
                // No podemos hacer nada más
                System.err.println("ERROR al enviar mensaje de error: " + ex.getMessage());
            }
        } finally {
            if (out != null) {
                out.flush();
                out.close();
            }
            System.out.println("=== FIN DE PETICIÓN ===\n");
        }
    }
    
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) 
            throws ServletException, IOException {
        System.out.println("=== RECIBIENDO GET EN /login ===");
        response.setContentType("application/json");
        response.setCharacterEncoding("UTF-8");
        PrintWriter out = response.getWriter();
        out.print("{\"status\": \"ok\", \"message\": \"LoginServlet está funcionando. Usa POST para login.\"}");
        out.flush();
        out.close();
    }
}