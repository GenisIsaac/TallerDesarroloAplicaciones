/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package Modelos;

import java.util.ArrayList;
import java.util.List;

/**
 *
 * @author WindowsPC
 */
public class Docente extends Usuario {
    private String especialidad;
    private String titulo = "Prof."; // Valor por defecto esencial
    private int tesisAsignadas = 0; // Valor por defecto esencial
    private int capacidadMaxima = 5; // Valor por defecto esencial
    private double cargaTrabajo = 0.0; // Valor por defecto esencial
    private boolean activo = true; // Valor por defecto esencial
    private List<Integer> tesisAsignadasIds = new ArrayList<>();

    // Constructores
    public Docente() {
        super();
        this.setTipo(Tipo.DOCENTE);
    }

    // Getters y Setters
    public String getEspecialidad() { return especialidad; }
    public void setEspecialidad(String especialidad) { this.especialidad = especialidad; }

    public String getTitulo() { return titulo; }
    public void setTitulo(String titulo) { 
        this.titulo = titulo != null ? titulo : "Prof."; 
    }

    public int getTesisAsignadas() { return tesisAsignadas; }
    public void setTesisAsignadas(int tesisAsignadas) { 
        this.tesisAsignadas = Math.max(tesisAsignadas, 0); 
    }

    public int getCapacidadMaxima() { return capacidadMaxima; }
    public void setCapacidadMaxima(int capacidadMaxima) { 
        this.capacidadMaxima = capacidadMaxima > 0 ? capacidadMaxima : 5; 
    }

    public double getCargaTrabajo() { return cargaTrabajo; }
    public void setCargaTrabajo(double cargaTrabajo) { 
        this.cargaTrabajo = Math.max(cargaTrabajo, 0.0); 
    }

    public boolean isActivo() { return activo; }
    public void setActivo(boolean activo) { this.activo = activo; }

    public List<Integer> getTesisAsignadasIds() { return tesisAsignadasIds; }
    public void setTesisAsignadasIds(List<Integer> tesisAsignadasIds) { 
        this.tesisAsignadasIds = tesisAsignadasIds != null ? tesisAsignadasIds : new ArrayList<>(); 
    }
}
