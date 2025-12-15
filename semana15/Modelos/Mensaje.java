package Modelos;

import java.util.Date;

public class Mensaje {
    private int id;
    private int idAsignacion;
    private int idDocente;
    private int idEstudiante;
    private String asunto;
    private String contenido;
    private String tipoMensaje;
    private Date fechaEnvio;
    private String estado;
    private String adjuntos; // JSON string
    
     // Nuevos campos para mostrar información
    private String nombreDocente;
    private String nombreEstudiante;
    private String remitenteTipo; // "DOCENTE" o "ESTUDIANTE"
    
    // Constructores
    public Mensaje() {
        this.fechaEnvio = new Date();
        this.estado = "no_leido";
        this.tipoMensaje = "general";
    }
    
    public Mensaje(int idAsignacion, int idDocente, int idEstudiante, 
                   String asunto, String contenido, String tipoMensaje) {
        this();
        this.idAsignacion = idAsignacion;
        this.idDocente = idDocente;
        this.idEstudiante = idEstudiante;
        this.asunto = asunto;
        this.contenido = contenido;
        this.tipoMensaje = tipoMensaje;
    }
    
    
     // Agregar nuevos getters y setters
    public String getNombreDocente() {
        return nombreDocente;
    }
    
    public void setNombreDocente(String nombreDocente) {
        this.nombreDocente = nombreDocente;
    }
    
    public String getNombreEstudiante() {
        return nombreEstudiante;
    }
    
    public void setNombreEstudiante(String nombreEstudiante) {
        this.nombreEstudiante = nombreEstudiante;
    }
    
    public String getRemitenteTipo() {
        return remitenteTipo;
    }
    
    public void setRemitenteTipo(String remitenteTipo) {
        this.remitenteTipo = remitenteTipo;
    }
    // Getters y Setters
    public int getId() { return id; }
    public void setId(int id) { this.id = id; }
    
    public int getIdAsignacion() { return idAsignacion; }
    public void setIdAsignacion(int idAsignacion) { this.idAsignacion = idAsignacion; }
    
    public int getIdDocente() { return idDocente; }
    public void setIdDocente(int idDocente) { this.idDocente = idDocente; }
    
    public int getIdEstudiante() { return idEstudiante; }
    public void setIdEstudiante(int idEstudiante) { this.idEstudiante = idEstudiante; }
    
    public String getAsunto() { return asunto; }
    public void setAsunto(String asunto) { this.asunto = asunto; }
    
    public String getContenido() { return contenido; }
    public void setContenido(String contenido) { this.contenido = contenido; }
    
    public String getTipoMensaje() { return tipoMensaje; }
    public void setTipoMensaje(String tipoMensaje) { this.tipoMensaje = tipoMensaje; }
    
    public Date getFechaEnvio() { return fechaEnvio; }
    public void setFechaEnvio(Date fechaEnvio) { this.fechaEnvio = fechaEnvio; }
    
    public String getEstado() { return estado; }
    public void setEstado(String estado) { this.estado = estado; }
    
    public String getAdjuntos() { return adjuntos; }
    public void setAdjuntos(String adjuntos) { this.adjuntos = adjuntos; }
}