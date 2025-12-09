/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package Controlador;

import jakarta.servlet.ServletException;
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
public class LogoutServlet extends HttpServlet {
    
   @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) 
            throws ServletException, IOException {
        
        response.setContentType("application/json");
        response.setCharacterEncoding("UTF-8");
        PrintWriter out = response.getWriter();
        
        try {
            HttpSession session = request.getSession(false);
            
            if (session != null) {
                System.out.println("Cerrando sesión para usuario: " + session.getAttribute("usuarioNombre"));
                session.invalidate();
                String jsonResponse = "{\"success\": true, \"message\": \"Sesión cerrada exitosamente\"}";
                out.print(jsonResponse);
            } else {
                String jsonResponse = "{\"success\": false, \"message\": \"No hay sesión activa\"}";
                out.print(jsonResponse);
            }
            
        } catch (Exception e) {
            String jsonResponse = "{\"success\": false, \"message\": \"Error al cerrar sesión: " + 
                                 e.getMessage().replace("\"", "\\\"") + "\"}";
            out.print(jsonResponse);
        } finally {
            out.flush();
            out.close();
        }
    }
    
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) 
            throws ServletException, IOException {
        doPost(request, response);
    }
}
