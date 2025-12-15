<%@page import="DAO.AsignacionDAO"%>
<%@page import="DAO.TesisDAO"%>
<%@page import="Modelos.Usuario"%>
<%@page import="java.text.SimpleDateFormat"%>
<%@page import="Modelos.Asignacion"%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page import="java.util.*" %>
<!DOCTYPE html>
<html lang="es">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Panel Docente - ThesisReview Portal</title>
    <meta name="description" content="Panel de control para docentes. Revisa y evalúa tesis asignadas con herramientas profesionales de evaluación académica.">
    <script src="https://cdn.tailwindcss.com"></script>
    <style>
        @import url('https://fonts.googleapis.com/css2?family=Inter:wght@400;500;600;700&display=swap');

        body {
            font-family: 'Inter', sans-serif;
            background: linear-gradient(135deg, #e3f2fd 0%, #f8fbff 50%, #e3f2fd 100%);
            min-height: 100vh;
            margin: 0;
            line-height: inherit;
        }

        .logo-img {
            width: 40px;
            height: 40px;
            border-radius: 50%;
            object-fit: cover;
            box-shadow: 0 0 10px rgba(59, 130, 246, 0.3);
        }

        .btn-primary, .btn-secondary, .btn-accent {
            border-radius: 0.5rem;
            padding: 0.75rem 1.5rem;
            font-weight: 600;
            color: white;
            transition: all 250ms cubic-bezier(0.4, 0, 0.2, 1);
            box-shadow: 0 4px 6px -1px rgba(0, 0, 0, 0.1);
            cursor: pointer;
            border: none;
        }

        .btn-primary {
            background-color: rgb(30, 64, 175);
        }

        .btn-primary:hover {
            background-color: rgb(29, 78, 216);
        }

        .btn-secondary {
            background-color: rgb(59, 130, 246);
        }

        .btn-secondary:hover {
            background-color: rgb(29, 78, 216);
        }

        .btn-accent {
            background-color: rgb(249, 115, 22);
        }

        .btn-accent:hover {
            background-color: rgb(234, 88, 12);
        }

        .transition-standard {
            transition: all 250ms ease-in-out;
        }

        .form-input {
            width: 100%;
            border-radius: 0.375rem;
            border: 1px solid rgb(229, 231, 235);
            padding: 0.5rem 0.75rem;
            transition: all 250ms cubic-bezier(0.4, 0, 0.2, 1);
        }

        .form-input:focus {
            outline: 2px solid rgb(59, 130, 246);
            outline-offset: 2px;
            border-color: transparent;
        }

        .dropdown-menu {
            position: absolute;
            top: 100%;
            right: 0;
            margin-top: 0.5rem;
            width: 200px;
            background: white;
            border: 1px solid #e5e7eb;
            border-radius: 0.5rem;
            box-shadow: 0 10px 15px -3px rgba(0, 0, 0, 0.1), 0 4px 6px -4px rgba(0, 0, 0, 0.1);
            z-index: 1000;
            opacity: 0;
            visibility: hidden;
            transform: translateY(-10px);
            transition: all 0.2s ease-in-out;
        }

        .dropdown-menu.show {
            opacity: 1;
            visibility: visible;
            transform: translateY(0);
        }

        .dropdown-item {
            display: flex;
            align-items: center;
            padding: 0.75rem 1rem;
            color: #374151;
            text-decoration: none;
            transition: background-color 0.2s;
            border: none;
            background: none;
            width: 100%;
            text-align: left;
            cursor: pointer;
        }

        .dropdown-item:hover {
            background-color: #f9fafb;
        }

        .dropdown-item svg {
            width: 1rem;
            height: 1rem;
            margin-right: 0.75rem;
            color: #6b7280;
        }

        .dropdown-divider {
            height: 1px;
            background-color: #e5e7eb;
            margin: 0.25rem 0;
        }

        .line-clamp-2 {
            overflow: hidden;
            display: -webkit-box;
            -webkit-box-orient: vertical;
            -webkit-line-clamp: 2;
        }

        .transform {
            transform: translate(var(--tw-translate-x), var(--tw-translate-y));
        }

        .translate-x-full {
            transform: translateX(100%);
        }
       
* {
    box-sizing: border-box;
    margin: 0;
    padding: 0;
}

body {
    font-family: 'Inter', sans-serif;
    background: linear-gradient(135deg, #e3f2fd 0%, #f8fbff 50%, #e3f2fd 100%);
    min-height: 100vh;
    color: #1f2937;
    line-height: 1.5;
}

/* Colores de texto según diseño original */
.text-primary {
    color: #1e40af; /* blue-800 */
}

.text-text-primary {
    color: #1f2937; /* gray-800 */
}

.text-text-secondary {
    color: #6b7280; /* gray-500 */
}

.text-gray-700 {
    color: #374151;
}

.text-gray-900 {
    color: #111827;
}

.text-accent {
    color: #f97316; /* orange-500 */
}

.text-secondary {
    color: #3b82f6; /* blue-500 */
}

.text-success {
    color: #10b981; /* emerald-500 */
}

.text-warning {
    color: #f59e0b; /* amber-500 */
}

.text-error {
    color: #ef4444; /* red-500 */
}

/* Estilos para botones */
.btn-primary,
.btn-secondary,
.btn-accent {
    border-radius: 0.5rem;
    padding: 0.75rem 1.5rem;
    font-weight: 600;
    color: white;
    transition: all 250ms ease-in-out;
    box-shadow: 0 4px 6px -1px rgba(0, 0, 0, 0.1);
    cursor: pointer;
    border: none;
    display: inline-flex;
    align-items: center;
    justify-content: center;
}

.btn-primary {
    background-color: #1e40af;
}

.btn-primary:hover {
    background-color: #1d4ed8;
}

.btn-secondary {
    background-color: #3b82f6;
}

.btn-secondary:hover {
    background-color: #2563eb;
}

.btn-accent {
    background-color: #f97316;
}

.btn-accent:hover {
    background-color: #ea580c;
}
.form-input {
    width: 100%;
    border-radius: 0.375rem;
    border: 1px solid #e5e7eb;
    padding: 0.5rem 0.75rem;
    transition: all 250ms ease-in-out;
}

.form-input:focus {
    outline: 2px solid #3b82f6;
    outline-offset: 2px;
    border-color: transparent;
}

/* Estilos para modales */
.modal-overlay {
    position: fixed;
    top: 0;
    left: 0;
    right: 0;
    bottom: 0;
    background-color: rgba(0, 0, 0, 0.5);
    display: none;
    align-items: center;
    justify-content: center;
    z-index: 1000;
}

.modal-overlay.active {
    display: flex;
}

.modal-container {
    background-color: white;
    border-radius: 0.5rem;
    box-shadow: 0 20px 25px -5px rgba(0, 0, 0, 0.1), 0 10px 10px -5px rgba(0, 0, 0, 0.04);
    max-width: 90%;
    max-height: 90vh;
    overflow-y: auto;
    animation: modalSlideIn 0.3s ease-out;
}

@keyframes modalSlideIn {
    from {
        opacity: 0;
        transform: translateY(-20px);
    }
    to {
        opacity: 1;
        transform: translateY(0);
    }
}

.modal-header {
    padding: 1.5rem;
    border-bottom: 1px solid #e5e7eb;
}

.modal-title {
    font-size: 1.25rem;
    font-weight: 600;
}

.modal-body {
    padding: 1.5rem;
}

.modal-footer {
    padding: 1.5rem;
    border-top: 1px solid #e5e7eb;
    display: flex;
    justify-content: flex-end;
    gap: 0.75rem;
}

/* Estilos para rating (estrellas) */
.rating-btn {
    background: none;
    border: none;
    cursor: pointer;
    padding: 0.25rem;
}

.rating-btn svg {
    width: 1.5rem;
    height: 1.5rem;
}

.rating-btn.active svg {
    color: #f59e0b; /* warning color */
}

/* Estilos para checkboxes y radios */
input[type="checkbox"],
input[type="radio"] {
    width: 1rem;
    height: 1rem;
    margin-right: 0.5rem;
}

/* Estilos para cards y contenedores */
.card {
    background-color: white;
    border-radius: 0.5rem;
    border: 1px solid #e5e7eb;
    box-shadow: 0 4px 6px -1px rgba(0, 0, 0, 0.1);
}

.hidden.md\:flex {
    /* En pantallas pequeñas está oculto */
    display: none;
}

/* En pantallas medianas se muestra */
@media (min-width: 768px) {
    .hidden.md\:flex {
        display: flex !important;
    }
}
/* Responsive */
@media (min-width: 768px) {
    .md\:grid-cols-2 {
        grid-template-columns: repeat(2, minmax(0, 1fr));
    }
}

/* Clases específicas para el layout del modal */
.modal-grid-2 {
    display: grid;
    grid-template-columns: repeat(1, minmax(0, 1fr));
    gap: 1.5rem;
}

@media (min-width: 768px) {
    .modal-grid-2 {
        grid-template-columns: repeat(2, minmax(0, 1fr));
    }
}

/* Estilos para los elementos de selección en modales */
.template-option {
    border: 1px solid #e5e7eb;
    border-radius: 0.5rem;
    padding: 1rem;
    cursor: pointer;
    transition: all 200ms ease;
}

.template-option:hover {
    background-color: #f9fafb;
    border-color: #d1d5db;
}

.tool-option {
    border: 1px solid #e5e7eb;
    border-radius: 0.5rem;
    padding: 1.5rem;
    cursor: pointer;
    text-align: center;
    transition: all 200ms ease;
}

.tool-option:hover {
    background-color: #f9fafb;
    border-color: #d1d5db;
}
/* Agrega esto en la sección de estilos (después de la línea 148 aproximadamente) */

/* Colores específicos para navegación */
.text-primary {
    color: #1e40af;
}

.bg-primary-50 {
    background-color: #eff6ff;
}

.text-text-secondary {
    color: #6b7280;
}

.hover\:text-primary:hover {
    color: #1e40af;
}

/* Colores de acento para etiquetas */
.bg-accent {
    background-color: #f97316;
}

.bg-accent-100 {
    background-color: #ffedd5;
}

.text-accent {
    color: #f97316;
}

/* Colores de estados */
.bg-warning {
    background-color: #f59e0b;
}

.bg-warning-100 {
    background-color: #fef3c7;
}

.text-warning {
    color: #f59e0b;
}

.bg-success {
    background-color: #10b981;
}

.bg-success-100 {
    background-color: #d1fae5;
}

.text-success {
    color: #10b981;
}

/* Colores primarios variantes */
.bg-primary {
    background-color: #1e40af;
}

.bg-primary-100 {
    background-color: #dbeafe;
}

/* Colores secundarios */
.bg-secondary {
    background-color: #3b82f6;
}

.bg-secondary-200 {
    background-color: #bfdbfe;
}

.text-secondary {
    color: #3b82f6;
}

/* Utilidades adicionales */
.z-50 {
    z-index: 50;
}

.sticky {
    position: sticky;
}

.top-0 {
    top: 0;
}

.shadow-sm {
    box-shadow: 0 1px 2px 0 rgba(0, 0, 0, 0.05);
}

.absolute {
    position: absolute;
}

.-top-1 {
    top: -0.25rem;
}

.-right-1 {
    right: -0.25rem;
}

.w-5 {
    width: 1.25rem;
}

.h-5 {
    height: 1.25rem;
}

.text-xs {
    font-size: 0.75rem;
}

.rounded-full {
    border-radius: 9999px;
}

.object-cover {
    object-fit: cover;
}

.border-2 {
    border-width: 2px;
}

/* Estilos específicos para modales */
.modal-overlay.active {
    display: flex !important;
}

/* Clases Tailwind básicas faltantes */
.max-w-md {
    max-width: 28rem;
}

.max-w-2xl {
    max-width: 42rem;
}

.max-w-4xl {
    max-width: 56rem;
}

.mx-auto {
    margin-left: auto;
    margin-right: auto;
}

.space-y-2 > * + * {
    margin-top: 0.5rem;
}

.space-y-4 > * + * {
    margin-top: 1rem;
}

.space-x-2 > * + * {
    margin-left: 0.5rem;
}

.space-x-4 > * + * {
    margin-left: 1rem;
}

.text-primary {
    color: #1e40af;
}

.bg-primary-50 {
    background-color: #eff6ff;
}

/* Colores de texto */
.text-text-secondary {
    color: #6b7280;
}

.hover\:text-primary:hover {
    color: #1e40af;
}

.transition-standard {
    transition: all 250ms ease-in-out;
}

/* Colores para acciones rápidas */
.bg-gradient-to-br {
    background-image: linear-gradient(to bottom right, var(--tw-gradient-stops));
}

.from-secondary {
    --tw-gradient-from: #3b82f6 var(--tw-gradient-from-position);
    --tw-gradient-to: rgb(59 130 246 / 0) var(--tw-gradient-to-position);
    --tw-gradient-stops: var(--tw-gradient-from), var(--tw-gradient-to);
}

.to-accent {
    --tw-gradient-to: #f97316 var(--tw-gradient-to-position);
}

.text-white {
    color: #ffffff;
}

/* Background con opacidad */
.bg-white\/20 {
    background-color: rgba(255, 255, 255, 0.2);
}

.bg-white\/30 {
    background-color: rgba(255, 255, 255, 0.3);
}

.backdrop-blur-sm {
    backdrop-filter: blur(4px);
}

/* Colores de acento */
.bg-accent {
    background-color: #f97316;
}

.bg-accent-100 {
    background-color: #ffedd5;
}

.text-accent {
    color: #f97316;
}

/* Colores de estados */
.bg-warning {
    background-color: #f59e0b;
}

.bg-warning-100 {
    background-color: #fef3c7;
}

.text-warning {
    color: #f59e0b;
}

.bg-success {
    background-color: #10b981;
}

.bg-success-100 {
    background-color: #d1fae5;
}

.text-success {
    color: #10b981;
}

/* Colores primarios variantes */
.bg-primary {
    background-color: #1e40af;
}

.bg-primary-100 {
    background-color: #dbeafe;
}

/* Colores secundarios */
.bg-secondary {
    background-color: #3b82f6;
}

.bg-secondary-200 {
    background-color: #bfdbfe;
}

.text-secondary {
    color: #3b82f6;
}

.hidden {
    display: none;
}

.md\:flex {
    display: none;
}

@media (min-width: 768px) {
    .md\:flex {
        display: flex;
    }
    
    .hidden.md\:flex {
        display: flex;
    }
}

.flex {
    display: flex;
}

.items-center {
    align-items: center;
}

.justify-center {
    justify-content: center;
}

.justify-between {
    justify-content: space-between;
}

.justify-end {
    justify-content: flex-end;
}

/* Espaciado */
.space-x-1 > * + * {
    margin-left: 0.25rem;
}

.space-x-2 > * + * {
    margin-left: 0.5rem;
}

.space-x-3 > * + * {
    margin-left: 0.75rem;
}

.space-x-4 > * + * {
    margin-left: 1rem;
}

.space-y-3 > * + * {
    margin-top: 0.75rem;
}

/* Padding y margin */
.p-2 {
    padding: 0.5rem;
}

.p-3 {
    padding: 0.75rem;
}

.p-4 {
    padding: 1rem;
}

.p-6 {
    padding: 1.5rem;
}

.px-4 {
    padding-left: 1rem;
    padding-right: 1rem;
}

.py-2 {
    padding-top: 0.5rem;
    padding-bottom: 0.5rem;
}

.py-3 {
    padding-top: 0.75rem;
    padding-bottom: 0.75rem;
}

.py-4 {
    padding-top: 1rem;
    padding-bottom: 1rem;
}

.mb-4 {
    margin-bottom: 1rem;
}

.mt-4 {
    margin-top: 1rem;
}

.mt-6 {
    margin-top: 1.5rem;
}

/* Bordes y redondeados */
.rounded-lg {
    border-radius: 0.5rem;
}

.rounded-xl {
    border-radius: 0.75rem;
}

.rounded-full {
    border-radius: 9999px;
}

.border {
    border-width: 1px;
}

.border-b {
    border-bottom-width: 1px;
}

.border-gray-200 {
    border-color: #e5e7eb;
}

.border-l-4 {
    border-left-width: 4px;
}

/* Tamaños */
.w-full {
    width: 100%;
}

.max-w-sm {
    max-width: 24rem;
}

.max-w-md {
    max-width: 28rem;
}

.max-w-2xl {
    max-width: 42rem;
}

.max-w-4xl {
    max-width: 56rem;
}

.max-w-7xl {
    max-width: 80rem;
}

/* Shadow */
.shadow-sm {
    box-shadow: 0 1px 2px 0 rgba(0, 0, 0, 0.05);
}

.shadow-lg {
    box-shadow: 0 10px 15px -3px rgba(0, 0, 0, 0.1), 0 4px 6px -4px rgba(0, 0, 0, 0.1);
}

/* Position */
.relative {
    position: relative;
}

.absolute {
    position: absolute;
}

.fixed {
    position: fixed;
}

.sticky {
    position: sticky;
}

.top-0 {
    top: 0;
}

.top-4 {
    top: 1rem;
}

.right-4 {
    right: 1rem;
}

.z-50 {
    z-index: 50;
}

/* Texto */
.text-sm {
    font-size: 0.875rem;
    line-height: 1.25rem;
}

.text-lg {
    font-size: 1.125rem;
    line-height: 1.75rem;
}

.text-xl {
    font-size: 1.25rem;
    line-height: 1.75rem;
}

.text-2xl {
    font-size: 1.5rem;
    line-height: 2rem;
}

.text-3xl {
    font-size: 1.875rem;
    line-height: 2.25rem;
}

.font-medium {
    font-weight: 500;
}

.font-semibold {
    font-weight: 600;
}

.font-bold {
    font-weight: 700;
}
/* Grid */
.grid {
    display: grid;
}

.grid-cols-1 {
    grid-template-columns: repeat(1, minmax(0, 1fr));
}
@media (min-width: 768px) {
    .md\:grid-cols-2 {
        grid-template-columns: repeat(2, minmax(0, 1fr));
    }
    
    .md\:grid-cols-4 {
        grid-template-columns: repeat(4, minmax(0, 1fr));
    }
}
@media (min-width: 1024px) {
    .lg\:grid-cols-3 {
        grid-template-columns: repeat(3, minmax(0, 1fr));
    }
    
    .lg\:col-span-2 {
        grid-column: span 2 / span 2;
    }
}
/* Estilos para el visor de documentos */
#thesisViewerModal .modal-container {
    max-height: 95vh;
}

#pdfViewer {
    min-height: 600px;
    border: 1px solid #e5e7eb;
    border-radius: 0.5rem;
}

