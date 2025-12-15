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
public class Tesis {
    private int id;
    private int estudianteId;
    private int docenteId;
    private int carreraId;
    private String titulo;
    private String descripcion;
    private String estado = "PENDIENTE"; // Valor por defecto compatible con controlador
    private String archivo;
    private Date fechaEntrega;
    private Date fechaLimiteRevision;
    private String areaEstudio;
    private String comentarios;
    private double calificacion = 0.0; // Valor por defecto esencial
    private Date fechaCreacion;
    private Date fechaUltimaModificacion;
    private String palabrasClave;
    private String nivelEstudio;
    private int semestre;
    private int anoAcademico;
    private String resumen; // Puede ser alias de descripcion
    
    // Campos auxiliares para mostrar información relacionada
    private String estudianteNombre;
    private String docenteNombre;
    private String carreraNombre;
    
    // Nuevos campos para el asesor
    private int asesorId;
    private String asesorNombre;

    // Constructores
    public Tesis() {}
    
    public Tesis(int estudianteId, String titulo, String descripcion, int carreraId) {
        this.estudianteId = estudianteId;
        this.titulo = titulo;
        this.descripcion = descripcion;
        this.carreraId = carreraId;
        this.estado = "PENDIENTE";
        this.fechaCreacion = new Date();
    }

    // Getters y Setters
    public int getId() { return id; }
    public void setId(int id) { this.id = id; }

    public int getEstudianteId() { return estudianteId; }
    public void setEstudianteId(int estudianteId) { this.estudianteId = estudianteId; }
    
    // Método compatible con versiones anteriores
    public int getIdEstudiante() { return estudianteId; }
    public void setIdEstudiante(int idEstudiante) { this.estudianteId = idEstudiante; }

    public int getDocenteId() { return docenteId; }
    public void setDocenteId(int docenteId) { this.docenteId = docenteId; }
    
    // Método compatible con versiones anteriores
    public int getIdDocente() { return docenteId; }
    public void setIdDocente(int idDocente) { this.docenteId = idDocente; }

    public int getCarreraId() { return carreraId; }
    public void setCarreraId(int carreraId) { this.carreraId = carreraId; }

    public String getTitulo() { return titulo; }
    public void setTitulo(String titulo) { this.titulo = titulo; }

    public String getDescripcion() { return descripcion; }
    public void setDescripcion(String descripcion) { this.descripcion = descripcion; }

    public String getEstado() { 
        return estado != null ? estado : "PENDIENTE"; 
    }
    
    public void setEstado(String estado) { 
        if (estado != null) {
            // Convertir estados del controlador a estados válidos
            switch (estado.toUpperCase()) {
                case "PENDIENTE":
                case "EN_REVISION":
                case "EVALUADA":
                case "APROBADA":
                case "RECHAZADA":
                case "SIN_ENVIAR":
                    this.estado = estado.toUpperCase();
                    break;
                default:
                    this.estado = "PENDIENTE";
            }
        } else {
            this.estado = "PENDIENTE";
        }
    }
    
    // Método para compatibilidad con enum EstadoTesis
    public EstadoTesis getEstadoEnum() {
        try {
            return EstadoTesis.valueOf(this.estado);
        } catch (IllegalArgumentException e) {
            return EstadoTesis.PENDIENTE;
        }
    }
    
    public void setEstado(EstadoTesis estado) { 
        this.estado = estado != null ? estado.name() : "PENDIENTE"; 
    }

    public String getArchivo() { return archivo; }
    public void setArchivo(String archivo) { this.archivo = archivo; }

    public Date getFechaEntrega() { return fechaEntrega; }
    public void setFechaEntrega(Date fechaEntrega) { this.fechaEntrega = fechaEntrega; }

    public Date getFechaLimiteRevision() { return fechaLimiteRevision; }
    public void setFechaLimiteRevision(Date fechaLimiteRevision) { 
        this.fechaLimiteRevision = fechaLimiteRevision; 
    }

    public String getAreaEstudio() { return areaEstudio; }
    public void setAreaEstudio(String areaEstudio) { this.areaEstudio = areaEstudio; }

    // Método para compatibilidad con versiones anteriores (carrera como String)
    public String getCarrera() { return carreraNombre; }
    public void setCarrera(String carrera) { this.carreraNombre = carrera; }
    
    public String getCarreraNombre() { return carreraNombre; }
    public void setCarreraNombre(String carreraNombre) { this.carreraNombre = carreraNombre; }

    public String getComentarios() { return comentarios; }
    public void setComentarios(String comentarios) { this.comentarios = comentarios; }

