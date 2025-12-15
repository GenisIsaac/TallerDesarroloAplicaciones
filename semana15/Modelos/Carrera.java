/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package Modelos;

/**
 *
 * @author WindowsPC
 */
public class Carrera {
    private int id;
    private String nombre;
    private String facultad;
    private String coordinador;
    private int duracionSemestres;
    private boolean activa;

    // Constructores
    public Carrera() {}

    public Carrera(int id, String nombre, String facultad, String coordinador, 
                   int duracionSemestres, boolean activa) {
        this.id = id;
        this.nombre = nombre;
        this.facultad = facultad;
        this.coordinador = coordinador;
        this.duracionSemestres = duracionSemestres;
        this.activa = activa;
    }

    // Getters y Setters
    public int getId() { return id; }
    public void setId(int id) { this.id = id; }

    public String getNombre() { return nombre; }
    public void setNombre(String nombre) { this.nombre = nombre; }

    public String getFacultad() { return facultad; }
    public void setFacultad(String facultad) { this.facultad = facultad; }

    public String getCoordinador() { return coordinador; }
    public void setCoordinador(String coordinador) { this.coordinador = coordinador; }

    public int getDuracionSemestres() { return duracionSemestres; }
    public void setDuracionSemestres(int duracionSemestres) { this.duracionSemestres = duracionSemestres; }

    public boolean isActiva() { return activa; }
    public void setActiva(boolean activa) { this.activa = activa; }
}