.animate-spin {
    animation: spin 1s linear infinite;
}

@keyframes spin {
    from {
        transform: rotate(0deg);
    }
    to {
        transform: rotate(360deg);
    }
}


    </style>
<body class="font-inter bg-background text-text-primary">
    <%
        // Obtener el docente de la sesión
        HttpSession userSession = request.getSession(false);
if (userSession == null || userSession.getAttribute("usuario") == null) {
    response.sendRedirect("index.jsp");
    return;
}
        
        Usuario docente = (Usuario) userSession.getAttribute("usuario");
        String nombreDocente = docente.getNombre() + " " + docente.getApellido();
        String rolDocente = docente.getTipo().toString();
        String fotoPerfil = "https://images.unsplash.com/photo-1659353887488-b3c443982a57";
        
        // Instanciar DAOs
        TesisDAO tesisDAO = new TesisDAO();
        AsignacionDAO asignacionDAO = new AsignacionDAO();
        
        // 1. OBTENER ASIGNACIONES COMO JURADO
        List<Asignacion> asignacionesRevisor = asignacionDAO.obtenerAsignacionesPorDocente(docente.getId());
        
        // Filtrar solo las asignaciones como JURADO
        List<Asignacion> asignacionesJurado = new ArrayList<>();
        for (Asignacion asignacion : asignacionesRevisor) {
            if ("JURADO".equals(asignacion.getRol())) {
                asignacionesJurado.add(asignacion);
            }
        }
        
        // Separar tesis por estado
        List<Asignacion> tesisPendientes = new ArrayList<>();
        List<Asignacion> tesisEnRevision = new ArrayList<>();
        List<Asignacion> tesisCompletadas = new ArrayList<>();
        
        for (Asignacion asignacion : asignacionesJurado) {
            String estado = asignacion.getEstado();
            if (estado != null) {
                switch (estado.toUpperCase()) {
                    case "ASIGNADA":
                        tesisPendientes.add(asignacion);
                        break;
                    case "EN_REVISION":
                    case "EN_PROGRESO":
                        tesisEnRevision.add(asignacion);
                        break;
                    case "COMPLETADA":
                    case "EVALUADA":
                        tesisCompletadas.add(asignacion);
                        break;
                }
            }
        }
        
        int tesisAsignadas = asignacionesJurado.size();
        int tesisPendientesCount = tesisPendientes.size();
        int tesisEnRevisionCount = tesisEnRevision.size();
        int tesisCompletadasCount = tesisCompletadas.size();
        
        // Estadísticas de Jurado
        int tesisRevisadasMes = tesisCompletadasCount; 
        double tiempoPromedio = 5.2;
        double calificacionEstudiantes = 4.8;
        int tasaAprobacion = 92;
        
        // 2. OBTENER ASIGNACIONES COMO ASESOR
        List<Asignacion> asignacionesAsesor = new ArrayList<>();
        for (Asignacion asignacion : asignacionesRevisor) {
            if ("ASESOR".equals(asignacion.getRol())) {
                asignacionesAsesor.add(asignacion);
            }
        }
        
        int asesoriasActivas = 0;
        int sesionesMes = 12;
        int horasTotales = 36;
        double satisfaccionEstudiantes = 4.7;
        
        // Contar asesorías activas
        for (Asignacion asignacion : asignacionesAsesor) {
            String estado = asignacion.getEstado();
            if (estado != null && !"COMPLETADA".equals(estado) && !"CANCELADA".equals(estado)) {
                asesoriasActivas++;
            }
        }
        
        // Formateador de fechas
        SimpleDateFormat sdf = new SimpleDateFormat("dd MMM yyyy");
        SimpleDateFormat sdfSQL = new SimpleDateFormat("yyyy-MM-dd");
    %>

    <!-- Navigation Header -->
    <nav class="bg-white border-b border-gray-200 sticky top-0 z-50 shadow-sm">
        <div class="max-w-7xl mx-auto px-4 sm:px-6 lg:px-8">
            <div class="flex justify-between items-center h-16">
                <!-- Logo -->
                <div class="flex items-center">
                    <img src="upla.png" 
                         alt="Logo del Sistema Académico" 
                         class="logo-img">
                    <span class="ml-2 text-xl font-bold text-primary">ThesisReview</span>
                    <span class="ml-3 px-2 py-1 bg-accent-100 text-accent text-xs font-medium rounded-full">Docente</span>
                </div>

                <!-- Navigation Tabs -->
                <div class="hidden md:flex items-center space-x-1">
                    <button class="px-4 py-2 text-sm font-medium text-primary bg-primary-50 rounded-lg" id="reviewsTab" onclick="switchSection('reviews')">
                        Jurado
                    </button>
                    <button class="px-4 py-2 text-sm font-medium text-text-secondary hover:text-primary transition-standard" id="advisingTab" onclick="switchSection('advising')">
                        Asesoría
                    </button>
                </div>

                <!-- User Profile -->
                <div class="flex items-center space-x-4">
                    <!-- Notifications -->
                    <button class="p-2 text-text-secondary hover:text-primary transition-standard relative">
                        <svg class="w-6 h-6" fill="none" stroke="currentColor" viewBox="0 0 24 24">
                            <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M15 17h5l-5 5v-5zM4 17h5l-5 5v-5zM12 12l8-8m0 0l-8 8m8-8v8"/>
                        </svg>
                        <span class="absolute -top-1 -right-1 bg-accent text-white text-xs w-5 h-5 rounded-full flex items-center justify-center">
                            <%= tesisPendientesCount + tesisEnRevisionCount %>
                        </span>
                    </button>

                    <!-- User Menu -->
                    <div class="relative">
                        <div class="flex items-center space-x-3 cursor-pointer" id="user-menu-button">
                            <div class="text-right">
                                <div class="text-sm font-medium text-primary"><%= nombreDocente %></div>
                                <div class="text-xs text-text-secondary"><%= rolDocente %></div>
                            </div>
                            <img src="<%= fotoPerfil %>" 
                                 alt="Foto de perfil de <%= nombreDocente %>" 
                                 class="w-10 h-10 rounded-full object-cover border-2 border-secondary-200"
                                 onerror="this.src='https://images.unsplash.com/photo-1584824486509-112e4181ff6b?q=80&w=2940&auto=format&fit=crop&ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D'; this.onerror=null;">
                            <button class="p-1 hover:bg-gray-100 rounded-full">
                                <svg class="w-4 h-4 text-text-secondary" fill="none" stroke="currentColor" viewBox="0 0 24 24">
                                    <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M19 9l-7 7-7-7"/>
                                </svg>
                            </button>
                        </div>

                        <!-- Dropdown Menu -->
                        <div class="dropdown-menu" id="user-dropdown">
                            <div class="p-2">
                                <button class="dropdown-item">
                                    <svg fill="none" stroke="currentColor" viewBox="0 0 24 24">
                                        <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M16 7a4 4 0 11-8 0 4 4 0 018 0zM12 14a7 7 0 00-7 7h14a7 7 0 00-7-7z"/>
                                    </svg>
                                    Mi Perfil
                                </button>
                                <button class="dropdown-item">
                                    <svg fill="none" stroke="currentColor" viewBox="0 0 24 24">
                                        <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M10.325 4.317c.426-1.756 2.924-1.756 3.35 0a1.724 1.724 0 002.573 1.066c1.543-.94 3.31.826 2.37 2.37a1.724 1.724 0 001.065 2.572c1.756.426 1.756 2.924 0 3.35a1.724 1.724 0 00-1.066 2.573c.94 1.543-.826 3.31-2.37 2.37a1.724 1.724 0 00-2.572 1.065c-.426 1.756-2.924 1.756-3.35 0a1.724 1.724 0 00-2.573-1.066c-1.543.94-3.31-.826-2.37-2.37a1.724 1.724 0 00-1.065-2.572c-1.756-.426-1.756-2.924 0-3.35a1.724 1.724 0 001.066-2.573c-.94-1.543.826-3.31 2.37-2.37.996.608 2.296.07 2.572-1.065z"/>
                                        <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M15 12a3 3 0 11-6 0 3 3 0 016 0z"/>
                                    </svg>
                                    Configuración
                                </button>
                                <button class="dropdown-item">
                                    <svg fill="none" stroke="currentColor" viewBox="0 0 24 24">
                                        <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M18.364 5.636l-3.536 3.536m0 5.656l3.536 3.536M9.172 9.172L5.636 5.636m3.536 9.192L5.636 18.364M21 12a9 9 0 11-18 0 9 9 0 0118 0z"/>
                                    </svg>
                                    Ayuda y Soporte
                                </button>
                            </div>
                            <div class="dropdown-divider"></div>
                            <div class="p-2">
                                <button class="dropdown-item text-error" id="logout-button">
                                    <svg fill="none" stroke="currentColor" viewBox="0 0 24 24">
                                        <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M17 16l4-4m0 0l-4-4m4 4H7m6 4v1a3 3 0 01-3 3H6a3 3 0 01-3-3V7a3 3 0 013-3h4a3 3 0 013 3v1"/>
                                    </svg>
                                    Cerrar Sesión
                                </button>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </nav>

    <!-- Main Content -->
    <div class="max-w-7xl mx-auto px-4 sm:px-6 lg:px-8 py-8">
        <!-- Sección de Jurado (visible por defecto) -->
        <div id="reviewsSection">
            <!-- Welcome Header -->
            <div class="mb-8">
                <h1 class="text-3xl font-bold text-primary mb-2">¡Bienvenido, <%= nombreDocente %>!</h1>
                <p class="text-text-secondary">Gestiona tus revisiones asignadas como JURADO.</p>
            </div>

            <!-- Quick Stats -->
            <div class="grid grid-cols-1 md:grid-cols-4 gap-6 mb-8">
                <div class="bg-white rounded-xl p-6 border border-gray-200 shadow-sm">
                    <div class="flex items-center">
                        <div class="w-12 h-12 bg-accent-100 rounded-lg flex items-center justify-center">
                            <svg class="w-6 h-6 text-accent" fill="none" stroke="currentColor" viewBox="0 0 24 24">
                                <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M9 5H7a2 2 0 00-2 2v12a2 2 0 002 2h10a2 2 0 002-2V7a2 2 0 00-2-2h-2M9 5a2 2 0 002 2h2a2 2 0 002-2M9 5a2 2 0 012-2h2a2 2 0 012 2"/>
                            </svg>
                        </div>
                        <div class="ml-4">
                            <p class="text-sm text-text-secondary">Tesis Asignadas</p>
                            <p class="text-2xl font-bold text-accent"><%= tesisAsignadas %></p>
                        </div>
                    </div>
                </div>

                <div class="bg-white rounded-xl p-6 border border-gray-200 shadow-sm">
                    <div class="flex items-center">
                        <div class="w-12 h-12 bg-warning-100 rounded-lg flex items-center justify-center">
                            <svg class="w-6 h-6 text-warning" fill="none" stroke="currentColor" viewBox="0 0 24 24">
                                <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M12 8v4l3 3m6-3a9 9 0 11-18 0 9 9 0 0118 0z"/>
                            </svg>
                        </div>
                        <div class="ml-4">
                            <p class="text-sm text-text-secondary">Pendientes</p>
                            <p class="text-2xl font-bold text-warning"><%= tesisPendientesCount %></p>
                        </div>
                    </div>
                </div>

                <div class="bg-white rounded-xl p-6 border border-gray-200 shadow-sm">
                    <div class="flex items-center">
                        <div class="w-12 h-12 bg-primary-100 rounded-lg flex items-center justify-center">
                            <svg class="w-6 h-6 text-primary" fill="none" stroke="currentColor" viewBox="0 0 24 24">
                                <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M15 12a3 3 0 11-6 0 3 3 0 016 0z"/>
                                <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M2.458 12C3.732 7.943 7.523 5 12 5c4.478 0 8.268 2.943 9.542 7-1.274 4.057-5.064 7-9.542 7-4.477 0-8.268-2.943-9.542-7z"/>
                            </svg>
                        </div>
                        <div class="ml-4">
                            <p class="text-sm text-text-secondary">En Revisión</p>
                            <p class="text-2xl font-bold text-primary"><%= tesisEnRevisionCount %></p>
                        </div>
                    </div>
                </div>

                <div class="bg-white rounded-xl p-6 border border-gray-200 shadow-sm">
                    <div class="flex items-center">
                        <div class="w-12 h-12 bg-success-100 rounded-lg flex items-center justify-center">
                            <svg class="w-6 h-6 text-success" fill="none" stroke="currentColor" viewBox="0 0 24 24">
                                <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M9 12l2 2 4-4m6 2a9 9 0 11-18 0 9 9 0 0118 0z"/>
                            </svg>
                        </div>
                        <div class="ml-4">
                            <p class="text-sm text-text-secondary">Completadas</p>
                            <p class="text-2xl font-bold text-success"><%= tesisCompletadasCount %></p>
                        </div>
                    </div>
                </div>
            </div>

            <!-- Main Dashboard Grid -->
            <div class="grid grid-cols-1 lg:grid-cols-3 gap-8">
                <!-- Left Column - Thesis Queue -->
                <div class="lg:col-span-2 space-y-8">
                    <!-- Filter Bar -->
                    <div class="bg-white rounded-xl p-6 border border-gray-200 shadow-sm">
                        <div class="flex flex-col md:flex-row gap-4 items-center justify-between">
                            <div class="flex gap-3 flex-1">
                                <select class="form-input text-sm" id="filterStatus">
                                    <option value="TODAS">Todas las tesis</option>
                                    <option value="PENDIENTES">Pendientes</option>
                                    <option value="EN_REVISION">En revisión</option>
                                    <option value="COMPLETADAS">Completadas</option>
                                </select>
                            </div>
                        </div>
                    </div>

                    <!-- Thesis Queue - DINÁMICO -->
                    <div class="space-y-6" id="tesisContainer">
                        <% 
                            // Combinar todas las asignaciones para mostrar
                            List<Asignacion> todasAsignaciones = new ArrayList<>();
                            todasAsignaciones.addAll(tesisPendientes);
                            todasAsignaciones.addAll(tesisEnRevision);
                            todasAsignaciones.addAll(tesisCompletadas);
                            
                            if (todasAsignaciones.isEmpty()) {
                        %>
                            <div class="bg-white rounded-xl p-8 text-center border border-gray-200">
                                <svg class="w-16 h-16 text-gray-300 mx-auto mb-4" fill="none" stroke="currentColor" viewBox="0 0 24 24">
                                    <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M9 12h6m-6 4h6m2 5H7a2 2 0 01-2-2V5a2 2 0 012-2h5.586a1 1 0 01.707.293l5.414 5.414a1 1 0 01.293.707V19a2 2 0 01-2 2z"/>
                                </svg>
                                <h3 class="text-lg font-medium text-gray-900 mb-2">No tienes tesis asignadas para revisión como JURADO</h3>
                                <p class="text-text-secondary mb-4">Cuando te asignen tesis como jurado, aparecerán aquí.</p>
                                <a href="#advisingTab" onclick="switchSection('advising')" class="btn-primary inline-flex items-center">
                                    <svg class="w-4 h-4 mr-2" fill="none" stroke="currentColor" viewBox="0 0 24 24">
                                        <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M17 20h5v-2a3 3 0 00-5.356-1.857M17 20H7m10 0v-2c0-.656-.126-1.283-.356-1.857M7 20H2v-2a3 3 0 015.356-1.857M7 20v-2c0-.656.126-1.283.356-1.857m0 0a5.002 5.002 0 019.288 0M15 7a3 3 0 11-6 0 3 3 0 016 0z"/>
                                    </svg>
                                    Ver mis asesorías
                                </a>
                            </div>
                        <%
                            } else {
                                for (Asignacion asignacion : todasAsignaciones) {
                                    String estado = asignacion.getEstado();
                                    String colorClase = "";
                                    String textoEstado = "";
                                    String textoPrioridad = "";
                                    int progreso = 0;
                                    
                                    if (estado != null) {
                                        switch (estado.toUpperCase()) {
                                            case "ASIGNADA":
                                                colorClase = "border-warning";
                                                textoEstado = "PENDIENTE";
                                                textoPrioridad = "MEDIA";
                                                progreso = 0;
                                                break;
                                            case "EN_REVISION":
                                            case "EN_PROGRESO":
                                                colorClase = "border-primary";
                                                textoEstado = "EN REVISIÓN";
                                                textoPrioridad = "ALTA";
                                                progreso = 50;
                                                break;
                                            case "COMPLETADA":
                                            case "EVALUADA":
                                                colorClase = "border-success";
                                                textoEstado = "COMPLETADA";
                                                textoPrioridad = "COMPLETADO";
                                                progreso = 100;
                                                break;
                                            default:
                                                colorClase = "border-gray-300";
                                                textoEstado = estado;
                                                textoPrioridad = "BAJA";
                                                progreso = 0;
                                        }
                                    }
                        %>
                        <div class="bg-white rounded-xl border-l-4 <%= colorClase %> border-r border-t border-b border-gray-200 shadow-sm overflow-hidden hover:shadow-md transition-standard">
                            <div class="p-6">
                                <div class="flex items-start justify-between mb-4">
                                    <div class="flex items-center space-x-3">
                                        <img src="https://images.unsplash.com/photo-1584824486509-112e4181ff6b?q=80&w=2940&auto=format&fit=crop&ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D" 
                                             alt="Estudiante" 
                                             class="w-12 h-12 rounded-full object-cover">
                                        <div>
                                            <h3 class="text-lg font-semibold text-primary"><%= asignacion.getNombreEstudiante() != null ? asignacion.getNombreEstudiante() : "Estudiante" %></h3>
                                            <p class="text-sm text-text-secondary">ID: #TH-<%= asignacion.getIdTesis() %></p>
                                        </div>
                                    </div>
                                    <div class="flex flex-col items-end space-y-2">
                                        <span class="<%= "ASIGNADA".equals(estado) ? "bg-warning" : ("EN_REVISION".equals(estado) || "EN_PROGRESO".equals(estado) ? "bg-primary" : "bg-success") %> text-white text-xs px-3 py-1 rounded-full font-medium"><%= textoPrioridad %></span>
                                        <span class="text-xs text-text-secondary"><%= textoEstado %></span>
                                    </div>
                                </div>

                                <div class="mb-4">
                                    <h4 class="font-medium text-gray-900 mb-2"><%= asignacion.getTituloTesis() != null ? asignacion.getTituloTesis() : "Sin título" %></h4>
                                    <p class="text-sm text-text-secondary">
                                        <strong>Rol:</strong> <%= asignacion.getRol() != null ? asignacion.getRol() : "JURADO" %><br>
                                        <strong>Observaciones:</strong> <%= asignacion.getObservaciones() != null ? asignacion.getObservaciones() : "Sin observaciones" %>
                                    </p>
                                    <% if (asignacion.getCalificacion() != null) { %>
                                        <p class="text-sm text-text-secondary mt-2">
                                            <strong>Calificación:</strong> <%= asignacion.getCalificacion() %>
                                        </p>
                                    <% } %>
                                </div>

                                <div class="flex items-center justify-between mb-4">
                                    <div class="flex items-center space-x-4 text-sm text-text-secondary">
                                        <span class="flex items-center">
                                            <svg class="w-4 h-4 mr-1" fill="none" stroke="currentColor" viewBox="0 0 24 24">
                                                <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M8 7V3m8 4V3m-9 8h10M5 21h14a2 2 0 002-2V7a2 2 0 00-2-2H5a2 2 0 00-2 2v12a2 2 0 002 2z"/>
                                            </svg>
                                            <% if (asignacion.getFechaAsignacion() != null) { %>
                                                Asignada: <%= sdf.format(asignacion.getFechaAsignacion()) %>
                                            <% } else { %>
                                                Sin fecha asignada
                                            <% } %>
                                        </span>
                                        <span class="flex items-center">
                                            <svg class="w-4 h-4 mr-1" fill="none" stroke="currentColor" viewBox="0 0 24 24">
                                                <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M12 8v4l3 3m6-3a9 9 0 11-18 0 9 9 0 0118 0z"/>
                                            </svg>
                                            <% if (asignacion.getFechaLimite() != null) { 
                                                // Calcular días restantes
                                                java.util.Date hoy = new java.util.Date();
                                                long diferencia = asignacion.getFechaLimite().getTime() - hoy.getTime();
                                                int diasRestantes = (int) (diferencia / (1000 * 60 * 60 * 24));
                                            %>
                                                <% if (diasRestantes < 0) { %>
                                                    Vencida hace <%= Math.abs(diasRestantes) %> días
                                                <% } else if (diasRestantes == 0) { %>
                                                    Vence hoy
                                                <% } else if (diasRestantes == 1) { %>
                                                    Vence en 1 día
                                                <% } else { %>
                                                    Vence en <%= diasRestantes %> días
                                                <% } %>
                                            <% } else { %>
                                                Sin fecha límite
                                            <% } %>
                                        </span>
                                    </div>
                                    <div class="flex items-center text-sm">
                                        <span class="text-primary">Progreso: <%= progreso %>%</span>
                                        <div class="w-20 bg-gray-200 rounded-full h-2 ml-2">
                                            <div class="bg-primary h-2 rounded-full" style="width: <%= progreso %>%"></div>
                                        </div>
                                    </div>
                                </div>

                                <div class="flex gap-3">
                                    <% if (asignacion.getEstado() != null && !asignacion.getEstado().equals("COMPLETADA") && !asignacion.getEstado().equals("EVALUADA")) { %>
                                    <button class="btn-primary flex-1" onclick="openThesisViewer('<%= asignacion.getIdTesis() %>', '<%= asignacion.getId() %>')">
                                        <svg class="w-4 h-4 mr-2" fill="none" stroke="currentColor" viewBox="0 0 24 24">
                                            <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M15 12a3 3 0 11-6 0 3 3 0 016 0z"/>
                                            <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M2.458 12C3.732 7.943 7.523 5 12 5c4.478 0 8.268 2.943 9.542 7-1.274 4.057-5.064 7-9.542 7-4.477 0-8.268-2.943-9.542-7z"/>
                                        </svg>
                                        Revisar
                                    </button>
                                    <button class="btn-secondary" onclick="completarAsignacion(<%= asignacion.getId() %>)">
                                        <svg class="w-4 h-4 mr-2" fill="none" stroke="currentColor" viewBox="0 0 24 24">
                                            <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M5 13l4 4L19 7"/>
                                        </svg>
                                        Completar
                                    </button>
                                    <% } else { %>
                                    <button class="btn-accent flex-1" onclick="viewCompletedThesis('<%= asignacion.getIdTesis() %>', '<%= asignacion.getId() %>')">
                                        <svg class="w-4 h-4 mr-2" fill="none" stroke="currentColor" viewBox="0 0 24 24">
                                            <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M9 12l2 2 4-4m6 2a9 9 0 11-18 0 9 9 0 0118 0z"/>
                                        </svg>
                                        Ver Evaluación
                                    </button>
                                    <% } %>
                                    <button class="btn-secondary" onclick="sendMessageToStudent('<%= asignacion.getNombreEstudiante() %>')">
                                        <svg class="w-4 h-4 mr-2" fill="none" stroke="currentColor" viewBox="0 0 24 24">
                                            <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M8 12h.01M12 12h.01M16 12h.01M21 12c0 4.418-4.03 8-9 8a9.863 9.863 0 01-4.255-.949L3 20l1.395-3.72C3.512 15.042 3 13.574 3 12c0-4.418 4.03-8 9-8s9 3.582 9 8z"/>
                                        </svg>
                                        Mensaje
                                    </button>
                                </div>
                            </div>
                        </div>
                        <%
                                }
                            }
                        %>
                    </div>
                </div>

                <!-- Right Column - Tools & Analytics -->
                <div class="space-y-8">
                    <!-- Review Tools -->
                    <div class="bg-white rounded-xl border border-gray-200 shadow-sm overflow-hidden">
                        <div class="px-6 py-4 border-b border-gray-200 bg-accent-50">
                            <h2 class="text-lg font-semibold text-primary flex items-center">
                                <svg class="w-5 h-5 mr-2" fill="none" stroke="currentColor" viewBox="0 0 24 24">
                                    <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M10.325 4.317c.426-1.756 2.924-1.756 3.35 0a1.724 1.724 0 002.573 1.066c1.543-.94 3.31.826 2.37 2.37a1.724 1.724 0 001.065 2.572c1.756.426 1.756 2.924 0 3.35a1.724 1.724 0 00-1.066 2.573c.94 1.543-.826 3.31-2.37 2.37a1.724 1.724 0 00-2.572 1.065c-.426 1.756-2.924 1.756-3.35 0a1.724 1.724 0 00-2.573-1.066c-1.543.94-3.31-.826-2.37-2.37a1.724 1.724 0 00-1.065-2.572c-1.756-.426-1.756-2.924 0-3.35a1.724 1.724 0 001.066-2.573c-.94-1.543.826-3.31 2.37-2.37.996.608 2.296.07 2.572-1.065z"/>
                                    <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M15 12a3 3 0 11-6 0 3 3 0 016 0z"/>
                                </svg>
                                Herramientas de Evaluación
                            </h2>
                        </div>
                        <div class="p-6">
                            <div class="space-y-4">
                                <button class="w-full btn-primary text-left flex items-center justify-between" onclick="openRubricTemplate()">
                                    <span class="flex items-center">
                                        <svg class="w-5 h-5 mr-3" fill="none" stroke="currentColor" viewBox="0 0 24 24">
                                            <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M9 5H7a2 2 0 00-2 2v12a2 2 0 002 2h10a2 2 0 002-2V7a2 2 0 00-2-2h-2M9 5a2 2 0 002 2h2a2 2 0 002-2M9 5a2 2 0 012-2h2a2 2 0 012 2m-3 7h3m-3 4h3m-6-4h.01M9 16h.01"/>
                                        </svg>
                                        Plantilla de Rúbrica
                                    </span>
                                    <svg class="w-4 h-4" fill="none" stroke="currentColor" viewBox="0 0 24 24">
                                        <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M9 5l7 7-7 7"/>
                                    </svg>
                                </button>

                                <button class="w-full btn-secondary text-left flex items-center justify-between" onclick="openAnnotationTool()">
                                    <span class="flex items-center">
                                        <svg class="w-5 h-5 mr-3" fill="none" stroke="currentColor" viewBox="0 0 24 24">
                                            <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M15.232 5.232l3.536 3.536m-2.036-5.036a2.5 2.5 0 113.536 3.536L6.5 21.036H3v-3.572L16.732 3.732z"/>
                                        </svg>
                                        Herramientas de Anotación
                                    </span>
                                    <svg class="w-4 h-4" fill="none" stroke="currentColor" viewBox="0 0 24 24">
                                        <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M9 5l7 7-7 7"/>
                                    </svg>
                                </button>

                                <button class="w-full btn-accent text-left flex items-center justify-between" onclick="openFeedbackForm()">
                                    <span class="flex items-center">
                                        <svg class="w-5 h-5 mr-3" fill="none" stroke="currentColor" viewBox="0 0 24 24">
                                            <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M7 8h10M7 12h4m1 8l-4-4H5a2 2 0 01-2-2V6a2 2 0 012-2h14a2 2 0 012 2v8a2 2 0 01-2 2h-3l-4 4z"/>
                                        </svg>
                                        Formulario de Retroalimentación
                                    </span>
                                    <svg class="w-4 h-4" fill="none" stroke="currentColor" viewBox="0 0 24 24">
                                        <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M9 5l7 7-7 7"/>
                                    </svg>
                                </button>
                            </div>
                        </div>
                    </div>

                    <!-- Performance Analytics -->
                    <div class="bg-white rounded-xl border border-gray-200 shadow-sm overflow-hidden">
                        <div class="px-6 py-4 border-b border-gray-200 bg-primary-50">
                            <h2 class="text-lg font-semibold text-primary flex items-center">
                                <svg class="w-5 h-5 mr-2" fill="none" stroke="currentColor" viewBox="0 0 24 24">
                                    <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M9 19v-6a2 2 0 00-2-2H5a2 2 0 00-2 2v6a2 2 0 002 2h2a2 2 0 002-2zm0 0V9a2 2 0 012-2h2a2 2 0 012 2v10m-6 0a2 2 0 002 2h2a2 2 0 002-2m0 0V5a2 2 0 012-2h2a2 2 0 012 2v14a2 2 0 01-2 2h-2a2 2 0 01-2-2z"/>
                                </svg>
                                Mi Rendimiento
                            </h2>
                        </div>
                        <div class="p-6">
                            <div class="space-y-6">
                                <!-- Monthly Stats -->
                                <div class="text-center">
                                    <div class="text-3xl font-bold text-primary mb-1"><%= tesisRevisadasMes %></div>
                                    <div class="text-sm text-text-secondary">Tesis revisadas este mes</div>
                                </div>

                                <!-- Performance Metrics -->
                                <div class="space-y-4">
                                    <div class="flex items-center justify-between">
                                        <span class="text-sm text-text-secondary">Tiempo Promedio</span>
                                        <span class="text-sm font-medium text-primary"><%= tiempoPromedio %> días</span>
                                    </div>
                                    <div class="flex items-center justify-between">
                                        <span class="text-sm text-text-secondary">Calificación de Estudiantes</span>
                                        <div class="flex items-center space-x-1">
                                            <span class="text-sm font-medium text-accent"><%= calificacionEstudiantes %></span>
                                            <div class="flex">
                                                <% for(int i = 0; i < 5; i++) { %>
                                                    <svg class="w-4 h-4 text-accent" fill="currentColor" viewBox="0 0 20 20">
                                                        <path d="M9.049 2.927c.3-.921 1.603-.921 1.902 0l1.07 3.292a1 1 0 00.95.69h3.462c.969 0 1.371 1.24.588 1.81l-2.8 2.034a1 1 0 00-.364 1.118l1.07 3.292c.3.921-.755 1.688-1.54 1.118l-2.8-2.034a1 1 0 00-1.175 0l-2.8 2.034c-.784.57-1.838-.197-1.539-1.118l1.07-3.292a1 1 0 00-.364-1.118L2.98 8.72c-.783-.57-.38-1.81.588-1.81h3.461a1 1 0 00.951-.69l1.07-3.292z"/>
                                                    </svg>
                                                <% } %>
                                            </div>
                                        </div>
                                    </div>
                                    <div class="flex items-center justify-between">
                                        <span class="text-sm text-text-secondary">Tasa de Aprobación</span>
                                        <span class="text-sm font-medium text-success"><%= tasaAprobacion %>%</span>
                                    </div>
                                </div>

                                <!-- Progress Chart (Simplified) -->
                                <div class="pt-4 border-t border-gray-200">
                                    <div class="text-xs text-text-secondary mb-2">Carga de trabajo semanal</div>
                                    <div class="flex items-end space-x-1 h-16">
                                        <div class="bg-primary-200 w-4 h-8 rounded-sm"></div>
                                        <div class="bg-primary-300 w-4 h-12 rounded-sm"></div>
                                        <div class="bg-primary-400 w-4 h-16 rounded-sm"></div>
                                        <div class="bg-primary-500 w-4 h-10 rounded-sm"></div>
                                        <div class="bg-primary-600 w-4 h-14 rounded-sm"></div>
                                        <div class="bg-primary w-4 h-12 rounded-sm"></div>
                                        <div class="bg-primary-400 w-4 h-8 rounded-sm"></div>
                                    </div>
                                    <div class="flex justify-between text-xs text-text-secondary mt-1">
                                        <span>Lun</span>
                                        <span>Vie</span>
                                    </div>
                                </div>
                            </div>
                        </div>
                    </div>

                    <!-- Quick Actions -->
                    <div class="bg-gradient-to-br from-secondary to-accent text-white rounded-xl p-6 shadow-sm">
                        <h3 class="text-lg font-semibold mb-4">Acciones Rápidas</h3>
                        <div class="space-y-3">
                            <button class="w-full bg-white bg-opacity-20 hover:bg-opacity-30 backdrop-blur-sm rounded-lg p-3 text-left transition-standard" onclick="generarReporteMensual()">
                                <div class="flex items-center">
                                    <svg class="w-5 h-5 mr-3" fill="none" stroke="currentColor" viewBox="0 0 24 24">
                                        <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M8 7V3a2 2 0 012-2h4a2 2 0 012 2v4m-6 0V6a2 2 0 012-2h4a2 2 0 012 2v1m-6 0h6m-6 0l-.5 8.5A2 2 0 0011 18h2a2 2 0 002-1.5L14.5 7"/>
                                    </svg>
                                    <span class="text-sm font-medium">Generar Reporte Mensual</span>
                                </div>
                            </button>
                            
                            <button class="w-full bg-white bg-opacity-20 hover:bg-opacity-30 backdrop-blur-sm rounded-lg p-3 text-left transition-standard" onclick="sincronizarCalendario()">
                                <div class="flex items-center">
                                    <svg class="w-5 h-5 mr-3" fill="none" stroke="currentColor" viewBox="0 0 24 24">
                                        <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M8 7h12m0 0l-4-4m4 4l-4 4m0 6H4m0 0l4 4m-4-4l4-4"/>
                                    </svg>
                                    <span class="text-sm font-medium">Sincronizar Calendario</span>
                                </div>
                            </button>
                            
                            <button class="w-full bg-white bg-opacity-20 hover:bg-opacity-30 backdrop-blur-sm rounded-lg p-3 text-left transition-standard" onclick="exportarPlantillas()">
                                <div class="flex items-center">
                                    <svg class="w-5 h-5 mr-3" fill="none" stroke="currentColor" viewBox="0 0 24 24">
                                        <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M12 6.253v13m0-13C10.832 5.477 9.246 5 7.5 5S4.168 5.477 3 6.253v13C4.168 18.477 5.754 18 7.5 18s3.332.477 4.5 1.253m0-13C13.168 5.477 14.754 5 16.5 5c1.746 0 3.332.477 4.5 1.253v13C19.832 18.477 18.246 18 16.5 18c-1.746 0-3.332.477-4.5 1.253"/>
                                    </svg>
                                    <span class="text-sm font-medium">Exportar Plantillas</span>
                                </div>
                            </button>
                        </div>
                    </div>
                </div>
            </div>
        </div>

        <!-- Sección de Asesoría (oculta por defecto) -->
        <div id="advisingSection" class="hidden">
            <!-- Welcome Header específico para asesorías -->
            <div class="mb-8">
                <h1 class="text-3xl font-bold text-primary mb-2">Asesorías de Tesis</h1>
                <p class="text-text-secondary">Gestiona tus sesiones de asesoría y guía a los estudiantes en el desarrollo de sus investigaciones.</p>
            </div>

            <!-- Quick Stats para Asesorías -->
            <div class="grid grid-cols-1 md:grid-cols-4 gap-6 mb-8">
                <div class="bg-white rounded-xl p-6 border border-gray-200 shadow-sm">
                    <div class="flex items-center">
                        <div class="w-12 h-12 bg-accent-100 rounded-lg flex items-center justify-center">
                            <svg class="w-6 h-6 text-accent" fill="none" stroke="currentColor" viewBox="0 0 24 24">
                                <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M17 20h5v-2a3 3 0 00-5.356-1.857M17 20H7m10 0v-2c0-.656-.126-1.283-.356-1.857M7 20H2v-2a3 3 0 015.356-1.857M7 20v-2c0-.656.126-1.283.356-1.857m0 0a5.002 5.002 0 019.288 0M15 7a3 3 0 11-6 0 3 3 0 016 0zm6 3a2 2 0 11-4 0 2 2 0 014 0zM7 10a2 2 0 11-4 0 2 2 0 014 0z"/>
                            </svg>
                        </div>
                        <div class="ml-4">
                            <p class="text-sm text-text-secondary">Asesorías Activas</p>
                            <p class="text-2xl font-bold text-accent"><%= asesoriasActivas %></p>
                        </div>
                    </div>
                </div>

                <div class="bg-white rounded-xl p-6 border border-gray-200 shadow-sm">
                    <div class="flex items-center">
                        <div class="w-12 h-12 bg-primary-100 rounded-lg flex items-center justify-center">
                            <svg class="w-6 h-6 text-primary" fill="none" stroke="currentColor" viewBox="0 0 24 24">
                                <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M12 8v4l3 3m6-3a9 9 0 11-18 0 9 9 0 0118 0z"/>
                            </svg>
                        </div>
                        <div class="ml-4">
                            <p class="text-sm text-text-secondary">Sesiones este Mes</p>
                            <p class="text-2xl font-bold text-primary"><%= sesionesMes %></p>
                        </div>
                    </div>
                </div>

                <div class="bg-white rounded-xl p-6 border border-gray-200 shadow-sm">
                    <div class="flex items-center">
                        <div class="w-12 h-12 bg-warning-100 rounded-lg flex items-center justify-center">
                            <svg class="w-6 h-6 text-warning" fill="none" stroke="currentColor" viewBox="0 0 24 24">
                                <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M12 19l9 2-9-18-9 18 9-2zm0 0v-8"/>
                            </svg>
                        </div>
                        <div class="ml-4">
                            <p class="text-sm text-text-secondary">Horas de Asesoría</p>
                            <p class="text-2xl font-bold text-warning"><%= horasTotales %>h</p>
                        </div>
                    </div>
                </div>

                <div class="bg-white rounded-xl p-6 border border-gray-200 shadow-sm">
                    <div class="flex items-center">
                        <div class="w-12 h-12 bg-success-100 rounded-lg flex items-center justify-center">
                            <svg class="w-6 h-6 text-success" fill="none" stroke="currentColor" viewBox="0 0 24 24">
                                <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M11.049 2.927c.3-.921 1.603-.921 1.902 0l1.519 4.674a1 1 0 00.95.69h4.915c.969 0 1.371 1.24.588 1.81l-3.976 2.888a1 1 0 00-.363 1.118l1.518 4.674c.3.922-.755 1.688-1.538 1.118l-3.976-2.888a1 1 0 00-1.176 0l-3.976 2.888c-.783.57-1.838-.197-1.538-1.118l1.518-4.674a1 1 0 00-.363-1.118l-3.976-2.888c-.784-.57-.38-1.81.588-1.81h4.914a1 1 0 00.951-.69l1.519-4.674z"/>
                            </svg>
                        </div>
                        <div class="ml-4">
                            <p class="text-sm text-text-secondary">Satisfacción</p>
                            <p class="text-2xl font-bold text-success"><%= satisfaccionEstudiantes %>/5.0</p>
                        </div>
                    </div>
                </div>
            </div>

            <!-- Main Dashboard Grid para Asesorías -->
            <div class="grid grid-cols-1 lg:grid-cols-3 gap-8">
                <!-- Left Column - Lista de Estudiantes Asesorados -->
                <div class="lg:col-span-2 space-y-8">
                    <!-- Filter Bar -->
                    <div class="bg-white rounded-xl p-6 border border-gray-200 shadow-sm">
                        <div class="flex flex-col md:flex-row gap-4 items-center justify-between">
                            <div class="flex gap-3 flex-1">
                                <select class="form-input text-sm" id="filterStatusAdvising">
                                    <option value="TODOS">Todos los estudiantes</option>
                                    <option value="ACTIVOS">Activos</option>
                                    <option value="EN_PAUSA">En pausa</option>
                                    <option value="COMPLETADOS">Completados</option>
                                </select>
                                <input type="text" class="form-input text-sm" placeholder="Buscar estudiante..." id="searchStudent" onkeyup="filtrarEstudiantes()">
                            </div>
                        </div>
                    </div>

                    <!-- Lista de Estudiantes Asesorados - DINÁMICO -->
                    <div class="space-y-6" id="asesoriasContainer">
                        <% 
                            if (asignacionesAsesor.isEmpty()) {
                        %>
                            <div class="bg-white rounded-xl p-8 text-center border border-gray-200">
                                <svg class="w-16 h-16 text-gray-300 mx-auto mb-4" fill="none" stroke="currentColor" viewBox="0 0 24 24">
                                    <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M17 20h5v-2a3 3 0 00-5.356-1.857M17 20H7m10 0v-2c0-.656-.126-1.283-.356-1.857M7 20H2v-2a3 3 0 015.356-1.857M7 20v-2c0-.656.126-1.283.356-1.857m0 0a5.002 5.002 0 019.288 0M15 7a3 3 0 11-6 0 3 3 0 016 0z"/>
                                </svg>
                                <h3 class="text-lg font-medium text-gray-900 mb-2">No tienes asesorías activas</h3>
                                <p class="text-text-secondary mb-4">Cuando te asignen estudiantes para asesorar, aparecerán aquí.</p>
                            </div>
                        <%
                            } else {
                                for (Asignacion asignacion : asignacionesAsesor) {
                                    String estado = asignacion.getEstado();
                                    String colorClase = "";
                                    String textoEstado = "";
                                    
                                    if (estado != null) {
                                        switch (estado.toUpperCase()) {
                                            case "ASIGNADA":
                                            case "EN_PROGRESO":
                                                colorClase = "border-primary";
                                                textoEstado = "ACTIVO";
                                                break;
                                            case "EN_PAUSA":
                                                colorClase = "border-warning";
                                                textoEstado = "EN PAUSA";
                                                break;
                                            case "COMPLETADA":
                                            case "EVALUADA":
                                                colorClase = "border-success";
                                                textoEstado = "COMPLETADO";
                                                break;
                                            default:
                                                colorClase = "border-gray-300";
                                                textoEstado = estado;
                                        }
                                    }
                        %>
                        <div class="asesoria-item bg-white rounded-xl border-l-4 <%= colorClase %> border-r border-t border-b border-gray-200 shadow-sm hover:shadow-md transition-standard">
                            <div class="p-6">
                                <div class="flex items-start justify-between mb-4">
                                    <div class="flex items-center space-x-3">
                                        <img src="https://images.unsplash.com/photo-1584824486509-112e4181ff6b?q=80&w=2940&auto=format&fit=crop&ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D" 
                                             alt="Estudiante" 
                                             class="w-12 h-12 rounded-full object-cover">
                                        <div>
                                            <h3 class="estudiante-nombre text-lg font-semibold text-primary"><%= asignacion.getNombreEstudiante() != null ? asignacion.getNombreEstudiante() : "Estudiante" %></h3>
                                            <p class="text-sm text-text-secondary">ID: #TH-<%= asignacion.getIdTesis() %></p>
                                            <div class="flex items-center mt-1">
                                                <span class="estudiante-estado <%= "ASIGNADA".equals(estado) || "EN_PROGRESO".equals(estado) ? "bg-primary-100 text-primary" : ("EN_PAUSA".equals(estado) ? "bg-warning-100 text-warning" : "bg-success-100 text-success") %> text-xs px-2 py-1 rounded-full"><%= textoEstado %></span>
                                            </div>
                                        </div>
                                    </div>
                                </div>

                                <div class="mb-4">
                                    <h4 class="font-medium text-gray-900 mb-2"><%= asignacion.getTituloTesis() != null ? asignacion.getTituloTesis() : "Sin título" %></h4>
                                    <div class="flex flex-wrap gap-2 mb-2">
                                        <span class="bg-gray-100 text-gray-700 text-xs px-2 py-1 rounded">Asesoría</span>
                                        <span class="bg-gray-100 text-gray-700 text-xs px-2 py-1 rounded">Rol: <%= asignacion.getRol() %></span>
                                    </div>
                                    <p class="text-sm text-text-secondary">
                                        <span class="font-medium">Observaciones:</span> 
                                        <%= asignacion.getObservaciones() != null ? asignacion.getObservaciones() : "Sin observaciones" %>
                                    </p>
                                </div>

                                <div class="flex items-center justify-between mb-4">
                                    <div class="flex items-center space-x-4 text-sm text-text-secondary">
                                        <span class="flex items-center">
                                            <svg class="w-4 h-4 mr-1" fill="none" stroke="currentColor" viewBox="0 0 24 24">
                                                <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M8 7V3m8 4V3m-9 8h10M5 21h14a2 2 0 002-2V7a2 2 0 00-2-2H5a2 2 0 00-2 2v12a2 2 0 002 2z"/>
                                            </svg>
                                            <% if (asignacion.getFechaAsignacion() != null) { %>
                                                Asignada: <%= sdf.format(asignacion.getFechaAsignacion()) %>
                                            <% } else { %>
                                                Sin fecha asignada
                                            <% } %>
                                        </span>
                                        <span class="flex items-center">
                                            <svg class="w-4 h-4 mr-1" fill="none" stroke="currentColor" viewBox="0 0 24 24">
                                                <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M12 8v4l3 3m6-3a9 9 0 11-18 0 9 9 0 0118 0z"/>
                                            </svg>
                                            <% if (asignacion.getFechaLimite() != null) { 
                                                // Calcular días restantes
                                                java.util.Date hoy = new java.util.Date();
                                                long diferencia = asignacion.getFechaLimite().getTime() - hoy.getTime();
                                                int diasRestantes = (int) (diferencia / (1000 * 60 * 60 * 24));
                                            %>
                                                <% if (diasRestantes < 0) { %>
                                                    Vencida hace <%= Math.abs(diasRestantes) %> días
                                                <% } else if (diasRestantes == 0) { %>
                                                    Vence hoy
                                                <% } else if (diasRestantes == 1) { %>
                                                    Vence en 1 día
                                                <% } else { %>
                                                    Vence en <%= diasRestantes %> días
                                                <% } %>
                                            <% } else { %>
                                                Sin fecha límite
                                            <% } %>
                                        </span>
                                    </div>
                                </div>

                                <div class="flex gap-3">
                                    <button class="btn-primary flex-1" onclick="openThesisViewer('<%= asignacion.getIdTesis() %>', '<%= asignacion.getId() %>')">
                                        <svg class="w-4 h-4 mr-2" fill="none" stroke="currentColor" viewBox="0 0 24 24">
                                            <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M15 12a3 3 0 11-6 0 3 3 0 016 0z"/>
                                            <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M2.458 12C3.732 7.943 7.523 5 12 5c4.478 0 8.268 2.943 9.542 7-1.274 4.057-5.064 7-9.542 7-4.477 0-8.268-2.943-9.542-7z"/>
                                        </svg>
                                        Ver Detalles
                                    </button>
                                    <button class="btn-secondary" onclick="sendMessageToStudent('<%= asignacion.getNombreEstudiante() %>')">
                                        <svg class="w-4 h-4 mr-2" fill="none" stroke="currentColor" viewBox="0 0 24 24">
                                            <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M8 12h.01M12 12h.01M16 12h.01M21 12c0 4.418-4.03 8-9 8a9.863 9.863 0 01-4.255-.949L3 20l1.395-3.72C3.512 15.042 3 13.574 3 12c0-4.418 4.03-8 9-8s9 3.582 9 8z"/>
                                        </svg>
                                        Mensaje
                                    </button>
                                </div>
                            </div>
                        </div>
                        <%
                                }
                            }
                        %>
                    </div>
                </div>

                <!-- Right Column - Calendario y Herramientas -->
                <div class="space-y-8">
                    <!-- Calendario de Sesiones -->
                    <div class="bg-white rounded-xl border border-gray-200 shadow-sm overflow-hidden">
                        <div class="px-6 py-4 border-b border-gray-200 bg-primary-50">
                            <h2 class="text-lg font-semibold text-primary flex items-center justify-between">
                                <span class="flex items-center">
                                    <svg class="w-5 h-5 mr-2" fill="none" stroke="currentColor" viewBox="0 0 24 24">
                                        <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M8 7V3m8 4V3m-9 8h10M5 21h14a2 2 0 002-2V7a2 2 0 00-2-2H5a2 2 0 00-2 2v12a2 2 0 002 2z"/>
                                    </svg>
                                    Próximas Sesiones
                                </span>
                                <span class="text-sm font-normal text-primary-700"><%= new SimpleDateFormat("MMMM yyyy").format(new java.util.Date()) %></span>
                            </h2>
                        </div>
                        <div class="p-6">
                            <div class="space-y-4">
                                <!-- Ejemplo de sesión -->
                                <div class="flex items-center p-3 bg-accent-50 rounded-lg">
                                    <div class="text-center mr-4">
                                        <div class="text-2xl font-bold text-accent"><%= new java.util.Date().getDate() + 2 %></div>
                                        <div class="text-xs text-accent"><%= new SimpleDateFormat("MMM").format(new java.util.Date()) %></div>
                                    </div>
                                    <div class="flex-1">
                                        <h4 class="font-medium text-gray-900">Sesión de Asesoría</h4>
                                        <p class="text-sm text-text-secondary">10:00 AM - 11:30 AM</p>
                                        <p class="text-xs text-text-secondary mt-1">Revisión de avances</p>
                                    </div>
                                </div>

                                <!-- Más sesiones -->
                                <div class="flex items-center p-3 bg-primary-50 rounded-lg">
                                    <div class="text-center mr-4">
                                        <div class="text-2xl font-bold text-primary"><%= new java.util.Date().getDate() + 5 %></div>
                                        <div class="text-xs text-primary"><%= new SimpleDateFormat("MMM").format(new java.util.Date()) %></div>
                                    </div>
                                    <div class="flex-1">
                                        <h4 class="font-medium text-gray-900">Revisión de Capítulos</h4>
                                        <p class="text-sm text-text-secondary">2:00 PM - 3:30 PM</p>
                                        <p class="text-xs text-text-secondary mt-1">Capítulo 3: Metodología</p>
                                    </div>
                                </div>
                            </div>
                        </div>
                    </div>

                    <!-- Herramientas de Asesoría -->
                    <div class="bg-white rounded-xl border border-gray-200 shadow-sm overflow-hidden">
                        <div class="px-6 py-4 border-b border-gray-200 bg-accent-50">
                            <h2 class="text-lg font-semibold text-primary flex items-center">
                                <svg class="w-5 h-5 mr-2" fill="none" stroke="currentColor" viewBox="0 0 24 24">
                                    <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M10.325 4.317c.426-1.756 2.924-1.756 3.35 0a1.724 1.724 0 002.573 1.066c1.543-.94 3.31.826 2.37 2.37a1.724 1.724 0 001.065 2.572c1.756.426 1.756 2.924 0 3.35a1.724 1.724 0 00-1.066 2.573c.94 1.543-.826 3.31-2.37 2.37a1.724 1.724 0 00-2.572 1.065c-.426 1.756-2.924 1.756-3.35 0a1.724 1.724 0 00-2.573-1.066c-1.543.94-3.31-.826-2.37-2.37a1.724 1.724 0 00-1.065-2.572c-1.756-.426-1.756-2.924 0-3.35a1.724 1.724 0 001.066-2.573c-.94-1.543.826-3.31 2.37-2.37.996.608 2.296.07 2.572-1.065z"/>
                                    <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M15 12a3 3 0 11-6 0 3 3 0 016 0z"/>
                                </svg>
                                Recursos de Asesoría
                            </h2>
                        </div>
                        <div class="p-6">
                            <div class="space-y-4">
                                <button class="w-full btn-primary text-left flex items-center justify-between" onclick="openTemplate('metodologia')">
                                    <span class="flex items-center">
                                        <svg class="w-5 h-5 mr-3" fill="none" stroke="currentColor" viewBox="0 0 24 24">
                                            <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M9 12h6m-6 4h6m2 5H7a2 2 0 01-2-2V5a2 2 0 012-2h5.586a1 1 0 01.707.293l5.414 5.414a1 1 0 01.293.707V19a2 2 0 01-2 2z"/>
                                        </svg>
                                        Plantillas de Metodología
                                    </span>
                                    <svg class="w-4 h-4" fill="none" stroke="currentColor" viewBox="0 0 24 24">
                                        <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M9 5l7 7-7 7"/>
                                    </svg>
                                </button>

                                <button class="w-full btn-secondary text-left flex items-center justify-between" onclick="openTemplate('cronograma')">
                                    <span class="flex items-center">
                                        <svg class="w-5 h-5 mr-3" fill="none" stroke="currentColor" viewBox="0 0 24 24">
                                            <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M9 5H7a2 2 0 00-2 2v12a2 2 0 002 2h10a2 2 0 002-2V7a2 2 0 00-2-2h-2M9 5a2 2 0 002 2h2a2 2 0 002-2M9 5a2 2 0 012-2h2a2 2 0 012 2"/>
                                        </svg>
                                        Cronogramas de Investigación
                                    </span>
                                    <svg class="w-4 h-4" fill="none" stroke="currentColor" viewBox="0 0 24 24">
                                        <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M9 5l7 7-7 7"/>
                                    </svg>
                                </button>

                                <button class="w-full btn-accent text-left flex items-center justify-between" onclick="openTemplate('evaluacion')">
                                    <span class="flex items-center">
                                        <svg class="w-5 h-5 mr-3" fill="none" stroke="currentColor" viewBox="0 0 24 24">
                                            <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M9 19v-6a2 2 0 00-2-2H5a2 2 0 00-2 2v6a2 2 0 002 2h2a2 2 0 002-2zm0 0V9a2 2 0 012-2h2a2 2 0 012 2v10m-6 0a2 2 0 002 2h2a2 2 0 002-2m0 0V5a2 2 0 012-2h2a2 2 0 012 2v14a2 2 0 01-2 2h-2a2 2 0 01-2-2z"/>
                                        </svg>
                                        Formatos de Evaluación
                                    </span>
                                    <svg class="w-4 h-4" fill="none" stroke="currentColor" viewBox="0 0 24 24">
                                        <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M9 5l7 7-7 7"/>
                                    </svg>
                                </button>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </div>

    <!-- Modales -->
