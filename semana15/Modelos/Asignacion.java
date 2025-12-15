package Modelos;

import java.math.BigDecimal;
import java.util.Date;

/**
 *
 * @author WindowsPC
 */
public class Asignacion {
    private int id;
    private int idTesis;
    private int idDocente;
    private int idEstudiante;
    private Date fechaAsignacion;
    private Date fechaLimite;
    private String estado = "ASIGNADA"; // Valor por defecto ajustado
    private String comentariosAdmin;
    
    // Campos auxiliares
    private String tesisTitulo;
    private String nombreEstudiante;
    private String nombreDocente;
    private String docenteEmail;  // NUEVO ATRIBUTO PARA EMAIL DEL DOCENTE
    
    // NUEVOS CAMPOS NECESARIOS PARA LA ESTRUCTURA DE LA BD
    private String rol; // 'JURADO' o 'ASESOR'
    private Date fechaCompletada;
    private String observaciones;
    private BigDecimal calificacion;
    private String feedback;

    // Constructores
    public Asignacion() {}

    // Getters y Setters EXISTENTES (sin cambios)
    public int getId() { return id; }
    public void setId(int id) { this.id = id; }

    public int getIdTesis() { return idTesis; }
    public void setIdTesis(int idTesis) { this.idTesis = idTesis; }

    public int getIdDocente() { return idDocente; }
    public void setIdDocente(int idDocente) { this.idDocente = idDocente; }

    public int getIdEstudiante() { return idEstudiante; }
    public void setIdEstudiante(int idEstudiante) { this.idEstudiante = idEstudiante; }

    public Date getFechaAsignacion() { return fechaAsignacion; }
    public void setFechaAsignacion(Date fechaAsignacion) { this.fechaAsignacion = fechaAsignacion; }

    public Date getFechaLimite() { return fechaLimite; }
    public void setFechaLimite(Date fechaLimite) { this.fechaLimite = fechaLimite; }

    public String getEstado() { return estado; }
    public void setEstado(String estado) { 
        this.estado = estado != null ? estado : "ASIGNADA"; 
    }

    public String getComentariosAdmin() { return comentariosAdmin; }
    public void setComentariosAdmin(String comentariosAdmin) { this.comentariosAdmin = comentariosAdmin; }

    public String getTesisTitulo() { return tesisTitulo; }
    public void setTesisTitulo(String tesisTitulo) { this.tesisTitulo = tesisTitulo; }

    public String getNombreEstudiante() { return nombreEstudiante; }
    public void setNombreEstudiante(String nombreEstudiante) { this.nombreEstudiante = nombreEstudiante; }

    public String getNombreDocente() { return nombreDocente; }
    public void setNombreDocente(String nombreDocente) { this.nombreDocente = nombreDocente; }
    
    // NUEVOS GETTERS Y SETTERS PARA EMAIL DEL DOCENTE
    public String getDocenteEmail() { return docenteEmail; }
    public void setDocenteEmail(String docenteEmail) { this.docenteEmail = docenteEmail; }
    
    // NUEVOS GETTERS Y SETTERS NECESARIOS
    public String getRol() { return rol; }
    public void setRol(String rol) { 
        this.rol = rol != null ? rol.toUpperCase() : null; 
    }
    
    public Date getFechaCompletada() { return fechaCompletada; }
    public void setFechaCompletada(Date fechaCompletada) { this.fechaCompletada = fechaCompletada; }
    
    public String getObservaciones() { return observaciones; }
    public void setObservaciones(String observaciones) { this.observaciones = observaciones; }
    
    public BigDecimal getCalificacion() { return calificacion; }
    public void setCalificacion(BigDecimal calificacion) { this.calificacion = calificacion; }
    
    // Método sobrecargado para aceptar double
    public void setCalificacion(double calificacion) { 
        this.calificacion = BigDecimal.valueOf(calificacion); 
    }
    
    public String getFeedback() { return feedback; }
    public void setFeedback(String feedback) { this.feedback = feedback; }
    
    // ===== MÉTODOS ADICIONALES PARA COMPATIBILIDAD CON EL JSP =====
    public String getTituloTesis() {
        return getTesisTitulo();  // Llama al método existente
    }
    
    public void setTituloTesis(String tituloTesis) {
        setTesisTitulo(tituloTesis);  // Llama al método existente
    }}