    public double getCalificacion() { return calificacion; }
    public void setCalificacion(double calificacion) { 
        this.calificacion = Math.max(0.0, Math.min(calificacion, 10.0)); // Validar entre 0 y 10
    }

    public Date getFechaCreacion() { return fechaCreacion; }
    public void setFechaCreacion(Date fechaCreacion) { this.fechaCreacion = fechaCreacion; }

    public Date getFechaUltimaModificacion() { return fechaUltimaModificacion; }
    public void setFechaUltimaModificacion(Date fechaUltimaModificacion) { 
        this.fechaUltimaModificacion = fechaUltimaModificacion; 
    }

    public String getEstudianteNombre() { return estudianteNombre; }
    public void setEstudianteNombre(String estudianteNombre) { 
        this.estudianteNombre = estudianteNombre; 
    }
    
    // Método para compatibilidad con versiones anteriores
    public String getNombreEstudiante() { return estudianteNombre; }
    public void setNombreEstudiante(String nombreEstudiante) { 
        this.estudianteNombre = nombreEstudiante; 
    }

    public String getDocenteNombre() { return docenteNombre; }
    public void setDocenteNombre(String docenteNombre) { 
        this.docenteNombre = docenteNombre; 
    }
    
    // Método para compatibilidad con versiones anteriores
    public String getNombreDocente() { return docenteNombre; }
    public void setNombreDocente(String nombreDocente) { 
        this.docenteNombre = nombreDocente; 
    }
    
    // Getters y Setters para el asesor (nuevos)
    public int getAsesorId() { return asesorId; }
    public void setAsesorId(int asesorId) { this.asesorId = asesorId; }
    
    public String getAsesorNombre() { return asesorNombre; }
    public void setAsesorNombre(String asesorNombre) { this.asesorNombre = asesorNombre; }
    
    // Métodos de utilidad
    public boolean estaPendiente() {
        return "PENDIENTE".equalsIgnoreCase(estado);
    }
    
    public boolean estaEnRevision() {
        return "EN_REVISION".equalsIgnoreCase(estado);
    }
    
    public boolean estaEvaluada() {
        return "EVALUADA".equalsIgnoreCase(estado);
    }
    
    public boolean estaAprobada() {
        return "APROBADA".equalsIgnoreCase(estado);
    }
    
    public boolean estaAtrasada() {
        if (fechaLimiteRevision == null || !estaEnRevision()) {
            return false;
        }
        return fechaLimiteRevision.before(new Date());
    }
    
    public int getDiasRestantes() {
        if (fechaLimiteRevision == null) {
            return -1;
        }
        long diferencia = fechaLimiteRevision.getTime() - new Date().getTime();
        return (int) (diferencia / (1000 * 60 * 60 * 24));
    }
    
    public String getEstadoConColor() {
        switch (estado.toUpperCase()) {
            case "PENDIENTE":
                return "<span class='badge badge-warning'>PENDIENTE</span>";
            case "EN_REVISION":
                return "<span class='badge badge-primary'>EN REVISIÓN</span>";
            case "EVALUADA":
                return "<span class='badge badge-info'>EVALUADA</span>";
            case "APROBADA":
                return "<span class='badge badge-success'>APROBADA</span>";
            case "RECHAZADA":
                return "<span class='badge badge-danger'>RECHAZADA</span>";
            default:
                return "<span class='badge badge-secondary'>" + estado + "</span>";
        }
    }
    
    @Override
    public String toString() {
        return "Tesis{" +
                "id=" + id +
                ", titulo='" + titulo + '\'' +
                ", estudianteId=" + estudianteId +
                ", docenteId=" + docenteId +
                ", asesorId=" + asesorId +
                ", estado='" + estado + '\'' +
                ", fechaCreacion=" + fechaCreacion +
                '}';
    }
    
    // Getters y Setters
    public String getPalabrasClave() {
        return palabrasClave;
    }
    
    public void setPalabrasClave(String palabrasClave) {
        this.palabrasClave = palabrasClave;
    }
    
    public String getNivelEstudio() {
        return nivelEstudio;
    }
    
    public void setNivelEstudio(String nivelEstudio) {
        this.nivelEstudio = nivelEstudio;
    }
    
    public int getSemestre() {
        return semestre;
    }
    
    public void setSemestre(int semestre) {
        this.semestre = semestre;
    }
    
    public int getAnoAcademico() {
        return anoAcademico;
    }
    
    public void setAnoAcademico(int anoAcademico) {
        this.anoAcademico = anoAcademico;
    }
    
    public String getResumen() {
        return this.descripcion; // Si resumen es alias de descripcion
    }
    
    public void setResumen(String resumen) {
        this.descripcion = resumen;
    }
}