<!-- Modal para enviar mensaje -->
<!-- Modal para enviar mensaje -->
<div id="messageModal" class="modal-overlay">
    <div class="modal-container max-w-md">
        <div class="modal-header">
            <h3 class="modal-title text-gray-900">Enviar mensaje al estudiante</h3>
        </div>
        <div class="modal-body">
            <form id="messageForm" onsubmit="sendMessageForm(event)">
                <!-- Campos ocultos para información necesaria -->
                <input type="hidden" id="messageStudentId" name="studentId">
                <input type="hidden" id="messageAsignacionId" name="asignacionId">
                
                <div class="mb-4">
                    <label for="studentName" class="block text-sm font-medium text-gray-700 mb-1">Estudiante</label>
                    <input type="text" id="studentName" class="form-input w-full" readonly>
                </div>
                <div class="mb-4">
                    <label for="messageSubject" class="block text-sm font-medium text-gray-700 mb-1">Asunto</label>
                    <input type="text" id="messageSubject" class="form-input w-full" placeholder="Asunto del mensaje" required>
                </div>
                <div class="mb-6">
                    <label for="messageContent" class="block text-sm font-medium text-gray-700 mb-1">Mensaje</label>
                    <textarea id="messageContent" rows="4" class="form-input w-full" placeholder="Escribe tu mensaje aquí..." required></textarea>
                </div>
                <div class="modal-footer">
                    <button type="button" class="btn-secondary" onclick="closeModal('messageModal')">Cancelar</button>
                    <button type="submit" class="btn-primary">Enviar Mensaje</button>
                </div>
            </form>
        </div>
    </div>
