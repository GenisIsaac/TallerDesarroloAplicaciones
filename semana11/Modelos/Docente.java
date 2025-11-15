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
    private String titulo;
    private int tesisAsignadas;
    private int capacidadMaxima;
    private double cargaTrabajo;
    private List<Integer> tesisAsignadasIds;

    // Constructores
    public Docente() {
        this.tesisAsignadasIds = new ArrayList<>();
    }

    public Docente(int id, String nombre, String apellido, String email, String tipo, 
                   String estado, String fechaRegistro, String password, String avatar,
                   String especialidad, String titulo, int tesisAsignadas, 
                   int capacidadMaxima, double cargaTrabajo, List<Integer> tesisAsignadasIds) {
        super(id, nombre, apellido, email, tipo, estado, fechaRegistro, password, avatar);
        this.especialidad = especialidad;
        this.titulo = titulo;
        this.tesisAsignadas = tesisAsignadas;
        this.capacidadMaxima = capacidadMaxima;
        this.cargaTrabajo = cargaTrabajo;
        this.tesisAsignadasIds = tesisAsignadasIds != null ? tesisAsignadasIds : new ArrayList<>();
    }

    // Getters y Setters
    public String getEspecialidad() { return especialidad; }
    public void setEspecialidad(String especialidad) { this.especialidad = especialidad; }

    public String getTitulo() { return titulo; }
    public void setTitulo(String titulo) { this.titulo = titulo; }

    public int getTesisAsignadas() { return tesisAsignadas; }
    public void setTesisAsignadas(int tesisAsignadas) { this.tesisAsignadas = tesisAsignadas; }

    public int getCapacidadMaxima() { return capacidadMaxima; }
    public void setCapacidadMaxima(int capacidadMaxima) { this.capacidadMaxima = capacidadMaxima; }

    public double getCargaTrabajo() { return cargaTrabajo; }
    public void setCargaTrabajo(double cargaTrabajo) { this.cargaTrabajo = cargaTrabajo; }

    public List<Integer> getTesisAsignadasIds() { return tesisAsignadasIds; }
    public void setTesisAsignadasIds(List<Integer> tesisAsignadasIds) { this.tesisAsignadasIds = tesisAsignadasIds; }

    // Método auxiliar para agregar tesis
    public void agregarTesisAsignada(int idTesis) {
        if (!this.tesisAsignadasIds.contains(idTesis)) {
            this.tesisAsignadasIds.add(idTesis);
            this.tesisAsignadas = this.tesisAsignadasIds.size();
            this.cargaTrabajo = (double) this.tesisAsignadas / this.capacidadMaxima * 100;
        }
    }
}
