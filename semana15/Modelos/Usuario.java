/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package Modelos;

import java.sql.Timestamp;

/**
 *
 * @author WindowsPC
 */
public class Usuario {
     private int id;
    private String nombre;
    private String apellido;
    private String email;
    private String password;
    private Tipo tipo;
    private Estado estado;
    private String avatar;
    private Timestamp fechaRegistro;
    private Timestamp ultimoAcceso;
    
    // Campos adicionales según tipo
    private String codigoEstudiante;
    private String especialidad;
    private Integer carreraId;
    
    public enum Tipo {
        ESTUDIANTE, DOCENTE, ADMINISTRADOR
    }
    
    public enum Estado {
        ACTIVO, INACTIVO, SOBRECARGADO
    }
    
    // Getters y Setters
    public int getId() { return id; }
    public void setId(int id) { this.id = id; }
    
    public String getNombre() { return nombre; }
    public void setNombre(String nombre) { this.nombre = nombre; }
    
    public String getApellido() { return apellido; }
    public void setApellido(String apellido) { this.apellido = apellido; }
    
    public String getEmail() { return email; }
    public void setEmail(String email) { this.email = email; }
    
    public String getPassword() { return password; }
    public void setPassword(String password) { this.password = password; }
    
    public Tipo getTipo() { return tipo; }
    public void setTipo(Tipo tipo) { this.tipo = tipo; }
    
    public Estado getEstado() { return estado; }
    public void setEstado(Estado estado) { this.estado = estado; }
    
    public String getAvatar() { return avatar; }
    public void setAvatar(String avatar) { this.avatar = avatar; }
    
    public Timestamp getFechaRegistro() { return fechaRegistro; }
    public void setFechaRegistro(Timestamp fechaRegistro) { this.fechaRegistro = fechaRegistro; }
    
    public Timestamp getUltimoAcceso() { return ultimoAcceso; }
    public void setUltimoAcceso(Timestamp ultimoAcceso) { this.ultimoAcceso = ultimoAcceso; }
    
    public String getCodigoEstudiante() { return codigoEstudiante; }
    public void setCodigoEstudiante(String codigoEstudiante) { this.codigoEstudiante = codigoEstudiante; }
    
    public String getEspecialidad() { return especialidad; }
    public void setEspecialidad(String especialidad) { this.especialidad = especialidad; }
    
    public Integer getCarreraId() { return carreraId; }
    public void setCarreraId(Integer carreraId) { this.carreraId = carreraId; }
    
    // Método helper
    public String getNombreCompleto() {
        return nombre + " " + apellido;
    }
}