</div>
<!-- Modal para plantilla de rúbrica -->
<div id="rubricModal" class="modal-overlay">
    <div class="modal-container max-w-4xl">
        <div class="modal-header">
            <h3 class="modal-title text-gray-900">Plantilla de Rúbrica de Evaluación</h3>
        </div>
        <div class="modal-body">
            <div class="space-y-4">
                <p class="text-sm text-gray-600">Seleccione una plantilla de rúbrica para la evaluación de la tesis:</p>
                <div class="grid grid-cols-1 md:grid-cols-2 gap-4">
                    <div class="template-option" onclick="selectRubric('standard')">
                        <h4 class="font-medium text-gray-900">Rúbrica Estándar</h4>
                        <p class="text-sm text-gray-600">Evaluación general de tesis de maestría</p>
                    </div>
                    <div class="template-option" onclick="selectRubric('detailed')">
                        <h4 class="font-medium text-gray-900">Rúbrica Detallada</h4>
                        <p class="text-sm text-gray-600">Evaluación exhaustiva por capítulos</p>
                    </div>
                    <div class="template-option" onclick="selectRubric('methodology')">
                        <h4 class="font-medium text-gray-900">Rúbrica de Metodología</h4>
                        <p class="text-sm text-gray-600">Enfoque en la metodología de investigación</p>
                    </div>
                    <div class="template-option" onclick="selectRubric('presentation')">
                        <h4 class="font-medium text-gray-900">Rúbrica de Presentación</h4>
                        <p class="text-sm text-gray-600">Evaluación de defensa y presentación</p>
                    </div>
                </div>
            </div>
        </div>
        <div class="modal-footer">
            <button type="button" class="btn-secondary" onclick="closeModal('rubricModal')">Cancelar</button>
            <button type="button" class="btn-primary" onclick="downloadRubric()">Descargar Plantilla</button>
        </div>
    </div>
