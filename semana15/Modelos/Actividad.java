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
public class Actividad {
   private int id;
    private TipoActividad tipo = TipoActividad.SISTEMA; // Valor por defecto esencial
    private String descripcion;
    private int idUsuario;
    private String nombreUsuario;
    private Date fecha;
    private String entidadAfectada;
    private int idEntidadAfectada;

    // Constructores
    public Actividad() {}

    // Getters y Setters
    public int getId() { return id; }
    public void setId(int id) { this.id = id; }

    public TipoActividad getTipo() { 
        return tipo != null ? tipo : TipoActividad.SISTEMA; 
    }
    public void setTipo(TipoActividad tipo) { 
        this.tipo = tipo != null ? tipo : TipoActividad.SISTEMA; 
    }

    public String getDescripcion() { return descripcion; }
    public void setDescripcion(String descripcion) { this.descripcion = descripcion; }

    public int getIdUsuario() { return idUsuario; }
    public void setIdUsuario(int idUsuario) { this.idUsuario = idUsuario; }

    public String getNombreUsuario() { return nombreUsuario; }
    public void setNombreUsuario(String nombreUsuario) { this.nombreUsuario = nombreUsuario; }

    public Date getFecha() { return fecha; }
    public void setFecha(Date fecha) { this.fecha = fecha; }

    public String getEntidadAfectada() { return entidadAfectada; }
    public void setEntidadAfectada(String entidadAfectada) { this.entidadAfectada = entidadAfectada; }

    public int getIdEntidadAfectada() { return idEntidadAfectada; }
    public void setIdEntidadAfectada(int idEntidadAfectada) { this.idEntidadAfectada = idEntidadAfectada; }
}