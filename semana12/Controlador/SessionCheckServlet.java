/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package Controlador;

import Modelos.Usuario;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import java.io.IOException;
import java.io.PrintWriter;

/**
 *
 * @author WindowsPC
 */
@WebServlet(name = "SessionCheckServlet", urlPatterns = {"/checkSession"})
public class SessionCheckServlet extends HttpServlet {
    
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) 
            throws ServletException, IOException {
        
        response.setContentType("application/json");
        response.setCharacterEncoding("UTF-8");
        PrintWriter out = response.getWriter();
        
        try {
            HttpSession session = request.getSession(false);
            
            if (session != null) {
                Usuario usuario = (Usuario) session.getAttribute("usuario");
                
                if (usuario != null) {
                    String jsonResponse = String.format(
                        "{\"loggedIn\": true, " +
                        "\"usuarioId\": %d, " +
                        "\"nombre\": \"%s\", " +
                        "\"email\": \"%s\", " +
                        "\"tipo\": \"%s\", " +
                        "\"redirectUrl\": \"%s\"}",
                        usuario.getId(),
                        usuario.getNombre() + " " + usuario.getApellido(),
                        usuario.getEmail(),
                        usuario.getTipo().toString(),
                        determinarRedirectUrl(usuario)
                    );
                    out.print(jsonResponse);
                } else {
                    out.print("{\"loggedIn\": false}");
                }
            } else {
                out.print("{\"loggedIn\": false}");
            }
            
        } catch (Exception e) {
            out.print("{\"loggedIn\": false, \"error\": \"" + e.getMessage().replace("\"", "\\\"") + "\"}");
        } finally {
            out.flush();
            out.close();
        }
    }
    
    private String determinarRedirectUrl(Usuario usuario) {
        if (usuario == null) return "index.html";
        
        switch (usuario.getTipo().toString()) {
            case "ADMINISTRADOR":
                return "administrador.jsp";
            case "DOCENTE":
                return "Docente.jsp";
            case "ESTUDIANTE":
                return "estudiante.jsp";
            default:
                return "index.jsp";
        }
    }
}