</div>

<!-- Modal para herramientas de anotación -->
<div id="annotationModal" class="modal-overlay">
    <div class="modal-container max-w-4xl">
        <div class="modal-header">
            <h3 class="modal-title text-gray-900">Herramientas de Anotación</h3>
        </div>
        <div class="modal-body">
            <div class="space-y-4">
                <p class="text-sm text-gray-600">Seleccione una herramienta de anotación para utilizar en la revisión:</p>
                <div class="grid grid-cols-1 md:grid-cols-3 gap-4">
                    <div class="tool-option" onclick="selectAnnotationTool('comments')">
                        <svg class="w-8 h-8 mx-auto text-primary" fill="none" stroke="currentColor" viewBox="0 0 24 24">
                            <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M7 8h10M7 12h4m1 8l-4-4H5a2 2 0 01-2-2V6a2 2 0 012-2h14a2 2 0 012 2v8a2 2 0 01-2 2h-3l-4 4z"/>
                        </svg>
                        <h4 class="font-medium text-gray-900 mt-2">Comentarios</h4>
                        <p class="text-sm text-gray-600">Agregar comentarios al documento</p>
                    </div>
                    <div class="tool-option" onclick="selectAnnotationTool('highlight')">
                        <svg class="w-8 h-8 mx-auto text-accent" fill="none" stroke="currentColor" viewBox="0 0 24 24">
                            <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M15.232 5.232l3.536 3.536m-2.036-5.036a2.5 2.5 0 113.536 3.536L6.5 21.036H3v-3.572L16.732 3.732z"/>
                        </svg>
                        <h4 class="font-medium text-gray-900 mt-2">Resaltar Texto</h4>
                        <p class="text-sm text-gray-600">Resaltar secciones importantes</p>
                    </div>
                    <div class="tool-option" onclick="selectAnnotationTool('draw')">
                        <svg class="w-8 h-8 mx-auto text-secondary" fill="none" stroke="currentColor" viewBox="0 0 24 24">
                            <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M15.232 5.232l3.536 3.536m-2.036-5.036a2.5 2.5 0 113.536 3.536L6.5 21.036H3v-3.572L16.732 3.732z"/>
                        </svg>
                        <h4 class="font-medium text-gray-900 mt-2">Dibujar</h4>
                        <p class="text-sm text-gray-600">Dibujar formas y flechas</p>
                    </div>
                </div>
            </div>
        </div>
        <div class="modal-footer">
            <button type="button" class="btn-secondary" onclick="closeModal('annotationModal')">Cancelar</button>
            <button type="button" class="btn-primary" onclick="openAnnotationEditor()">Abrir Editor</button>
        </div>
    </div>
