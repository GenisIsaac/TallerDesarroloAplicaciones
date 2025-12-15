/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package Modelos;

import java.util.Date;

/**
 *
 * @author WindowsPC
 */
public class Estudiante extends Usuario {
private String codigoEstudiante;
    private int carreraId;
    private String carrera;
    private String estadoTesis;
    private Date fechaInicio;
    private Date fechaEstimadaGraduacion;

    // Constructores
    public Estudiante() {
        super();
        this.setTipo(Tipo.ESTUDIANTE); // CAMBIA AQUÍ: Usa TipoUsuario
        this.estadoTesis = "SIN_ENVIAR";
    }
    
    // Constructor con parámetros básicos
    public Estudiante(String nombre, String apellido, String email, String codigoEstudiante, int carreraId) {
        super();
        this.setNombre(nombre);
        this.setApellido(apellido);
        this.setEmail(email);
        this.setTipo(Tipo.ESTUDIANTE);
        this.codigoEstudiante = codigoEstudiante;
        this.carreraId = carreraId;
        this.estadoTesis = "SIN_ENVIAR";
        this.setEstado(Estado.ACTIVO);
    }

    // Getters y Setters
    public String getCodigoEstudiante() { 
        return codigoEstudiante; 
    }
    
    public void setCodigoEstudiante(String codigoEstudiante) { 
        if (codigoEstudiante == null || codigoEstudiante.trim().isEmpty()) {
            throw new IllegalArgumentException("El código del estudiante no puede ser nulo o vacío");
        }
        this.codigoEstudiante = codigoEstudiante.trim(); 
    }


    public void setCarreraId(int carreraId) { 
        if (carreraId <= 0) {
            throw new IllegalArgumentException("El ID de carrera debe ser positivo");
        }
        this.carreraId = carreraId; 
    }

    public String getCarrera() { 
        return carrera; 
    }
    
    public void setCarrera(String carrera) { 
        this.carrera = carrera; 
    }

    public String getEstadoTesis() { 
        return estadoTesis; 
    }
    
    public void setEstadoTesis(String estadoTesis) { 
        // Validar que el estado sea uno de los permitidos
        if (estadoTesis != null) {
            String estadoUpper = estadoTesis.toUpperCase();
            if (estadoUpper.equals("SIN_ENVIAR") || 
                estadoUpper.equals("EN_REVISION") || 
                estadoUpper.equals("APROBADA") || 
                estadoUpper.equals("RECHAZADA")) {
                this.estadoTesis = estadoUpper;
            } else {
                this.estadoTesis = "SIN_ENVIAR";
            }
        } else {
            this.estadoTesis = "SIN_ENVIAR";
        }
    }

    public Date getFechaInicio() { 
        return fechaInicio; 
    }
    
    public void setFechaInicio(Date fechaInicio) { 
        this.fechaInicio = fechaInicio; 
    }

    public Date getFechaEstimadaGraduacion() { 
        return fechaEstimadaGraduacion; 
    }
    
    public void setFechaEstimadaGraduacion(Date fechaEstimadaGraduacion) { 
        this.fechaEstimadaGraduacion = fechaEstimadaGraduacion; 
    }
    
    // Métodos adicionales útiles
    public boolean tieneTesisEnRevision() {
        return "EN_REVISION".equals(estadoTesis);
    }
    
    public boolean tieneTesisAprobada() {
        return "APROBADA".equals(estadoTesis);
    }
    
    public boolean puedeEnviarTesis() {
        return "SIN_ENVIAR".equals(estadoTesis) || "RECHAZADA".equals(estadoTesis);
    }
    
    @Override
    public String toString() {
        return String.format("Estudiante{id=%d, código=%s, nombre=%s %s, estadoTesis=%s}", 
            getId(), codigoEstudiante, getNombre(), getApellido(), estadoTesis);
    }
}