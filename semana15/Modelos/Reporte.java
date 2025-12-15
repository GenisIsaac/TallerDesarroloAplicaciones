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
public class Reporte {
    private int id;
    private String tipo;
    private Date fechaGeneracion;
    private String parametros;
    private String archivo;
    private int idUsuarioGenerador;

    // Constructores
    public Reporte() {}

    public Reporte(int id, String tipo, Date fechaGeneracion, String parametros, 
                   String archivo, int idUsuarioGenerador) {
        this.id = id;
        this.tipo = tipo;
        this.fechaGeneracion = fechaGeneracion;
        this.parametros = parametros;
        this.archivo = archivo;
        this.idUsuarioGenerador = idUsuarioGenerador;
    }

    // Getters y Setters
    public int getId() { return id; }
    public void setId(int id) { this.id = id; }

    public String getTipo() { return tipo; }
    public void setTipo(String tipo) { this.tipo = tipo; }

    public Date getFechaGeneracion() { return fechaGeneracion; }
    public void setFechaGeneracion(Date fechaGeneracion) { this.fechaGeneracion = fechaGeneracion; }

    public String getParametros() { return parametros; }
    public void setParametros(String parametros) { this.parametros = parametros; }

    public String getArchivo() { return archivo; }
    public void setArchivo(String archivo) { this.archivo = archivo; }

    public int getIdUsuarioGenerador() { return idUsuarioGenerador; }
    public void setIdUsuarioGenerador(int idUsuarioGenerador) { this.idUsuarioGenerador = idUsuarioGenerador; }
}