</div>

<!-- Modal para formulario de retroalimentación -->
<div id="feedbackModal" class="modal-overlay">
    <div class="modal-container max-w-4xl">
        <div class="modal-header">
            <h3 class="modal-title text-gray-900">Formulario de Retroalimentación</h3>
        </div>
        <div class="modal-body">
            <form id="feedbackForm" onsubmit="submitFeedbackForm(event)">
                <div class="modal-grid-2">
                    <div>
                        <label class="block text-sm font-medium text-gray-700 mb-1">Seleccionar Tesis</label>
                        <select id="feedbackThesis" class="form-input w-full" required>
                            <option value="">Seleccionar tesis...</option>
                            <% for (Asignacion asignacion : todasAsignaciones) { %>
                                <option value="<%= asignacion.getIdTesis() %>">
                                    <%= asignacion.getTituloTesis() != null ? asignacion.getTituloTesis() : "Sin título" %>
                                </option>
                            <% } %>
                        </select>
                    </div>
                    <div>
                        <label class="block text-sm font-medium text-gray-700 mb-1">Tipo de Retroalimentación</label>
                        <select id="feedbackType" class="form-input w-full" required>
                            <option value="general">General</option>
                            <option value="estructura">Estructura</option>
                            <option value="contenido">Contenido</option>
                            <option value="metodologia">Metodología</option>
                            <option value="formato">Formato</option>
                        </select>
                    </div>
                </div>
                
                <div class="mt-4">
                    <label class="block text-sm font-medium text-gray-700 mb-1">Puntos Fuertes</label>
                    <textarea id="strengths" rows="3" class="form-input w-full" placeholder="Menciona los puntos fuertes del trabajo..." required></textarea>
                </div>
                
                <div class="mt-4">
                    <label class="block text-sm font-medium text-gray-700 mb-1">Áreas de Mejora</label>
                    <textarea id="improvements" rows="3" class="form-input w-full" placeholder="Sugerencias para mejorar..." required></textarea>
                </div>
                
                <div class="mt-4">
                    <label class="block text-sm font-medium text-gray-700 mb-1">Recomendaciones</label>
                    <textarea id="recommendations" rows="3" class="form-input w-full" placeholder="Recomendaciones específicas..." required></textarea>
                </div>
                
                <div class="mt-6">
                    <label class="block text-sm font-medium text-gray-700 mb-1">Calificación General (1-5)</label>
                    <div class="flex items-center space-x-2">
                        <% for(int i = 1; i <= 5; i++) { %>
                            <button type="button" class="rating-btn p-2 rounded-full hover:bg-gray-100" onclick="setRating(<%= i %>)" data-rating="<%= i %>">
                                <svg class="w-6 h-6 text-gray-300" fill="currentColor" viewBox="0 0 20 20">
                                    <path d="M9.049 2.927c.3-.921 1.603-.921 1.902 0l1.07 3.292a1 1 0 00.95.69h3.462c.969 0 1.371 1.24.588 1.81l-2.8 2.034a1 1 0 00-.364 1.118l1.07 3.292c.3.921-.755 1.688-1.54 1.118l-2.8-2.034a1 1 0 00-1.175 0l-2.8 2.034c-.784.57-1.838-.197-1.539-1.118l1.07-3.292a1 1 0 00-.364-1.118L2.98 8.72c-.783-.57-.38-1.81.588-1.81h3.461a1 1 0 00.951-.69l1.07-3.292z"/>
                                </svg>
                            </button>
                        <% } %>
                        <input type="hidden" id="ratingValue" name="rating" required>
                    </div>
                </div>
                
                <div class="modal-footer">
                    <button type="button" class="btn-secondary" onclick="closeModal('feedbackModal')">Cancelar</button>
                    <button type="submit" class="btn-primary">Guardar Retroalimentación</button>
                </div>
            </form>
        </div>
    </div>
</div>

<!-- Modal para generar reporte mensual -->
<div id="reportModal" class="modal-overlay">
    <div class="modal-container max-w-2xl">
        <div class="modal-header">
            <h3 class="modal-title text-gray-900">Generar Reporte Mensual</h3>
        </div>
        <div class="modal-body">
            <form id="reportForm" onsubmit="generateReport(event)">
                <div class="modal-grid-2">
                    <div>
                        <label class="block text-sm font-medium text-gray-700 mb-1">Mes</label>
                        <select id="reportMonth" class="form-input w-full" required>
                            <option value="">Seleccionar mes...</option>
                            <option value="01">Enero</option>
                            <option value="02">Febrero</option>
                            <option value="03">Marzo</option>
                            <option value="04">Abril</option>
                            <option value="05">Mayo</option>
                            <option value="06">Junio</option>
                            <option value="07">Julio</option>
                            <option value="08">Agosto</option>
                            <option value="09">Septiembre</option>
                            <option value="10">Octubre</option>
                            <option value="11">Noviembre</option>
                            <option value="12">Diciembre</option>
                        </select>
                    </div>
                    <div>
                        <label class="block text-sm font-medium text-gray-700 mb-1">Año</label>
                        <select id="reportYear" class="form-input w-full" required>
                            <option value="">Seleccionar año...</option>
                            <% 
                                int currentYear = java.util.Calendar.getInstance().get(java.util.Calendar.YEAR);
                                for(int i = currentYear; i >= currentYear - 5; i--) { 
                            %>
                                <option value="<%= i %>"><%= i %></option>
                            <% } %>
                        </select>
                    </div>
                </div>
                
                <div class="mt-4">
                    <label class="block text-sm font-medium text-gray-700 mb-1">Tipo de Reporte</label>
                    <div class="space-y-2">
                        <label class="flex items-center">
                            <input type="checkbox" name="reportType" value="revisiones" class="rounded border-gray-300 text-primary focus:ring-primary" checked>
                            <span class="ml-2 text-sm text-gray-700">Revisiones realizadas</span>
                        </label>
                        <label class="flex items-center">
                            <input type="checkbox" name="reportType" value="asesorias" class="rounded border-gray-300 text-primary focus:ring-primary" checked>
                            <span class="ml-2 text-sm text-gray-700">Asesorías realizadas</span>
                        </label>
                        <label class="flex items-center">
                            <input type="checkbox" name="reportType" value="estadisticas" class="rounded border-gray-300 text-primary focus:ring-primary" checked>
                            <span class="ml-2 text-sm text-gray-700">Estadísticas de desempeño</span>
                        </label>
                        <label class="flex items-center">
                            <input type="checkbox" name="reportType" value="pendientes" class="rounded border-gray-300 text-primary focus:ring-primary">
                            <span class="ml-2 text-sm text-gray-700">Tareas pendientes</span>
                        </label>
                    </div>
                </div>
                
                <div class="mt-4">
                    <label class="block text-sm font-medium text-gray-700 mb-1">Formato del Reporte</label>
                    <div class="flex space-x-4">
                        <label class="flex items-center">
                            <input type="radio" name="reportFormat" value="pdf" class="text-primary focus:ring-primary" checked>
                            <span class="ml-2 text-sm text-gray-700">PDF</span>
                        </label>
                        <label class="flex items-center">
                            <input type="radio" name="reportFormat" value="excel" class="text-primary focus:ring-primary">
                            <span class="ml-2 text-sm text-gray-700">Excel</span>
                        </label>
                        <label class="flex items-center">
                            <input type="radio" name="reportFormat" value="word" class="text-primary focus:ring-primary">
                            <span class="ml-2 text-sm text-gray-700">Word</span>
                        </label>
                    </div>
                </div>
                
                <div class="modal-footer">
                    <button type="button" class="btn-secondary" onclick="closeModal('reportModal')">Cancelar</button>
                    <button type="submit" class="btn-primary">Generar Reporte</button>
                </div>
            </form>
        </div>
    </div>
</div>

<!-- Modal para sincronizar calendario -->
<div id="calendarModal" class="modal-overlay">
    <div class="modal-container max-w-md">
        <div class="modal-header">
            <h3 class="modal-title text-gray-900">Sincronizar Calendario</h3>
        </div>
        <div class="modal-body">
            <form id="calendarForm" onsubmit="syncCalendar(event)">
                <div class="space-y-4">
                    <div>
                        <label class="block text-sm font-medium text-gray-700 mb-1">Plataforma de Calendario</label>
                        <select id="calendarPlatform" class="form-input w-full" required>
                            <option value="">Seleccionar plataforma...</option>
                            <option value="google">Google Calendar</option>
                            <option value="outlook">Microsoft Outlook</option>
                            <option value="apple">Apple Calendar</option>
                            <option value="ical">Calendario iCal</option>
                        </select>
                    </div>
                    
                    <div>
                        <label class="block text-sm font-medium text-gray-700 mb-1">Sincronizar</label>
                        <div class="space-y-2">
                            <label class="flex items-center">
                                <input type="checkbox" name="calendarItems" value="sesiones" class="rounded border-gray-300 text-primary focus:ring-primary" checked>
                                <span class="ml-2 text-sm text-gray-700">Sesiones de asesoría</span>
                            </label>
                            <label class="flex items-center">
                                <input type="checkbox" name="calendarItems" value="revisiones" class="rounded border-gray-300 text-primary focus:ring-primary" checked>
                                <span class="ml-2 text-sm text-gray-700">Fechas de revisión</span>
                            </label>
                            <label class="flex items-center">
                                <input type="checkbox" name="calendarItems" value="vencimientos" class="rounded border-gray-300 text-primary focus:ring-primary">
                                <span class="ml-2 text-sm text-gray-700">Fechas de vencimiento</span>
                            </label>
                            <label class="flex items-center">
                                <input type="checkbox" name="calendarItems" value="recordatorios" class="rounded border-gray-300 text-primary focus:ring-primary">
                                <span class="ml-2 text-sm text-gray-700">Recordatorios</span>
                            </label>
                        </div>
                    </div>
                    
                    <div>
                        <label class="block text-sm font-medium text-gray-700 mb-1">Período de Sincronización</label>
                        <select id="syncPeriod" class="form-input w-full" required>
                            <option value="30">Próximos 30 días</option>
                            <option value="90">Próximos 90 días</option>
                            <option value="180">Próximos 6 meses</option>
                            <option value="365">Próximo año</option>
                        </select>
                    </div>
                </div>
                
                <div class="modal-footer">
                    <button type="button" class="btn-secondary" onclick="closeModal('calendarModal')">Cancelar</button>
                    <button type="submit" class="btn-primary">Sincronizar</button>
                </div>
            </form>
        </div>
    </div>
</div>

<!-- Modal para exportar plantillas -->
<div id="exportModal" class="modal-overlay">
    <div class="modal-container max-w-2xl">
        <div class="modal-header">
            <h3 class="modal-title text-gray-900">Exportar Plantillas</h3>
        </div>
        <div class="modal-body">
            <form id="exportForm" onsubmit="exportTemplates(event)">
                <div class="space-y-4">
                    <div>
                        <label class="block text-sm font-medium text-gray-700 mb-1">Seleccionar Plantillas</label>
                        <div class="space-y-2">
                            <label class="flex items-center">
                                <input type="checkbox" name="templates" value="rubrica" class="rounded border-gray-300 text-primary focus:ring-primary" checked>
                                <span class="ml-2 text-sm text-gray-700">Plantillas de Rúbrica</span>
                            </label>
                            <label class="flex items-center">
                                <input type="checkbox" name="templates" value="evaluacion" class="rounded border-gray-300 text-primary focus:ring-primary" checked>
                                <span class="ml-2 text-sm text-gray-700">Formularios de Evaluación</span>
                            </label>
                            <label class="flex items-center">
                                <input type="checkbox" name="templates" value="informe" class="rounded border-gray-300 text-primary focus:ring-primary">
                                <span class="ml-2 text-sm text-gray-700">Plantillas de Informe</span>
                            </label>
                            <label class="flex items-center">
                                <input type="checkbox" name="templates" value="asesoria" class="rounded border-gray-300 text-primary focus:ring-primary">
                                <span class="ml-2 text-sm text-gray-700">Formatos de Asesoría</span>
                            </label>
                            <label class="flex items-center">
                                <input type="checkbox" name="templates" value="cronograma" class="rounded border-gray-300 text-primary focus:ring-primary">
                                <span class="ml-2 text-sm text-gray-700">Cronogramas</span>
                            </label>
                        </div>
                    </div>
                    
                    <div class="modal-grid-2">
                        <div>
                            <label class="block text-sm font-medium text-gray-700 mb-1">Formato de Exportación</label>
                            <select id="exportFormat" class="form-input w-full" required>
                                <option value="zip">Paquete ZIP</option>
                                <option value="pdf">PDF individual</option>
                                <option value="docx">Word (.docx)</option>
                                <option value="excel">Excel (.xlsx)</option>
                            </select>
                        </div>
                        
                        <div>
                            <label class="block text-sm font-medium text-gray-700 mb-1">Incluir</label>
                            <div class="space-y-1">
                                <label class="flex items-center">
                                    <input type="checkbox" name="includeItems" value="instrucciones" class="rounded border-gray-300 text-primary focus:ring-primary" checked>
                                    <span class="ml-2 text-sm text-gray-700">Instrucciones</span>
                                </label>
                                <label class="flex items-center">
                                    <input type="checkbox" name="includeItems" value="ejemplos" class="rounded border-gray-300 text-primary focus:ring-primary">
                                    <span class="ml-2 text-sm text-gray-700">Ejemplos completados</span>
                                </label>
                            </div>
                        </div>
                    </div>
                </div>
                
                <div class="modal-footer">
                    <button type="button" class="btn-secondary" onclick="closeModal('exportModal')">Cancelar</button>
                    <button type="submit" class="btn-primary">Exportar Plantillas</button>
                </div>
            </form>
        </div>
    </div>
