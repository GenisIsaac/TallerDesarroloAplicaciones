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
    private String carrera;
    private String codigoEstudiante;
    private String estadoTesis;
    private int idTesis;
    private Date fechaInicio;
    private Date fechaEstimadaGraduacion;

    // Constructores
    public Estudiante() {}

    public Estudiante(int id, String nombre, String apellido, String email, String tipo, 
                      String estado, String fechaRegistro, String password, String avatar,
                      String carrera, String codigoEstudiante, String estadoTesis, 
                      int idTesis, Date fechaInicio, Date fechaEstimadaGraduacion) {
        super(id, nombre, apellido, email, tipo, estado, fechaRegistro, password, avatar);
        this.carrera = carrera;
        this.codigoEstudiante = codigoEstudiante;
        this.estadoTesis = estadoTesis;
        this.idTesis = idTesis;
        this.fechaInicio = fechaInicio;
        this.fechaEstimadaGraduacion = fechaEstimadaGraduacion;
    }

    // Getters y Setters
    public String getCarrera() { return carrera; }
    public void setCarrera(String carrera) { this.carrera = carrera; }

    public String getCodigoEstudiante() { return codigoEstudiante; }
    public void setCodigoEstudiante(String codigoEstudiante) { this.codigoEstudiante = codigoEstudiante; }

    public String getEstadoTesis() { return estadoTesis; }
    public void setEstadoTesis(String estadoTesis) { this.estadoTesis = estadoTesis; }

    public int getIdTesis() { return idTesis; }
    public void setIdTesis(int idTesis) { this.idTesis = idTesis; }

    public Date getFechaInicio() { return fechaInicio; }
    public void setFechaInicio(Date fechaInicio) { this.fechaInicio = fechaInicio; }

    public Date getFechaEstimadaGraduacion() { return fechaEstimadaGraduacion; }
    public void setFechaEstimadaGraduacion(Date fechaEstimadaGraduacion) { this.fechaEstimadaGraduacion = fechaEstimadaGraduacion; }
}