</div>

<!-- Modal para nueva asesoría -->
<div id="newAdvisingModal" class="modal-overlay">
    <div class="modal-container max-w-2xl">
        <div class="modal-header">
            <h3 class="modal-title text-gray-900">Nueva Sesión de Asesoría</h3>
        </div>
        <div class="modal-body">
            <form id="advisingForm" onsubmit="submitAdvisingForm(event)">
                <div class="modal-grid-2">
                    <div>
                        <label class="block text-sm font-medium text-gray-700 mb-1">Estudiante</label>
                        <select id="advisingStudent" class="form-input w-full" required>
                            <option value="">Seleccionar estudiante...</option>
                            <% for (Asignacion asignacion : asignacionesAsesor) { %>
                                <option value="<%= asignacion.getNombreEstudiante() %>">
                                    <%= asignacion.getNombreEstudiante() != null ? asignacion.getNombreEstudiante() : "Estudiante" %>
                                </option>
                            <% } %>
                        </select>
                    </div>
                    <div>
                        <label class="block text-sm font-medium text-gray-700 mb-1">Tipo de Sesión</label>
                        <select id="sessionType" class="form-input w-full" required>
                            <option value="regular">Regular</option>
                            <option value="avance">Revisión de Avances</option>
                            <option value="metodologia">Metodología</option>
                            <option value="correccion">Corrección</option>
                        </select>
                    </div>
                </div>
                
                <div class="mt-4">
                    <label class="block text-sm font-medium text-gray-700 mb-1">Fecha y Hora</label>
                    <div class="modal-grid-2">
                        <input type="date" id="sessionDate" class="form-input" required>
                        <input type="time" id="sessionTime" class="form-input" required>
                    </div>
                </div>
                
                <div class="mt-4">
                    <label class="block text-sm font-medium text-gray-700 mb-1">Duración (minutos)</label>
                    <input type="number" id="sessionDuration" class="form-input w-full" min="15" max="180" value="60" required>
                </div>
                
                <div class="mt-4">
                    <label class="block text-sm font-medium text-gray-700 mb-1">Modalidad</label>
                    <div class="flex space-x-4">
                        <label class="flex items-center">
                            <input type="radio" name="sessionMode" value="presencial" class="text-primary focus:ring-primary" checked>
                            <span class="ml-2 text-sm text-gray-700">Presencial</span>
                        </label>
                        <label class="flex items-center">
                            <input type="radio" name="sessionMode" value="virtual" class="text-primary focus:ring-primary">
                            <span class="ml-2 text-sm text-gray-700">Virtual</span>
                        </label>
                    </div>
                </div>
                
                <div class="mt-4">
                    <label class="block text-sm font-medium text-gray-700 mb-1">Temas a Tratar</label>
                    <textarea id="sessionTopics" rows="3" class="form-input w-full" placeholder="Lista de temas a discutir en la sesión..." required></textarea>
                </div>
                
                <div class="mt-4">
                    <label class="block text-sm font-medium text-gray-700 mb-1">Materiales Requeridos</label>
                    <textarea id="sessionMaterials" rows="2" class="form-input w-full" placeholder="Materiales que el estudiante debe traer..."></textarea>
                </div>
                
                <div class="modal-footer">
                    <button type="button" class="btn-secondary" onclick="closeModal('newAdvisingModal')">Cancelar</button>
                    <button type="submit" class="btn-primary">Programar Sesión</button>
                </div>
            </form>
        </div>
    </div>
</div>
                        
                        <!-- Modal para visualizar documento de tesis -->
<div id="thesisViewerModal" class="modal-overlay">
    <div class="modal-container max-w-7xl" style="height: 90vh;">
        <div class="modal-header flex justify-between items-center">
            <h3 class="modal-title text-gray-900">Revisar Documento de Tesis</h3>
            <button type="button" onclick="closeModal('thesisViewerModal')" class="text-gray-400 hover:text-gray-500">
                <svg class="w-6 h-6" fill="none" stroke="currentColor" viewBox="0 0 24 24">
                    <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M6 18L18 6M6 6l12 12"/>
                </svg>
            </button>
        </div>
        <div class="modal-body" style="height: calc(90vh - 120px); overflow-y: auto;">
            <!-- Contenedor del documento -->
            <div id="documentContainer" class="bg-white rounded-lg border border-gray-200 p-6">
                <!-- Documento se cargará aquí dinámicamente -->
                <div class="text-center py-12" id="loadingDocument">
                    <div class="inline-block animate-spin rounded-full h-12 w-12 border-b-2 border-primary"></div>
                    <p class="mt-4 text-text-secondary">Cargando documento...</p>
                </div>
                <iframe id="pdfViewer" class="w-full h-full" style="display: none; min-height: 600px;" frameborder="0"></iframe>
                <div id="textViewer" style="display: none;"></div>
            </div>
            
            <!-- Panel de herramientas de revisión -->
            <div class="mt-6 bg-gray-50 rounded-lg p-4 border border-gray-200">
                <div class="flex flex-wrap gap-3">
                    <button onclick="toggleAnnotationMode()" class="btn-secondary flex items-center">
                        <svg class="w-4 h-4 mr-2" fill="none" stroke="currentColor" viewBox="0 0 24 24">
                            <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M15.232 5.232l3.536 3.536m-2.036-5.036a2.5 2.5 0 113.536 3.536L6.5 21.036H3v-3.572L16.732 3.732z"/>
                        </svg>
                        Anotar
                    </button>
                    <button onclick="addComment()" class="btn-secondary flex items-center">
                        <svg class="w-4 h-4 mr-2" fill="none" stroke="currentColor" viewBox="0 0 24 24">
                            <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M7 8h10M7 12h4m1 8l-4-4H5a2 2 0 01-2-2V6a2 2 0 012-2h14a2 2 0 012 2v8a2 2 0 01-2 2h-3l-4 4z"/>
                        </svg>
                        Comentar
                    </button>
                    <button onclick="downloadDocument()" class="btn-primary flex items-center">
                        <svg class="w-4 h-4 mr-2" fill="none" stroke="currentColor" viewBox="0 0 24 24">
                            <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M4 16v1a3 3 0 003 3h10a3 3 0 003-3v-1m-4-4l-4 4m0 0l-4-4m4 4V4"/>
                        </svg>
                        Descargar
                    </button>
                    <button onclick="submitReview()" class="btn-accent flex items-center ml-auto">
                        <svg class="w-4 h-4 mr-2" fill="none" stroke="currentColor" viewBox="0 0 24 24">
                            <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M5 13l4 4L19 7"/>
                        </svg>
                        Enviar Revisión
                    </button>
                </div>
                
                <!-- Área de comentarios -->
                <div class="mt-4" id="commentSection" style="display: none;">
                    <textarea id="commentText" class="form-input w-full" rows="3" placeholder="Escribe tu comentario aquí..."></textarea>
                    <div class="flex justify-end mt-2">
                        <button onclick="saveComment()" class="btn-primary px-4 py-2">Guardar Comentario</button>
                    </div>
                </div>
            </div>
        </div>
        <div class="modal-footer">
            <button type="button" class="btn-secondary" onclick="closeModal('thesisViewerModal')">Cerrar</button>
            <button type="button" class="btn-primary" onclick="saveReviewProgress()">Guardar Progreso</button>
        </div>
    </div>
</div>

    <script>
        
        // Funciones para el visor de documentos
function toggleAnnotationMode() {
    showNotification('Modo de anotación activado', 'info');
    // Aquí iría la lógica para activar anotaciones en el documento
}

function addComment() {
    const commentSection = document.getElementById('commentSection');
    commentSection.style.display = commentSection.style.display === 'none' ? 'block' : 'none';
}

function saveComment() {
    const commentText = document.getElementById('commentText').value;
    if (commentText.trim()) {
        // Guardar comentario (aquí deberías enviarlo al servidor)
        showNotification('Comentario guardado', 'success');
        document.getElementById('commentText').value = '';
        document.getElementById('commentSection').style.display = 'none';
    } else {
        showNotification('Por favor, escribe un comentario', 'warning');
    }
}

function downloadDocument() {
    showNotification('Descargando documento...', 'info');
    // Simular descarga
    setTimeout(() => {
        showNotification('Documento descargado exitosamente', 'success');
    }, 1000);
}

function submitReview() {
    if (confirm('¿Estás seguro de que deseas enviar tu revisión?')) {
        showNotification('Enviando revisión...', 'info');
        // Aquí iría la lógica para enviar la revisión al servidor
        setTimeout(() => {
            showNotification('Revisión enviada exitosamente', 'success');
            closeModal('thesisViewerModal');
        }, 1500);
    }
}

function saveReviewProgress() {
    showNotification('Progreso guardado', 'info');
    // Aquí iría la lógica para guardar el progreso en el servidor
}


// ========== FUNCIONES PRINCIPALES DE MODALES ==========
function openModal(modalId) {
    const modal = document.getElementById(modalId);
    modal.classList.add('active');
    document.body.style.overflow = 'hidden';
}

function closeModal(modalId) {
    const modal = document.getElementById(modalId);
    modal.classList.remove('active');
    document.body.style.overflow = 'auto';
}

// Cerrar modal haciendo clic fuera
document.addEventListener('DOMContentLoaded', function() {
    document.querySelectorAll('.modal-overlay').forEach(modal => {
        modal.addEventListener('click', function(e) {
            if (e.target === this) {
                closeModal(this.id);
            }
        });
    });
});

// ========== FUNCIONES PARA APERTURA DE MODALES ==========
function sendMessageToStudent(studentName) {
    document.getElementById('studentName').value = studentName;
    openModal('messageModal');
}

function openRubricTemplate() {
    openModal('rubricModal');
}

function openAnnotationTool() {
    openModal('annotationModal');
}

function openFeedbackForm() {
    openModal('feedbackModal');
}

function generarReporteMensual() {
    openModal('reportModal');
}

function sincronizarCalendario() {
    openModal('calendarModal');
}

function exportarPlantillas() {
    openModal('exportModal');
}

function openNewAdvisingModal() {
    openModal('newAdvisingModal');
}

// ========== FUNCIONES PARA MANEJO DE FORMULARIOS ==========
function sendMessageForm(event) {
    event.preventDefault();
    const studentName = document.getElementById('studentName').value;
    const subject = document.getElementById('messageSubject').value;
    
    showNotification(`Mensaje enviado a ${studentName}: ${subject}`, 'success');
    closeModal('messageModal');
    document.getElementById('messageForm').reset();
}

function selectRubric(type) {
    const rubrics = {
        standard: 'Rúbrica Estándar seleccionada',
        detailed: 'Rúbrica Detallada seleccionada',
        methodology: 'Rúbrica de Metodología seleccionada',
        presentation: 'Rúbrica de Presentación seleccionada'
    };
    
    document.querySelectorAll('.template-option').forEach(option => {
        option.classList.remove('selected');
    });
    
    event.currentTarget.classList.add('selected');
    showNotification(rubrics[type], 'info');
}

function downloadRubric() {
    showNotification('Descargando plantilla de rúbrica...', 'info');
    setTimeout(() => {
        showNotification('Plantilla descargada exitosamente', 'success');
    }, 1000);
    closeModal('rubricModal');
}

function selectAnnotationTool(tool) {
    const tools = {
        comments: 'Herramienta de comentarios seleccionada',
        highlight: 'Herramienta de resaltado seleccionada',
        draw: 'Herramienta de dibujo seleccionada'
    };
    
    document.querySelectorAll('.tool-option').forEach(option => {
        option.classList.remove('selected');
    });
    
    event.currentTarget.classList.add('selected');
    showNotification(tools[tool], 'info');
}

function openAnnotationEditor() {
    showNotification('Abriendo editor de anotaciones...', 'info');
    setTimeout(() => {
        showNotification('Editor de anotaciones listo', 'success');
    }, 500);
    closeModal('annotationModal');
}

function submitFeedbackForm(event) {
    event.preventDefault();
    const thesisId = document.getElementById('feedbackThesis').value;
    
    showNotification(`Retroalimentación guardada para tesis ${thesisId}`, 'success');
    closeModal('feedbackModal');
    document.getElementById('feedbackForm').reset();
    setRating(3);
}

function setRating(rating) {
    if (document.getElementById('ratingValue')) {
        document.getElementById('ratingValue').value = rating;
        
        const stars = document.querySelectorAll('.rating-btn');
        stars.forEach((star, index) => {
            const svg = star.querySelector('svg');
            if (index < rating) {
                svg.style.color = '#f97316';
                star.classList.add('active');
            } else {
                svg.style.color = '#d1d5db';
                star.classList.remove('active');
            }
        });
    }
}

function generateReport(event) {
    event.preventDefault();
    const month = document.getElementById('reportMonth').value;
    const year = document.getElementById('reportYear').value;
    
    showNotification(`Generando reporte de ${month}/${year}...`, 'info');
    setTimeout(() => {
        showNotification('Reporte generado exitosamente', 'success');
    }, 1500);
    closeModal('reportModal');
}

function syncCalendar(event) {
    event.preventDefault();
    const platform = document.getElementById('calendarPlatform').value;
    
    showNotification(`Sincronizando con ${platform}...`, 'info');
    setTimeout(() => {
        showNotification('Calendario sincronizado exitosamente', 'success');
    }, 1500);
    closeModal('calendarModal');
}

function exportTemplates(event) {
    event.preventDefault();
    const format = document.getElementById('exportFormat').value;
    
    showNotification(`Exportando plantillas en formato ${format.toUpperCase()}...`, 'info');
    setTimeout(() => {
        showNotification('Plantillas exportadas exitosamente', 'success');
    }, 1500);
    closeModal('exportModal');
}

function submitAdvisingForm(event) {
    event.preventDefault();
    const student = document.getElementById('advisingStudent').value;
    
    showNotification(`Sesión programada para ${student}`, 'success');
    closeModal('newAdvisingModal');
    document.getElementById('advisingForm').reset();
}

// ========== SISTEMA DE NOTIFICACIONES ==========
function showNotification(message, type = 'info') {
    const notification = document.createElement('div');
    
    // Colores según tipo
    let bgColor = 'bg-white';
    let textColor = 'text-gray-900';
    let borderColor = 'border-gray-200';
    let iconColor = 'text-blue-500';
    let iconPath = 'M13 16h-1v-4h-1m1-4h.01M21 12a9 9 0 11-18 0 9 9 0 0118 0z';
    
    if (type === 'success') {
        bgColor = 'bg-green-50';
        borderColor = 'border-green-200';
        iconColor = 'text-green-500';
        iconPath = 'M5 13l4 4L19 7';
    } else if (type === 'error') {
        bgColor = 'bg-red-50';
        borderColor = 'border-red-200';
        iconColor = 'text-red-500';
        iconPath = 'M6 18L18 6M6 6l12 12';
    } else if (type === 'warning') {
        bgColor = 'bg-yellow-50';
        borderColor = 'border-yellow-200';
        iconColor = 'text-yellow-500';
        iconPath = 'M12 9v2m0 4h.01m-6.938 4h13.856c1.54 0 2.502-1.667 1.732-2.5L13.732 4c-.77-.833-1.998-.833-2.732 0L4.346 16.5c-.77.833.192 2.5 1.732 2.5z';
    }
    
    notification.className = `fixed top-4 right-4 z-50 max-w-sm w-full ${bgColor} border ${borderColor} rounded-lg shadow-lg p-4`;
    
    notification.innerHTML = `
        <div class="flex items-center">
            <svg class="w-5 h-5 ${iconColor} mr-3" fill="none" stroke="currentColor" viewBox="0 0 24 24">
                <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="${iconPath}"/>
            </svg>
            <p class="text-sm ${textColor}">${message}</p>
        </div>
    `;
    
    document.body.appendChild(notification);
    
    setTimeout(() => {
        notification.style.opacity = '1';
        notification.style.transform = 'translateX(0)';
    }, 10);
    
    setTimeout(() => {
        notification.style.opacity = '0';
        notification.style.transform = 'translateX(100%)';
        setTimeout(() => {
            if (document.body.contains(notification)) {
                document.body.removeChild(notification);
            }
        }, 300);
    }, 4000);
}

// ========== FUNCIÓN PARA CAMBIAR SECCIONES ==========
function switchSection(section) {
    // Ocultar todas las secciones
    document.getElementById('reviewsSection').classList.add('hidden');
    document.getElementById('advisingSection').classList.add('hidden');
    
    // Mostrar la sección seleccionada
    document.getElementById(section + 'Section').classList.remove('hidden');
    
    // Actualizar los botones del menú
    const reviewsTab = document.getElementById('reviewsTab');
    const advisingTab = document.getElementById('advisingTab');
    
    if (reviewsTab && advisingTab) {
        // Resetear ambos botones
        reviewsTab.classList.remove('text-primary', 'bg-primary-50');
        reviewsTab.classList.add('text-text-secondary');
        advisingTab.classList.remove('text-primary', 'bg-primary-50');
        advisingTab.classList.add('text-text-secondary');
        
        // Activar el botón correspondiente
        if (section === 'reviews') {
            reviewsTab.classList.remove('text-text-secondary');
            reviewsTab.classList.add('text-primary', 'bg-primary-50');
        } else {
            advisingTab.classList.remove('text-text-secondary');
            advisingTab.classList.add('text-primary', 'bg-primary-50');
        }
    }
    
    // Mostrar notificación
    if (section === 'reviews') {
        showNotification('Mostrando tesis asignadas como jurado', 'info');
    } else if (section === 'advising') {
        showNotification('Mostrando tesis asignadas como asesor', 'info');
    }
}

// ========== FILTRADO DE TESIS ==========
document.addEventListener('DOMContentLoaded', function() {
    const filterStatus = document.getElementById('filterStatus');
    if (filterStatus) {
        filterStatus.addEventListener('change', function() {
            const status = this.value;
            const tesisCards = document.querySelectorAll('#tesisContainer > div');
            
            tesisCards.forEach(card => {
                const estadoElement = card.querySelector('.text-xs:last-child');
                if (!estadoElement) return;
                
                const estado = estadoElement.textContent.toUpperCase();
                
                if (status === 'TODAS' || 
                    (status === 'PENDIENTES' && estado.includes('PENDIENTE')) ||
                    (status === 'EN_REVISION' && estado.includes('EN REVISIÓN')) ||
                    (status === 'COMPLETADAS' && estado.includes('COMPLETADA'))) {
                    card.style.display = 'block';
                } else {
                    card.style.display = 'none';
                }
            });
        });
    }
});

// ========== FILTRADO DE ESTUDIANTES ==========
function filtrarEstudiantes() {
    const status = document.getElementById('filterStatusAdvising').value;
    const searchTerm = document.getElementById('searchStudent').value.toLowerCase();
    const asesorias = document.querySelectorAll('.asesoria-item');
    
    asesorias.forEach(asesoria => {
        const estudianteNombre = asesoria.querySelector('.estudiante-nombre').textContent.toLowerCase();
        const estudianteEstado = asesoria.querySelector('.estudiante-estado').textContent.toUpperCase();
        
        let estadoMatch = true;
        if (status === 'ACTIVOS' && !estudianteEstado.includes('ACTIVO')) estadoMatch = false;
        if (status === 'EN_PAUSA' && !estudianteEstado.includes('PAUSA')) estadoMatch = false;
        if (status === 'COMPLETADOS' && !estudianteEstado.includes('COMPLETADO')) estadoMatch = false;
        
        const searchMatch = estudianteNombre.includes(searchTerm);
        
        if (estadoMatch && searchMatch) {
            asesoria.style.display = 'block';
        } else {
            asesoria.style.display = 'none';
        }
    });
}

// ========== INICIALIZACIÓN ==========
document.addEventListener('DOMContentLoaded', function() {
    // Configurar rating por defecto
    setRating(3);
    
    // Configurar fecha actual para nueva asesoría
    const today = new Date();
    const tomorrow = new Date(today);
    tomorrow.setDate(tomorrow.getDate() + 1);
    
    if (document.getElementById('sessionDate')) {
        document.getElementById('sessionDate').value = tomorrow.toISOString().split('T')[0];
    }
    if (document.getElementById('sessionTime')) {
        document.getElementById('sessionTime').value = '10:00';
    }
    
    // Configurar mes y año actual para reportes
    const currentMonth = (today.getMonth() + 1).toString().padStart(2, '0');
    const currentYear = today.getFullYear();
    
    if (document.getElementById('reportMonth')) {
        document.getElementById('reportMonth').value = currentMonth;
    }
    if (document.getElementById('reportYear')) {
        document.getElementById('reportYear').value = currentYear;
    }
    
    // Eventos de clic para rating
    document.querySelectorAll('.rating-btn').forEach(btn => {
        btn.addEventListener('click', function() {
            const rating = parseInt(this.getAttribute('data-rating') || 3);
            setRating(rating);
        });
    });
    
    // Eventos para opciones de rúbrica
    document.querySelectorAll('.template-option').forEach(option => {
        option.addEventListener('click', function() {
            const onclickAttr = this.getAttribute('onclick');
            if (onclickAttr) {
                const match = onclickAttr.match(/'([^']+)'/);
                if (match) {
                    selectRubric(match[1]);
                }
            }
        });
    });
    
    // Eventos para herramientas de anotación
    document.querySelectorAll('.tool-option').forEach(option => {
        option.addEventListener('click', function() {
            const onclickAttr = this.getAttribute('onclick');
            if (onclickAttr) {
                const match = onclickAttr.match(/'([^']+)'/);
                if (match) {
                    selectAnnotationTool(match[1]);
                }
            }
        });
    });
    
    // Dropdown menu
    const userMenuButton = document.getElementById('user-menu-button');
    const userDropdown = document.getElementById('user-dropdown');
    const logoutButton = document.getElementById('logout-button');
    
    if (userMenuButton && userDropdown) {
        userMenuButton.addEventListener('click', function(e) {
            e.stopPropagation();
            userDropdown.classList.toggle('show');
        });
        
        document.addEventListener('click', function(e) {
            if (!userMenuButton.contains(e.target) && !userDropdown.contains(e.target)) {
                userDropdown.classList.remove('show');
            }
        });
        
        if (logoutButton) {
            logoutButton.addEventListener('click', function() {
                if (confirm('¿Estás seguro de que deseas cerrar sesión?')) {
                    showNotification('Cerrando sesión...', 'info');
                    setTimeout(() => {
                        window.location.href = 'LoginController?action=logout';
                    }, 1500);
                }
            });
        }
    }
    
    // Inicializar sección
    const urlParams = new URLSearchParams(window.location.search);
    const section = urlParams.get('section');
    
    if (section === 'advising') {
        switchSection('advising');
    } else {
        switchSection('reviews');
    }
    
    // Mostrar mensaje de bienvenida
    setTimeout(() => {
        showNotification(`¡Bienvenido de vuelta!`, 'info');
    }, 1000);
});

// ========== FUNCIONES ESPECÍFICAS DE LA APLICACIÓN ==========
function completarAsignacion(asignacionId) {
    if (confirm('¿Estás seguro de que deseas marcar esta asignación como completada?')) {
        fetch('AsignacionController?action=completar&id=' + asignacionId, {
            method: 'POST'
        })
        .then(response => {
            if (response.ok) {
                showNotification('Asignación completada exitosamente', 'success');
                setTimeout(() => {
                    location.reload();
                }, 1500);
            } else {
                showNotification('Error al completar la asignación', 'error');
            }
        })
        .catch(error => {
            showNotification('Error de conexión', 'error');
        });
    }
}

function openThesisViewer(thesisId, asignacionId) {
    // Mostrar el modal
    openModal('thesisViewerModal');
    
    // Ocultar elementos iniciales
    document.getElementById('pdfViewer').style.display = 'none';
    document.getElementById('textViewer').style.display = 'none';
    document.getElementById('commentSection').style.display = 'none';
    
    // Mostrar carga
    document.getElementById('loadingDocument').style.display = 'block';
    
    // Actualizar título del modal
    const modalTitle = document.querySelector('#thesisViewerModal .modal-title');
    modalTitle.textContent = `Revisando Tesis #TH-${thesisId}`;
    
    // Aquí deberías hacer una llamada AJAX para obtener la información del documento
    fetch(`TesisController?action=obtenerDocumento&id=${thesisId}&asignacionId=${asignacionId}`)
        .then(response => {
            if (response.ok) {
                return response.json();
            }
            throw new Error('Error al cargar el documento');
        })
        .then(data => {
            // Ocultar indicador de carga
            document.getElementById('loadingDocument').style.display = 'none';
            
            if (data.documentoUrl) {
                // Si es un PDF
                if (data.documentoUrl.toLowerCase().endsWith('.pdf')) {
                    const pdfViewer = document.getElementById('pdfViewer');
                    pdfViewer.src = data.documentoUrl;
                    pdfViewer.style.display = 'block';
                } 
                // Si es un documento de texto
                else if (data.documentoUrl.toLowerCase().endsWith('.doc') || 
                         data.documentoUrl.toLowerCase().endsWith('.docx') ||
                         data.documentoUrl.toLowerCase().endsWith('.txt')) {
                    // Mostrar enlace para descarga
                    const textViewer = document.getElementById('textViewer');
                    textViewer.innerHTML = `
                        <div class="text-center p-8">
                            <svg class="w-16 h-16 text-primary mx-auto mb-4" fill="none" stroke="currentColor" viewBox="0 0 24 24">
                                <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M9 12h6m-6 4h6m2 5H7a2 2 0 01-2-2V5a2 2 0 012-2h5.586a1 1 0 01.707.293l5.414 5.414a1 1 0 01.293.707V19a2 2 0 01-2 2z"/>
                            </svg>
                            <h4 class="text-lg font-semibold text-gray-900 mb-2">Documento de Tesis</h4>
                            <p class="text-text-secondary mb-4">${data.titulo || 'Sin título'}</p>
                            <a href="${data.documentoUrl}" target="_blank" class="btn-primary inline-flex items-center">
                                <svg class="w-4 h-4 mr-2" fill="none" stroke="currentColor" viewBox="0 0 24 24">
                                    <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M4 16v1a3 3 0 003 3h10a3 3 0 003-3v-1m-4-4l-4 4m0 0l-4-4m4 4V4"/>
                                </svg>
                                Descargar Documento
                            </a>
                        </div>
                    `;
                    textViewer.style.display = 'block';
                }
            } else {
                // Si no hay documento, mostrar mensaje
                const textViewer = document.getElementById('textViewer');
                textViewer.innerHTML = `
                    <div class="text-center p-8">
                        <svg class="w-16 h-16 text-gray-300 mx-auto mb-4" fill="none" stroke="currentColor" viewBox="0 0 24 24">
                            <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M9 12h6m-6 4h6m2 5H7a2 2 0 01-2-2V5a2 2 0 012-2h5.586a1 1 0 01.707.293l5.414 5.414a1 1 0 01.293.707V19a2 2 0 01-2 2z"/>
                        </svg>
                        <h4 class="text-lg font-medium text-gray-900 mb-2">Documento no disponible</h4>
                        <p class="text-text-secondary">El estudiante no ha subido el documento aún.</p>
                    </div>
                `;
                textViewer.style.display = 'block';
            }
            
            // Mostrar información adicional si está disponible
            if (data.estudianteNombre) {
                const studentInfo = document.createElement('div');
                studentInfo.className = 'mt-4 p-4 bg-blue-50 rounded-lg';
                studentInfo.innerHTML = `
                    <h4 class="font-medium text-gray-900">Información del Estudiante</h4>
                    <p class="text-sm text-gray-600">Estudiante: ${data.estudianteNombre}</p>
                    <p class="text-sm text-gray-600">Título: ${data.titulo || 'No especificado'}</p>
                    <p class="text-sm text-gray-600">Fecha de entrega: ${data.fechaEntrega || 'No especificada'}</p>
                `;
                document.getElementById('documentContainer').appendChild(studentInfo);
            }
        })
        .catch(error => {
            console.error('Error:', error);
            document.getElementById('loadingDocument').style.display = 'none';
            const textViewer = document.getElementById('textViewer');
            textViewer.innerHTML = `
                <div class="text-center p-8">
                    <svg class="w-16 h-16 text-red-300 mx-auto mb-4" fill="none" stroke="currentColor" viewBox="0 0 24 24">
                        <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M12 8v4m0 4h.01M21 12a9 9 0 11-18 0 9 9 0 0118 0z"/>
                    </svg>
                    <h4 class="text-lg font-medium text-gray-900 mb-2">Error al cargar el documento</h4>
                    <p class="text-text-secondary">${error.message}</p>
                </div>
            `;
            textViewer.style.display = 'block';
        });
    
    // Guardar IDs para uso posterior
    window.currentThesisId = thesisId;
    window.currentAsignacionId = asignacionId;
}

function viewCompletedThesis(thesisId, asignacionId) {
    showNotification(`Visualizando evaluación completa`, 'success');
    window.location.href = `AsignacionController?action=obtenerPorId&id=${asignacionId}`;
}

// ========== ESTILOS DINÁMICOS ==========
const dynamicStyles = document.createElement('style');
dynamicStyles.textContent = `
    .template-option.selected,
    .tool-option.selected {
        background-color: #eff6ff !important;
        border-color: #3b82f6 !important;
    }
    
    .modal-overlay.active {
        display: flex !important;
    }
    
    .modal-overlay {
        display: none;
    }
    
    .rating-btn.active svg {
        color: #f97316 !important;
    }
`;
document.head.appendChild(dynamicStyles);
</script>
</body>
</html>