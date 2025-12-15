<%@page import="DAO.AsignacionDAO"%>
<%@page import="DAO.TesisDAO"%>
<%@page import="DAO.MensajeDAO"%>
<%@page import="DAO.UsuarioDAO"%>
<%@page import="Modelos.Usuario"%>
<%@page import="java.text.SimpleDateFormat"%>
<%@page import="Modelos.Asignacion"%>
<%@page import="Modelos.Tesis"%>
<%@page import="Modelos.Mensaje"%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page import="java.util.*" %>
<%
    // 1. VERIFICAR SESIÓN
    HttpSession userSession = request.getSession(false);
    if (userSession == null || userSession.getAttribute("usuario_id") == null) {
        response.sendRedirect("index.jsp");
        return;
    }

    Integer usuarioId = (Integer) userSession.getAttribute("usuario_id");
    String usuarioTipo = (String) userSession.getAttribute("usuario_tipo");

    // Verificar que sea estudiante
    if (!"ESTUDIANTE".equals(usuarioTipo)) {
        response.sendRedirect("index.jsp");
        return;
    }

    // 2. INICIALIZAR DAOs
    UsuarioDAO usuarioDAO = new UsuarioDAO();
    TesisDAO tesisDAO = new TesisDAO();
    AsignacionDAO asignacionDAO = new AsignacionDAO();
    MensajeDAO mensajeDAO = new MensajeDAO();

    // 3. OBTENER DATOS DEL ESTUDIANTE
    Usuario estudiante = null;

    try {
        estudiante = usuarioDAO.obtenerUsuarioPorId(usuarioId);
    } catch (Exception e) {
        // Error silencioso - se maneja abajo
    }

    if (estudiante == null) {
        // Crear un usuario temporal para continuar
        estudiante = new Usuario();
        estudiante.setId(usuarioId);
        estudiante.setNombre("Estudiante Temporal");
        estudiante.setApellido("");
        estudiante.setEmail("estudiante" + usuarioId + "@universidad.edu");
    }

    // Manejar nulls en nombre y apellido
    String nombreEstudiante = "";
    if (estudiante.getNombre() != null) {
        nombreEstudiante += estudiante.getNombre();
    }
    if (estudiante.getApellido() != null) {
        nombreEstudiante += " " + estudiante.getApellido();
    }
    nombreEstudiante = nombreEstudiante.trim();
    if (nombreEstudiante.isEmpty()) {
        nombreEstudiante = "Estudiante";
    }

    String emailEstudiante = estudiante.getEmail() != null ? estudiante.getEmail() : "";
    String fotoPerfil = "https://img.rocket.new/generatedImages/rocket_gen_img_1037a390f-1762273998500.png";
    // 4. OBTENER TESIS DEL ESTUDIANTE
    Tesis tesis = null;
    List<Tesis> listaTesis = tesisDAO.obtenerTesisPorEstudiante(estudiante.getId());
    if (listaTesis != null && !listaTesis.isEmpty()) {
        tesis = listaTesis.get(0);
    }

    // 5. OBTENER ASIGNACIONES Y DOCENTE ASIGNADO
    List<Asignacion> asignaciones = new ArrayList<>();
    Usuario docenteAsignado = null;
    int idAsignacion = 0;

    if (tesis != null) {
        asignaciones = asignacionDAO.obtenerAsignacionesPorTesis(tesis.getId());

        // Buscar docente asignado (asesor)
        for (Asignacion asignacion : asignaciones) {
            if (asignacion.getIdDocente() > 0 && "ASESOR".equals(asignacion.getRol())) {
                docenteAsignado = usuarioDAO.obtenerDocentePorId(asignacion.getIdDocente());
                idAsignacion = asignacion.getId();
                break;
            }
        }
    }

    // 6. OBTENER MENSAJES
    List<Mensaje> mensajes = mensajeDAO.obtenerMensajesPorEstudiante(estudiante.getId());
    if (mensajes == null) {
        mensajes = new ArrayList<>();
    }

    // 7. CALCULAR ESTADÍSTICAS
    int totalMensajes = mensajes.size();
    int mensajesNoLeidos = 0;
    int progreso = 0;
    int diasRestantes = 90;

    SimpleDateFormat sdf = new SimpleDateFormat("dd/MM/yyyy");

    if (tesis != null) {
        // Calcular progreso según estado de tesis
        String estadoTesis = tesis.getEstado();
        if (estadoTesis != null) {
            switch (estadoTesis.toUpperCase()) {
                case "BORRADOR":
                    progreso = 20;
                    break;
                case "EN_REVISION":
                case "EN REVISION":
                    progreso = 50;
                    break;
                case "REVISION_COMPLETA":
                    progreso = 75;
                    break;
                case "APROBADA":
                    progreso = 100;
                    break;
                case "RECHAZADA":
                    progreso = 30;
                    break;
                default:
                    progreso = 10;
            }
        }

        // Calcular días restantes
        if (tesis.getFechaEntrega() != null) {
            try {
                Date hoy = new Date();
                long diff = tesis.getFechaEntrega().getTime() - hoy.getTime();
                diasRestantes = (int) Math.max(0, diff / (1000 * 60 * 60 * 24));
            } catch (Exception e) {
                diasRestantes = 90;
            }
        }
    }

    // Contar mensajes no leídos
    for (Mensaje mensaje : mensajes) {
        if (mensaje.getIdEstudiante() == estudiante.getId()
                && "no_leido".equalsIgnoreCase(mensaje.getEstado())) {
            mensajesNoLeidos++;
        }
    }

    // 8. FORMATEADORES
    SimpleDateFormat msgSdf = new SimpleDateFormat("dd/MM/yyyy HH:mm");
%>
<!DOCTYPE html>
<html lang="es">
    <head>
        <meta charset="UTF-8">
        <meta name="viewport" content="width=device-width, initial-scale=1.0">
        <title>Panel Estudiante - ThesisReview Portal</title>
        <meta name="description" content="Panel de control para estudiantes de posgrado. Gestiona tu proceso de tesis desde la submisión hasta la aprobación final.">
        <link rel="preconnect" href="https://fonts.googleapis.com">
        <link rel="preconnect" href="https://fonts.gstatic.com" crossorigin>
        <style>
            /* Estilos CSS integrados */
            @import url('https://fonts.googleapis.com/css2?family=Inter:wght@400;500;600;700&display=swap');
            @import url('https://fonts.googleapis.com/css2?family=Crimson+Text:wght@400;600&display=swap');

            *, ::before, ::after{
                --tw-border-spacing-x: 0;
                --tw-border-spacing-y: 0;
                --tw-translate-x: 0;
                --tw-translate-y: 0;
                --tw-rotate: 0;
                --tw-skew-x: 0;
                --tw-skew-y: 0;
                --tw-scale-x: 1;
                --tw-scale-y: 1;
                --tw-pan-x:  ;
                --tw-pan-y:  ;
                --tw-pinch-zoom:  ;
                --tw-scroll-snap-strictness: proximity;
                --tw-gradient-from-position:  ;
                --tw-gradient-via-position:  ;
                --tw-gradient-to-position:  ;
                --tw-ordinal:  ;
                --tw-slashed-zero:  ;
                --tw-numeric-figure:  ;
                --tw-numeric-spacing:  ;
                --tw-numeric-fraction:  ;
                --tw-ring-inset:  ;
                --tw-ring-offset-width: 0px;
                --tw-ring-offset-color: #fff;
                --tw-ring-color: rgb(59 130 246 / 0.5);
                --tw-ring-offset-shadow: 0 0 #0000;
                --tw-ring-shadow: 0 0 #0000;
                --tw-shadow: 0 0 #0000;
                --tw-shadow-colored: 0 0 #0000;
                --tw-blur:  ;
                --tw-brightness:  ;
                --tw-contrast:  ;
                --tw-grayscale:  ;
                --tw-hue-rotate:  ;
                --tw-invert:  ;
                --tw-saturate:  ;
                --tw-sepia:  ;
                --tw-drop-shadow:  ;
                --tw-backdrop-blur:  ;
                --tw-backdrop-brightness:  ;
                --tw-backdrop-contrast:  ;
                --tw-backdrop-grayscale:  ;
                --tw-backdrop-hue-rotate:  ;
                --tw-backdrop-invert:  ;
                --tw-backdrop-opacity:  ;
                --tw-backdrop-saturate:  ;
                --tw-backdrop-sepia:  ;
                --tw-contain-size:  ;
                --tw-contain-layout:  ;
                --tw-contain-paint:  ;
                --tw-contain-style:  ;
            }

            ::backdrop{
                --tw-border-spacing-x: 0;
                --tw-border-spacing-y: 0;
                --tw-translate-x: 0;
                --tw-translate-y: 0;
                --tw-rotate: 0;
                --tw-skew-x: 0;
                --tw-skew-y: 0;
                --tw-scale-x: 1;
                --tw-scale-y: 1;
                --tw-pan-x:  ;
                --tw-pan-y:  ;
                --tw-pinch-zoom:  ;
                --tw-scroll-snap-strictness: proximity;
                --tw-gradient-from-position:  ;
                --tw-gradient-via-position:  ;
                --tw-gradient-to-position:  ;
                --tw-ordinal:  ;
                --tw-slashed-zero:  ;
                --tw-numeric-figure:  ;
                --tw-numeric-spacing:  ;
                --tw-numeric-fraction:  ;
                --tw-ring-inset:  ;
                --tw-ring-offset-width: 0px;
                --tw-ring-offset-color: #fff;
                --tw-ring-color: rgb(59 130 246 / 0.5);
                --tw-ring-offset-shadow: 0 0 #0000;
                --tw-ring-shadow: 0 0 #0000;
                --tw-shadow: 0 0 #0000;
                --tw-shadow-colored: 0 0 #0000;
                --tw-blur:  ;
                --tw-brightness:  ;
                --tw-contrast:  ;
                --tw-grayscale:  ;
                --tw-hue-rotate:  ;
                --tw-invert:  ;
                --tw-saturate:  ;
                --tw-sepia:  ;
                --tw-drop-shadow:  ;
                --tw-backdrop-blur:  ;
                --tw-backdrop-brightness:  ;
                --tw-backdrop-contrast:  ;
                --tw-backdrop-grayscale:  ;
                --tw-backdrop-hue-rotate:  ;
                --tw-backdrop-invert:  ;
                --tw-backdrop-opacity:  ;
                --tw-backdrop-saturate:  ;
                --tw-backdrop-sepia:  ;
                --tw-contain-size:  ;
                --tw-contain-layout:  ;
                --tw-contain-paint:  ;
                --tw-contain-style:  ;
            }

            /*
            ! tailwindcss v3.4.17 | MIT License | https://tailwindcss.com
            */

            /*
            1. Prevent padding and border from affecting element width. (https://github.com/mozdevs/cssremedy/issues/4)
            2. Allow adding a border to an element by just adding a border-width. (https://github.com/tailwindcss/tailwindcss/pull/116)
            */

            *,
            ::before,
            ::after {
                box-sizing: border-box;
                /* 1 */
                border-width: 0;
                /* 2 */
                border-style: solid;
                /* 2 */
                border-color: #e5e7eb;
                /* 2 */
            }

            ::before,
            ::after {
                --tw-content: '';
            }

            /*
            1. Use a consistent sensible line-height in all browsers.
            2. Prevent adjustments of font size after orientation changes in iOS.
            3. Use a more readable tab size.
            4. Use the user's configured `sans` font-family by default.
            5. Use the user's configured `sans` font-feature-settings by default.
            6. Use the user's configured `sans` font-variation-settings by default.
            7. Disable tap highlights on iOS
            */

            html,
            :host {
                line-height: 1.5;
                /* 1 */
                -webkit-text-size-adjust: 100%;
                /* 2 */
                -moz-tab-size: 4;
                /* 3 */
                -o-tab-size: 4;
                tab-size: 4;
                /* 3 */
                font-family: Inter, sans-serif;
                /* 4 */
                font-feature-settings: normal;
                /* 5 */
                font-variation-settings: normal;
                /* 6 */
                -webkit-tap-highlight-color: transparent;
                /* 7 */
            }

            /*
            1. Remove the margin in all browsers.
            2. Inherit line-height from `html` so users can set them as a class directly on the `html` element.
            */

            body {
                margin: 0;
                /* 1 */
                line-height: inherit;
                /* 2 */
            }

            /*
            1. Add the correct height in Firefox.
            2. Correct the inheritance of border color in Firefox. (https://bugzilla.mozilla.org/show_bug.cgi?id=190655)
            3. Ensure horizontal rules are visible by default.
            */

            hr {
                height: 0;
                /* 1 */
                color: inherit;
                /* 2 */
                border-top-width: 1px;
                /* 3 */
            }

            /*
            Add the correct text decoration in Chrome, Edge, and Safari.
            */

            abbr:where([title]) {
                -webkit-text-decoration: underline dotted;
                text-decoration: underline dotted;
            }

            /*
            Remove the default font size and weight for headings.
            */

            h1,
            h2,
            h3,
            h4,
            h5,
            h6 {
                font-size: inherit;
                font-weight: inherit;
            }

            /*
            Reset links to optimize for opt-in styling instead of opt-out.
            */

            a {
                color: inherit;
                text-decoration: inherit;
            }

            /*
            Add the correct font weight in Edge and Safari.
            */

            b,
            strong {
                font-weight: bolder;
            }

            /*
            1. Use the user's configured `mono` font-family by default.
            2. Use the user's configured `mono` font-feature-settings by default.
            3. Use the user's configured `mono` font-variation-settings by default.
            4. Correct the odd `em` font sizing in all browsers.
            */

            code,
            kbd,
            samp,
            pre {
                font-family: ui-monospace, SFMono-Regular, Menlo, Monaco, Consolas, "Liberation Mono", "Courier New", monospace;
                /* 1 */
                font-feature-settings: normal;
                /* 2 */
                font-variation-settings: normal;
                /* 3 */
                font-size: 1em;
                /* 4 */
            }

            /*
            Add the correct font size in all browsers.
            */

            small {
                font-size: 80%;
            }

            /*
            Prevent `sub` and `sup` elements from affecting the line height in all browsers.
            */

            sub,
            sup {
                font-size: 75%;
                line-height: 0;
                position: relative;
                vertical-align: baseline;
            }

            sub {
                bottom: -0.25em;
            }

            sup {
                top: -0.5em;
            }

            /*
            1. Remove text indentation from table contents in Chrome and Safari. (https://bugs.chromium.org/p/chromium/issues/detail?id=999088, https://bugs.webkit.org/show_bug.cgi?id=201297)
            2. Correct table border color inheritance in all Chrome and Safari. (https://bugs.chromium.org/p/chromium/issues/detail?id=935729, https://bugs.webkit.org/show_bug.cgi?id=195016)
            3. Remove gaps between table borders by default.
            */

            table {
                text-indent: 0;
                /* 1 */
                border-color: inherit;
                /* 2 */
                border-collapse: collapse;
                /* 3 */
            }

            /*
            1. Change the font styles in all browsers.
            2. Remove the margin in Firefox and Safari.
            3. Remove default padding in all browsers.
            */

            button,
            input,
            optgroup,
            select,
            textarea {
                font-family: inherit;
                /* 1 */
                font-feature-settings: inherit;
                /* 1 */
                font-variation-settings: inherit;
                /* 1 */
                font-size: 100%;
                /* 1 */
                font-weight: inherit;
                /* 1 */
                line-height: inherit;
                /* 1 */
                letter-spacing: inherit;
                /* 1 */
                color: inherit;
                /* 1 */
                margin: 0;
                /* 2 */
                padding: 0;
                /* 3 */
            }

            /*
            Remove the inheritance of text transform in Edge and Firefox.
            */

            button,
            select {
                text-transform: none;
            }

            /*
            1. Correct the inability to style clickable types in iOS and Safari.
            2. Remove default button styles.
            */

            button,
            input:where([type='button']),
            input:where([type='reset']),
            input:where([type='submit']) {
                -webkit-appearance: button;
                /* 1 */
                background-color: transparent;
                /* 2 */
                background-image: none;
                /* 2 */
            }

            /*
            Use the modern Firefox focus style for all focusable elements.
            */

            :-moz-focusring {
                outline: auto;
            }

            /*
            Remove the additional `:invalid` styles in Firefox. (https://github.com/mozilla/gecko-dev/blob/2f9eacd9d3d995c937b4251a5557d95d494c9be1/layout/style/res/forms.css#L728-L737)
            */

            :-moz-ui-invalid {
                box-shadow: none;
            }

            /*
            Add the correct vertical alignment in Chrome and Firefox.
            */

            progress {
                vertical-align: baseline;
            }

            /*
            Correct the cursor style of increment and decrement buttons in Safari.
            */

            ::-webkit-inner-spin-button,
            ::-webkit-outer-spin-button {
                height: auto;
            }

            /*
            1. Correct the odd appearance in Chrome and Safari.
            2. Correct the outline style in Safari.
            */

            [type='search'] {
                -webkit-appearance: textfield;
                /* 1 */
                outline-offset: -2px;
                /* 2 */
            }

            /*
            Remove the inner padding in Chrome and Safari on macOS.
            */

            ::-webkit-search-decoration {
                -webkit-appearance: none;
            }

            /*
            1. Correct the inability to style clickable types in iOS and Safari.
            2. Change font properties to `inherit` in Safari.
            */

            ::-webkit-file-upload-button {
                -webkit-appearance: button;
                /* 1 */
                font: inherit;
                /* 2 */
            }

            /*
            Add the correct display in Chrome and Safari.
            */

            summary {
                display: list-item;
            }

            /*
            Removes the default spacing and border for appropriate elements.
            */

            blockquote,
            dl,
            dd,
            h1,
            h2,
            h3,
            h4,
            h5,
            h6,
            hr,
            figure,
            p,
            pre {
                margin: 0;
            }

            fieldset {
                margin: 0;
                padding: 0;
            }

            legend {
                padding: 0;
            }

            ol,
            ul,
            menu {
                list-style: none;
                margin: 0;
                padding: 0;
            }

            /*
            Reset default styling for dialogs.
            */

            dialog {
                padding: 0;
            }

            /*
            Prevent resizing textareas horizontally by default.
            */

            textarea {
                resize: vertical;
            }

            /*
            1. Reset the default placeholder opacity in Firefox. (https://github.com/tailwindcss/tailwindcss/issues/3300)
            2. Set the default placeholder color to the user's configured gray 400 color.
            */

            input::-moz-placeholder, textarea::-moz-placeholder {
                opacity: 1;
                /* 1 */
                color: #9ca3af;
                /* 2 */
            }

            input::placeholder,
            textarea::placeholder {
                opacity: 1;
                /* 1 */
                color: #9ca3af;
                /* 2 */
            }

            /*
            Set the default cursor for buttons.
            */

            button,
            [role="button"] {
                cursor: pointer;
            }

            /*
            Make sure disabled buttons don't get the pointer cursor.
            */

            :disabled {
                cursor: default;
            }

            /*
            1. Make replaced elements `display: block` by default. (https://github.com/mozdevs/cssremedy/issues/14)
            2. Add `vertical-align: middle` to align replaced elements more sensibly by default. (https://github.com/jensimmons/cssremedy/issues/14#issuecomment-634934210)
               This can trigger a poorly considered lint error in some tools but is included by design.
            */

            img,
            svg,
            video,
            canvas,
            audio,
            iframe,
            embed,
            object {
                display: block;
                /* 1 */
                vertical-align: middle;
                /* 2 */
            }

            /*
            Constrain images and videos to the parent width and preserve their intrinsic aspect ratio. (https://github.com/mozdevs/cssremedy/issues/14)
            */

            img,
            video {
                max-width: 100%;
                height: auto;
            }

            /* Make elements with the HTML hidden attribute stay hidden by default */

            [hidden]:where(:not([hidden="until-found"])) {
                display: none;
            }

            /* Estilos personalizados para el nuevo fondo y logo */
            body {
                background: linear-gradient(135deg, #e3f2fd 0%, #f8fbff 50%, #e3f2fd 100%);
                min-height: 100vh;
            }

            .logo-img {
                width: 40px;
                height: 40px;
                border-radius: 50%;
                object-fit: cover;
                box-shadow: 0 0 10px rgba(59, 130, 246, 0.3);
            }

            .btn-primary{
                border-radius: 0.5rem;
                --tw-bg-opacity: 1;
                background-color: rgb(30 64 175 / var(--tw-bg-opacity, 1));
                padding-left: 1.5rem;
                padding-right: 1.5rem;
                padding-top: 0.75rem;
                padding-bottom: 0.75rem;
                font-weight: 600;
                --tw-text-opacity: 1;
                color: rgb(255 255 255 / var(--tw-text-opacity, 1));
                transition-property: all;
                transition-duration: 250ms;
                transition-timing-function: cubic-bezier(0.4, 0, 0.2, 1);
            }

            .btn-primary:hover{
                --tw-bg-opacity: 1;
                background-color: rgb(29 78 216 / var(--tw-bg-opacity, 1));
            }

            .btn-primary:focus{
                outline: 2px solid transparent;
                outline-offset: 2px;
                --tw-ring-offset-shadow: var(--tw-ring-inset) 0 0 0 var(--tw-ring-offset-width) var(--tw-ring-offset-color);
                --tw-ring-shadow: var(--tw-ring-inset) 0 0 0 calc(2px + var(--tw-ring-offset-width)) var(--tw-ring-color);
                box-shadow: var(--tw-ring-offset-shadow), var(--tw-ring-shadow), var(--tw-shadow, 0 0 #0000);
                --tw-ring-opacity: 1;
                --tw-ring-color: rgb(59 130 246 / var(--tw-ring-opacity, 1));
                --tw-ring-offset-width: 2px;
            }

            .btn-primary {
                box-shadow: 0 4px 6px -1px rgba(0, 0, 0, 0.1);
            }

            .btn-secondary{
                border-radius: 0.5rem;
                --tw-bg-opacity: 1;
                background-color: rgb(59 130 246 / var(--tw-bg-opacity, 1));
                padding-left: 1.5rem;
                padding-right: 1.5rem;
                padding-top: 0.75rem;
                padding-bottom: 0.75rem;
                font-weight: 600;
                --tw-text-opacity: 1;
                color: rgb(255 255 255 / var(--tw-text-opacity, 1));
                transition-property: all;
                transition-duration: 250ms;
                transition-timing-function: cubic-bezier(0.4, 0, 0.2, 1);
            }

            .btn-secondary:hover{
                --tw-bg-opacity: 1;
                background-color: rgb(29 78 216 / var(--tw-bg-opacity, 1));
            }

            .btn-secondary:focus{
                outline: 2px solid transparent;
                outline-offset: 2px;
                --tw-ring-offset-shadow: var(--tw-ring-inset) 0 0 0 var(--tw-ring-offset-width) var(--tw-ring-offset-color);
                --tw-ring-shadow: var(--tw-ring-inset) 0 0 0 calc(2px + var(--tw-ring-offset-width)) var(--tw-ring-color);
                box-shadow: var(--tw-ring-offset-shadow), var(--tw-ring-shadow), var(--tw-shadow, 0 0 #0000);
                --tw-ring-opacity: 1;
                --tw-ring-color: rgb(59 130 246 / var(--tw-ring-opacity, 1));
                --tw-ring-offset-width: 2px;
            }

            .btn-secondary {
                box-shadow: 0 4px 6px -1px rgba(0, 0, 0, 0.1);
            }

            .btn-accent{
                border-radius: 0.5rem;
                --tw-bg-opacity: 1;
                background-color: rgb(249 115 22 / var(--tw-bg-opacity, 1));
                padding-left: 1.5rem;
                padding-right: 1.5rem;
                padding-top: 0.75rem;
                padding-bottom: 0.75rem;
                font-weight: 600;
                --tw-text-opacity: 1;
                color: rgb(255 255 255 / var(--tw-text-opacity, 1));
                transition-property: all;
                transition-duration: 250ms;
                transition-timing-function: cubic-bezier(0.4, 0, 0.2, 1);
            }

            .btn-accent:hover{
                --tw-bg-opacity: 1;
                background-color: rgb(234 88 12 / var(--tw-bg-opacity, 1));
            }

            .btn-accent:focus{
                outline: 2px solid transparent;
                outline-offset: 2px;
                --tw-ring-offset-shadow: var(--tw-ring-inset) 0 0 0 var(--tw-ring-offset-width) var(--tw-ring-offset-color);
                --tw-ring-shadow: var(--tw-ring-inset) 0 0 0 calc(2px + var(--tw-ring-offset-width)) var(--tw-ring-color);
                box-shadow: var(--tw-ring-offset-shadow), var(--tw-ring-shadow), var(--tw-shadow, 0 0 #0000);
                --tw-ring-opacity: 1;
                --tw-ring-color: rgb(249 115 22 / var(--tw-ring-opacity, 1));
                --tw-ring-offset-width: 2px;
            }

            .btn-accent {
                box-shadow: 0 4px 6px -1px rgba(0, 0, 0, 0.1);
            }

            .card{
                border-radius: 0.5rem;
                border-width: 1px;
                --tw-border-opacity: 1;
                border-color: rgb(229 231 235 / var(--tw-border-opacity, 1));
                --tw-bg-opacity: 1;
                background-color: rgb(255 255 255 / var(--tw-bg-opacity, 1));
                padding: 1.5rem;
                box-shadow: 0 4px 6px -1px rgba(0, 0, 0, 0.1);
            }

            .form-input{
                width: 100%;
                border-radius: 0.375rem;
                border-width: 1px;
                --tw-border-opacity: 1;
                border-color: rgb(229 231 235 / var(--tw-border-opacity, 1));
                padding-left: 0.75rem;
                padding-right: 0.75rem;
                padding-top: 0.5rem;
                padding-bottom: 0.5rem;
                transition-property: all;
                transition-duration: 250ms;
                transition-timing-function: cubic-bezier(0.4, 0, 0.2, 1);
            }

            .form-input:focus{
                border-color: transparent;
                outline: 2px solid transparent;
                outline-offset: 2px;
                --tw-ring-offset-shadow: var(--tw-ring-inset) 0 0 0 var(--tw-ring-offset-width) var(--tw-ring-offset-color);
                --tw-ring-shadow: var(--tw-ring-inset) 0 0 0 calc(2px + var(--tw-ring-offset-width)) var(--tw-ring-color);
                box-shadow: var(--tw-ring-offset-shadow), var(--tw-ring-shadow), var(--tw-shadow, 0 0 #0000);
                --tw-ring-opacity: 1;
                --tw-ring-color: rgb(59 130 246 / var(--tw-ring-opacity, 1));
            }

            .testimonial-card{
                border-radius: 0.5rem;
                border-width: 1px;
                --tw-border-opacity: 1;
                border-color: rgb(229 231 235 / var(--tw-border-opacity, 1));
                --tw-bg-opacity: 1;
                background-color: rgb(255 255 255 / var(--tw-bg-opacity, 1));
                padding: 1.5rem;
                font-family: Crimson Text, serif;
                box-shadow: 0 4px 6px -1px rgba(0, 0, 0, 0.1);
            }

            .static{
                position: static;
            }

            .fixed{
                position: fixed;
            }

            .absolute{
                position: absolute;
            }

            .relative{
                position: relative;
            }

            .sticky{
                position: sticky;
            }

            .inset-0{
                inset: 0px;
            }

            .-right-1{
                right: -0.25rem;
            }

            .-top-1{
                top: -0.25rem;
            }

            .-top-3{
                top: -0.75rem;
            }

            .left-1\/2{
                left: 50%;
            }

            .right-4{
                right: 1rem;
            }

            .top-0{
                top: 0px;
            }

            .top-4{
                top: 1rem;
            }

            .z-50{
                z-index: 50;
            }

            .mx-auto{
                margin-left: auto;
                margin-right: auto;
            }

            .-mb-px{
                margin-bottom: -1px;
            }

            .mb-1{
                margin-bottom: 0.25rem;
            }

            .mb-12{
                margin-bottom: 3rem;
            }

            .mb-16{
                margin-bottom: 4rem;
            }

            .mb-2{
                margin-bottom: 0.5rem;
            }

            .mb-3{
                margin-bottom: 0.75rem;
            }

            .mb-4{
                margin-bottom: 1rem;
            }

            .mb-6{
                margin-bottom: 1.5rem;
            }

            .mb-8{
                margin-bottom: 2rem;
            }

            .ml-2{
                margin-left: 0.5rem;
            }

            .ml-3{
                margin-left: 0.75rem;
            }

            .ml-4{
                margin-left: 1rem;
            }

            .mr-1{
                margin-right: 0.25rem;
            }

            .mr-2{
                margin-right: 0.5rem;
            }

            .mr-3{
                margin-right: 0.75rem;
            }

            .mr-4{
                margin-right: 1rem;
            }

            .mt-1{
                margin-top: 0.25rem;
            }

            .mt-12{
                margin-top: 3rem;
            }

            .mt-2{
                margin-top: 0.5rem;
            }

            .mt-3{
                margin-top: 0.75rem;
            }

            .mt-4{
                margin-top: 1rem;
            }

            .mt-6{
                margin-top: 1.5rem;
            }

            .line-clamp-2{
                overflow: hidden;
                display: -webkit-box;
                -webkit-box-orient: vertical;
                -webkit-line-clamp: 2;
            }

            .block{
                display: block;
            }

            .inline{
                display: inline;
            }

            .flex{
                display: flex;
            }

            .inline-flex{
                display: inline-flex;
            }

            .table{
                display: table;
            }

            .grid{
                display: grid;
            }

            .hidden{
                display: none;
            }

            .h-10{
                height: 2.5rem;
            }

            .h-12{
                height: 3rem;
            }

            .h-14{
                height: 3.5rem;
            }

            .h-16{
                height: 4rem;
            }

            .h-2{
                height: 0.5rem;
            }

            .h-3{
                height: 0.75rem;
            }

            .h-4{
                height: 1rem;
            }

            .h-5{
                height: 1.25rem;
            }

            .h-6{
                height: 1.5rem;
            }

            .h-8{
                height: 2rem;
            }

            .min-h-screen{
                min-height: 100vh;
            }

            .w-10{
                width: 2.5rem;
            }

            .w-12{
                width: 3rem;
            }

            .w-16{
                width: 4rem;
            }

            .w-2{
                width: 0.5rem;
            }

            .w-20{
                width: 5rem;
            }

            .w-3{
                width: 0.75rem;
            }

            .w-4{
                width: 1rem;
            }

            .w-5{
                width: 1.25rem;
            }

            .w-6{
                width: 1.5rem;
            }

            .w-8{
                width: 2rem;
            }

            .w-full{
                width: 100%;
            }

            .min-w-full{
                min-width: 100%;
            }

            .max-w-3xl{
                max-width: 48rem;
            }

            .max-w-4xl{
                max-width: 56rem;
            }

            .max-w-7xl{
                max-width: 80rem;
            }

            .max-w-md{
                max-width: 28rem;
            }

            .max-w-sm{
                max-width: 24rem;
            }

            .max-w-xs{
                max-width: 20rem;
            }

            .flex-1{
                flex: 1 1 0%;
            }

            .flex-shrink-0{
                flex-shrink: 0;
            }

            .-translate-x-1\/2{
                --tw-translate-x: -50%;
                transform: translate(var(--tw-translate-x), var(--tw-translate-y)) rotate(var(--tw-rotate)) skewX(var(--tw-skew-x)) skewY(var(--tw-skew-y)) scaleX(var(--tw-scale-x)) scaleY(var(--tw-scale-y));
            }

            .translate-x-full{
                --tw-translate-x: 100%;
                transform: translate(var(--tw-translate-x), var(--tw-translate-y)) rotate(var(--tw-rotate)) skewX(var(--tw-skew-x)) skewY(var(--tw-skew-y)) scaleX(var(--tw-scale-x)) scaleY(var(--tw-scale-y));
            }

            .transform{
                transform: translate(var(--tw-translate-x), var(--tw-translate-y)) rotate(var(--tw-rotate)) skewX(var(--tw-skew-x)) skewY(var(--tw-skew-y)) scaleX(var(--tw-scale-x)) scaleY(var(--tw-scale-y));
            }

            @keyframes pulse{
                50%{
                    opacity: .5;
                }
            }

            .animate-pulse{
                animation: pulse 2s cubic-bezier(0.4, 0, 0.6, 1) infinite;
            }

            .cursor-pointer{
                cursor: pointer;
            }

            .grid-cols-1{
                grid-template-columns: repeat(1, minmax(0, 1fr));
            }

            .grid-cols-2{
                grid-template-columns: repeat(2, minmax(0, 1fr));
            }

            .grid-cols-3{
                grid-template-columns: repeat(3, minmax(0, 1fr));
            }

            .flex-col{
                flex-direction: column;
            }

            .items-start{
                align-items: flex-start;
            }

            .items-end{
                align-items: flex-end;
            }

            .items-center{
                align-items: center;
            }

            .justify-end{
                justify-content: flex-end;
            }

            .justify-center{
                justify-content: center;
            }

            .justify-between{
                justify-content: space-between;
            }

            .gap-12{
                gap: 3rem;
            }

            .gap-2{
                gap: 0.5rem;
            }

            .gap-3{
                gap: 0.75rem;
            }

            .gap-4{
                gap: 1rem;
            }

            .gap-6{
                gap: 1.5rem;
            }

            .gap-8{
                gap: 2rem;
            }

            .space-x-1 > :not([hidden]) ~ :not([hidden]){
                --tw-space-x-reverse: 0;
                margin-right: calc(0.25rem * var(--tw-space-x-reverse));
                margin-left: calc(0.25rem * calc(1 - var(--tw-space-x-reverse)));
            }

            .space-x-2 > :not([hidden]) ~ :not([hidden]){
                --tw-space-x-reverse: 0;
                margin-right: calc(0.5rem * var(--tw-space-x-reverse));
                margin-left: calc(0.5rem * calc(1 - var(--tw-space-x-reverse)));
            }

            .space-x-3 > :not([hidden]) ~ :not([hidden]){
                --tw-space-x-reverse: 0;
                margin-right: calc(0.75rem * var(--tw-space-x-reverse));
                margin-left: calc(0.75rem * calc(1 - var(--tw-space-x-reverse)));
            }

            .space-x-4 > :not([hidden]) ~ :not([hidden]){
                --tw-space-x-reverse: 0;
                margin-right: calc(1rem * var(--tw-space-x-reverse));
                margin-left: calc(1rem * calc(1 - var(--tw-space-x-reverse)));
            }

            .space-x-6 > :not([hidden]) ~ :not([hidden]){
                --tw-space-x-reverse: 0;
                margin-right: calc(1.5rem * var(--tw-space-x-reverse));
                margin-left: calc(1.5rem * calc(1 - var(--tw-space-x-reverse)));
            }

            .space-x-8 > :not([hidden]) ~ :not([hidden]){
                --tw-space-x-reverse: 0;
                margin-right: calc(2rem * var(--tw-space-x-reverse));
                margin-left: calc(2rem * calc(1 - var(--tw-space-x-reverse)));
            }

            .space-y-2 > :not([hidden]) ~ :not([hidden]){
                --tw-space-y-reverse: 0;
                margin-top: calc(0.5rem * calc(1 - var(--tw-space-y-reverse)));
                margin-bottom: calc(0.5rem * var(--tw-space-y-reverse));
            }

            .space-y-3 > :not([hidden]) ~ :not([hidden]){
                --tw-space-y-reverse: 0;
                margin-top: calc(0.75rem * calc(1 - var(--tw-space-y-reverse)));
                margin-bottom: calc(0.75rem * var(--tw-space-y-reverse));
            }

            .space-y-4 > :not([hidden]) ~ :not([hidden]){
                --tw-space-y-reverse: 0;
                margin-top: calc(1rem * calc(1 - var(--tw-space-y-reverse)));
                margin-bottom: calc(1rem * var(--tw-space-y-reverse));
            }

            .space-y-6 > :not([hidden]) ~ :not([hidden]){
                --tw-space-y-reverse: 0;
                margin-top: calc(1.5rem * calc(1 - var(--tw-space-y-reverse)));
                margin-bottom: calc(1.5rem * var(--tw-space-y-reverse));
            }

            .space-y-8 > :not([hidden]) ~ :not([hidden]){
                --tw-space-y-reverse: 0;
                margin-top: calc(2rem * calc(1 - var(--tw-space-y-reverse)));
                margin-bottom: calc(2rem * var(--tw-space-y-reverse));
            }

            .divide-y > :not([hidden]) ~ :not([hidden]){
                --tw-divide-y-reverse: 0;
                border-top-width: calc(1px * calc(1 - var(--tw-divide-y-reverse)));
                border-bottom-width: calc(1px * var(--tw-divide-y-reverse));
            }

            .divide-gray-200 > :not([hidden]) ~ :not([hidden]){
                --tw-divide-opacity: 1;
                border-color: rgb(229 231 235 / var(--tw-divide-opacity, 1));
            }

            .overflow-hidden{
                overflow: hidden;
            }

            .overflow-x-auto{
                overflow-x: auto;
            }

            .truncate{
                overflow: hidden;
                text-overflow: ellipsis;
                white-space: nowrap;
            }

            .whitespace-nowrap{
                white-space: nowrap;
            }

            .rounded{
                border-radius: 0.25rem;
            }

            .rounded-2xl{
                border-radius: 1rem;
            }

            .rounded-full{
                border-radius: 9999px;
            }

            .rounded-lg{
                border-radius: 0.5rem;
            }

            .rounded-md{
                border-radius: 0.375rem;
            }

            .rounded-sm{
                border-radius: 0.125rem;
            }

            .rounded-xl{
                border-radius: 0.75rem;
            }

            .rounded-r-lg{
                border-top-right-radius: 0.5rem;
                border-bottom-right-radius: 0.5rem;
            }

            .border{
                border-width: 1px;
            }

            .border-2{
                border-width: 2px;
            }

            .border-b{
                border-bottom-width: 1px;
            }

            .border-b-2{
                border-bottom-width: 2px;
            }

            .border-l-4{
                border-left-width: 4px;
            }

            .border-r{
                border-right-width: 1px;
            }

            .border-t{
                border-top-width: 1px;
            }

            .border-dashed{
                border-style: dashed;
            }

            .border-accent{
                --tw-border-opacity: 1;
                border-color: rgb(249 115 22 / var(--tw-border-opacity, 1));
            }

            .border-accent-200{
                --tw-border-opacity: 1;
                border-color: rgb(254 215 170 / var(--tw-border-opacity, 1));
            }

            .border-error{
                --tw-border-opacity: 1;
                border-color: rgb(239 68 68 / var(--tw-border-opacity, 1));
            }

            .border-gray-200{
                --tw-border-opacity: 1;
                border-color: rgb(229 231 235 / var(--tw-border-opacity, 1));
            }

            .border-primary{
                --tw-border-opacity: 1;
                border-color: rgb(30 64 175 / var(--tw-border-opacity, 1));
            }

            .border-primary-200{
                --tw-border-opacity: 1;
                border-color: rgb(191 219 254 / var(--tw-border-opacity, 1));
            }

            .border-primary-300{
                --tw-border-opacity: 1;
                border-color: rgb(147 197 253 / var(--tw-border-opacity, 1));
            }

            .border-primary-400{
                --tw-border-opacity: 1;
                border-color: rgb(96 165 250 / var(--tw-border-opacity, 1));
            }

            .border-primary-700{
                --tw-border-opacity: 1;
                border-color: rgb(29 78 216 / var(--tw-border-opacity, 1));
            }

            .border-secondary-200{
                --tw-border-opacity: 1;
                border-color: rgb(191 219 254 / var(--tw-border-opacity, 1));
            }

            .border-success{
                --tw-border-opacity: 1;
                border-color: rgb(16 185 129 / var(--tw-border-opacity, 1));
            }

            .border-transparent{
                border-color: transparent;
            }

            .border-warning{
                --tw-border-opacity: 1;
                border-color: rgb(245 158 11 / var(--tw-border-opacity, 1));
            }

            .bg-accent{
                --tw-bg-opacity: 1;
                background-color: rgb(249 115 22 / var(--tw-bg-opacity, 1));
            }

            .bg-accent-100{
                --tw-bg-opacity: 1;
                background-color: rgb(255 237 213 / var(--tw-bg-opacity, 1));
            }

            .bg-accent-50{
                --tw-bg-opacity: 1;
                background-color: rgb(255 247 237 / var(--tw-bg-opacity, 1));
            }

            .bg-background{
                --tw-bg-opacity: 1;
                background-color: rgb(255 255 255 / var(--tw-bg-opacity, 1));
            }

            .bg-black{
                --tw-bg-opacity: 1;
                background-color: rgb(0 0 0 / var(--tw-bg-opacity, 1));
            }

            .bg-error{
                --tw-bg-opacity: 1;
                background-color: rgb(239 68 68 / var(--tw-bg-opacity, 1));
            }

            .bg-error-100{
                --tw-bg-opacity: 1;
                background-color: rgb(254 226 226 / var(--tw-bg-opacity, 1));
            }

            .bg-error-50{
                --tw-bg-opacity: 1;
                background-color: rgb(254 242 242 / var(--tw-bg-opacity, 1));
            }

            .bg-gray-200{
                --tw-bg-opacity: 1;
                background-color: rgb(229 231 235 / var(--tw-bg-opacity, 1));
            }

            .bg-gray-300{
                --tw-bg-opacity: 1;
                background-color: rgb(209 213 219 / var(--tw-bg-opacity, 1));
            }

            .bg-gray-400{
                --tw-bg-opacity: 1;
                background-color: rgb(156 163 175 / var(--tw-bg-opacity, 1));
            }

            .bg-gray-50{
                --tw-bg-opacity: 1;
                background-color: rgb(249 250 251 / var(--tw-bg-opacity, 1));
            }

            .bg-gray-600{
                --tw-bg-opacity: 1;
                background-color: rgb(75 85 99 / var(--tw-bg-opacity, 1));
            }

            .bg-primary{
                --tw-bg-opacity: 1;
                background-color: rgb(30 64 175 / var(--tw-bg-opacity, 1));
            }

            .bg-primary-100{
                --tw-bg-opacity: 1;
                background-color: rgb(219 234 254 / var(--tw-bg-opacity, 1));
            }

            .bg-primary-200{
                --tw-bg-opacity: 1;
                background-color: rgb(191 219 254 / var(--tw-bg-opacity, 1));
            }

            .bg-primary-300{
                --tw-bg-opacity: 1;
                background-color: rgb(147 197 253 / var(--tw-bg-opacity, 1));
            }

            .bg-primary-400{
                --tw-bg-opacity: 1;
                background-color: rgb(96 165 250 / var(--tw-bg-opacity, 1));
            }

            .bg-primary-50{
                --tw-bg-opacity: 1;
                background-color: rgb(239 246 255 / var(--tw-bg-opacity, 1));
            }

            .bg-primary-500{
                --tw-bg-opacity: 1;
                background-color: rgb(59 130 246 / var(--tw-bg-opacity, 1));
            }

            .bg-primary-600{
                --tw-bg-opacity: 1;
                background-color: rgb(37 99 235 / var(--tw-bg-opacity, 1));
            }

            .bg-secondary{
                --tw-bg-opacity: 1;
                background-color: rgb(59 130 246 / var(--tw-bg-opacity, 1));
            }

            .bg-secondary-100{
                --tw-bg-opacity: 1;
                background-color: rgb(219 234 254 / var(--tw-bg-opacity, 1));
            }

            .bg-secondary-50{
                --tw-bg-opacity: 1;
                background-color: rgb(239 246 255 / var(--tw-bg-opacity, 1));
            }

            .bg-success{
                --tw-bg-opacity: 1;
                background-color: rgb(16 185 129 / var(--tw-bg-opacity, 1));
            }

            .bg-success-100{
                --tw-bg-opacity: 1;
                background-color: rgb(209 250 229 / var(--tw-bg-opacity, 1));
            }

            .bg-success-50{
                --tw-bg-opacity: 1;
                background-color: rgb(236 253 245 / var(--tw-bg-opacity, 1));
            }

            .bg-surface{
                --tw-bg-opacity: 1;
                background-color: rgb(248 250 252 / var(--tw-bg-opacity, 1));
            }

            .bg-warning{
                --tw-bg-opacity: 1;
                background-color: rgb(245 158 11 / var(--tw-bg-opacity, 1));
            }

            .bg-warning-100{
                --tw-bg-opacity: 1;
                background-color: rgb(254 243 199 / var(--tw-bg-opacity, 1));
            }

            .bg-warning-50{
                --tw-bg-opacity: 1;
                background-color: rgb(255 251 235 / var(--tw-bg-opacity, 1));
            }

            .bg-white{
                --tw-bg-opacity: 1;
                background-color: rgb(255 255 255 / var(--tw-bg-opacity, 1));
            }

            .bg-opacity-20{
                --tw-bg-opacity: 0.2;
            }

            .bg-opacity-50{
                --tw-bg-opacity: 0.5;
            }

            .bg-gradient-to-br{
                background-image: linear-gradient(to bottom right, var(--tw-gradient-stops));
            }

            .bg-gradient-to-r{
                background-image: linear-gradient(to right, var(--tw-gradient-stops));
            }

            .from-primary{
                --tw-gradient-from: #1e40af var(--tw-gradient-from-position);
                --tw-gradient-to: rgb(30 64 175 / 0) var(--tw-gradient-to-position);
                --tw-gradient-stops: var(--tw-gradient-from), var(--tw-gradient-to);
            }

            .from-primary-50{
                --tw-gradient-from: #eff6ff var(--tw-gradient-from-position);
                --tw-gradient-to: rgb(239 246 255 / 0) var(--tw-gradient-to-position);
                --tw-gradient-stops: var(--tw-gradient-from), var(--tw-gradient-to);
            }

            .from-secondary{
                --tw-gradient-from: #3b82f6 var(--tw-gradient-from-position);
                --tw-gradient-to: rgb(59 130 246 / 0) var(--tw-gradient-to-position);
                --tw-gradient-stops: var(--tw-gradient-from), var(--tw-gradient-to);
            }

            .to-accent{
                --tw-gradient-to: #f97316 var(--tw-gradient-to-position);
            }

            .to-secondary{
                --tw-gradient-to: #3b82f6 var(--tw-gradient-to-position);
            }

            .to-secondary-100{
                --tw-gradient-to: #dbeafe var(--tw-gradient-to-position);
            }

            .object-cover{
                -o-object-fit: cover;
                object-fit: cover;
            }

            .p-1{
                padding: 0.25rem;
            }

            .p-2{
                padding: 0.5rem;
            }

            .p-3{
                padding: 0.75rem;
            }

            .p-4{
                padding: 1rem;
            }

            .p-6{
                padding: 1.5rem;
            }

            .p-8{
                padding: 2rem;
            }

            .px-1{
                padding-left: 0.25rem;
                padding-right: 0.25rem;
            }

            .px-2{
                padding-left: 0.5rem;
                padding-right: 0.5rem;
            }

            .px-2\.5{
                padding-left: 0.625rem;
                padding-right: 0.625rem;
            }

            .px-3{
                padding-left: 0.75rem;
                padding-right: 0.75rem;
            }

            .px-4{
                padding-left: 1rem;
                padding-right: 1rem;
            }

            .px-6{
                padding-left: 1.5rem;
                padding-right: 1.5rem;
            }

            .px-8{
                padding-left: 2rem;
                padding-right: 2rem;
            }

            .py-0\.5{
                padding-top: 0.125rem;
                padding-bottom: 0.125rem;
            }

            .py-1{
                padding-top: 0.25rem;
                padding-bottom: 0.25rem;
            }

            .py-16{
                padding-top: 4rem;
                padding-bottom: 4rem;
            }

            .py-2{
                padding-top: 0.5rem;
                padding-bottom: 0.5rem;
            }

            .py-20{
                padding-top: 5rem;
                padding-bottom: 5rem;
            }

            .py-3{
                padding-top: 0.75rem;
                padding-bottom: 0.75rem;
            }

            .py-4{
                padding-top: 1rem;
                padding-bottom: 1rem;
            }

            .py-8{
                padding-top: 2rem;
                padding-bottom: 2rem;
            }

            .pl-4{
                padding-left: 1rem;
            }

            .pt-4{
                padding-top: 1rem;
            }

            .pt-8{
                padding-top: 2rem;
            }

            .text-left{
                text-align: left;
            }

            .text-center{
                text-align: center;
            }

            .text-right{
                text-align: right;
            }

            .font-inter{
                font-family: Inter, sans-serif;
            }

            .text-2xl{
                font-size: 1.5rem;
                line-height: 2rem;
            }

            .text-3xl{
                font-size: 1.875rem;
                line-height: 2.25rem;
            }

            .text-4xl{
                font-size: 2.25rem;
                line-height: 2.5rem;
            }

            .text-base{
                font-size: 1rem;
                line-height: 1.5rem;
            }

            .text-lg{
                font-size: 1.125rem;
                line-height: 1.75rem;
            }

            .text-sm{
                font-size: 0.875rem;
                line-height: 1.25rem;
            }

            .text-xl{
                font-size: 1.25rem;
                line-height: 1.75rem;
            }

            .text-xs{
                font-size: 0.75rem;
                line-height: 1rem;
            }

            .font-bold{
                font-weight: 700;
            }

            .font-medium{
                font-weight: 500;
            }

            .font-semibold{
                font-weight: 600;
            }

            .uppercase{
                text-transform: uppercase;
            }

            .italic{
                font-style: italic;
            }

            .leading-relaxed{
                line-height: 1.625;
            }

            .leading-tight{
                line-height: 1.25;
            }

            .text-accent{
                --tw-text-opacity: 1;
                color: rgb(249 115 22 / var(--tw-text-opacity, 1));
            }

            .text-error{
                --tw-text-opacity: 1;
                color: rgb(239 68 68 / var(--tw-text-opacity, 1));
            }

            .text-gray-400{
                --tw-text-opacity: 1;
                color: rgb(156 163 175 / var(--tw-text-opacity, 1));
            }

            .text-gray-500{
                --tw-text-opacity: 1;
                color: rgb(107 114 128 / var(--tw-text-opacity, 1));
            }

            .text-gray-600{
                --tw-text-opacity: 1;
                color: rgb(75 85 99 / var(--tw-text-opacity, 1));
            }

            .text-gray-700{
                --tw-text-opacity: 1;
                color: rgb(55 65 81 / var(--tw-text-opacity, 1));
            }

            .text-gray-900{
                --tw-text-opacity: 1;
                color: rgb(17 24 39 / var(--tw-text-opacity, 1));
            }

            .text-primary{
                --tw-text-opacity: 1;
                color: rgb(30 64 175 / var(--tw-text-opacity, 1));
            }

            .text-primary-200{
                --tw-text-opacity: 1;
                color: rgb(191 219 254 / var(--tw-text-opacity, 1));
            }

            .text-primary-700{
                --tw-text-opacity: 1;
                color: rgb(29 78 216 / var(--tw-text-opacity, 1));
            }

            .text-secondary{
                --tw-text-opacity: 1;
                color: rgb(59 130 246 / var(--tw-text-opacity, 1));
            }

            .text-success{
                --tw-text-opacity: 1;
                color: rgb(16 185 129 / var(--tw-text-opacity, 1));
            }

            .text-text-primary{
                --tw-text-opacity: 1;
                color: rgb(31 41 55 / var(--tw-text-opacity, 1));
            }

            .text-text-secondary{
                --tw-text-opacity: 1;
                color: rgb(107 114 128 / var(--tw-text-opacity, 1));
            }

            .text-warning{
                --tw-text-opacity: 1;
                color: rgb(245 158 11 / var(--tw-text-opacity, 1));
            }

            .text-white{
                --tw-text-opacity: 1;
                color: rgb(255 255 255 / var(--tw-text-opacity, 1));
            }

            .opacity-10{
                opacity: 0.1;
            }

            .opacity-50{
                opacity: 0.5;
            }

            .opacity-60{
                opacity: 0.6;
            }

            .opacity-75{
                opacity: 0.75;
            }

            .opacity-90{
                opacity: 0.9;
            }

            .shadow-2xl{
                --tw-shadow: 0 25px 50px -12px rgb(0 0 0 / 0.25);
                --tw-shadow-colored: 0 25px 50px -12px var(--tw-shadow-color);
                box-shadow: var(--tw-ring-offset-shadow, 0 0 #0000), var(--tw-ring-shadow, 0 0 #0000), var(--tw-shadow);
            }

            .shadow-cta{
                --tw-shadow: 0 4px 6px -1px rgba(0, 0, 0, 0.1);
                --tw-shadow-colored: 0 4px 6px -1px var(--tw-shadow-color);
                box-shadow: var(--tw-ring-offset-shadow, 0 0 #0000), var(--tw-ring-shadow, 0 0 #0000), var(--tw-shadow);
            }

            .shadow-lg{
                --tw-shadow: 0 10px 15px -3px rgb(0 0 0 / 0.1), 0 4px 6px -4px rgb(0 0 0 / 0.1);
                --tw-shadow-colored: 0 10px 15px -3px var(--tw-shadow-color), 0 4px 6px -4px var(--tw-shadow-color);
                box-shadow: var(--tw-ring-offset-shadow, 0 0 #0000), var(--tw-ring-shadow, 0 0 #0000), var(--tw-shadow);
            }

            .shadow-sm{
                --tw-shadow: 0 1px 2px 0 rgb(0 0 0 / 0.05);
                --tw-shadow-colored: 0 1px 2px 0 var(--tw-shadow-color);
                box-shadow: var(--tw-ring-offset-shadow, 0 0 #0000), var(--tw-ring-shadow, 0 0 #0000), var(--tw-shadow);
            }

            .shadow-xl{
                --tw-shadow: 0 20px 25px -5px rgb(0 0 0 / 0.1), 0 8px 10px -6px rgb(0 0 0 / 0.1);
                --tw-shadow-colored: 0 20px 25px -5px var(--tw-shadow-color), 0 8px 10px -6px var(--tw-shadow-color);
                box-shadow: var(--tw-ring-offset-shadow, 0 0 #0000), var(--tw-ring-shadow, 0 0 #0000), var(--tw-shadow);
            }

            .backdrop-blur-sm{
                --tw-backdrop-blur: blur(4px);
                -webkit-backdrop-filter: var(--tw-backdrop-blur) var(--tw-backdrop-brightness) var(--tw-backdrop-contrast) var(--tw-backdrop-grayscale) var(--tw-backdrop-hue-rotate) var(--tw-backdrop-invert) var(--tw-backdrop-opacity) var(--tw-backdrop-saturate) var(--tw-backdrop-sepia);
                backdrop-filter: var(--tw-backdrop-blur) var(--tw-backdrop-brightness) var(--tw-backdrop-contrast) var(--tw-backdrop-grayscale) var(--tw-backdrop-hue-rotate) var(--tw-backdrop-invert) var(--tw-backdrop-opacity) var(--tw-backdrop-saturate) var(--tw-backdrop-sepia);
            }

            .transition-transform{
                transition-property: transform;
                transition-timing-function: cubic-bezier(0.4, 0, 0.2, 1);
                transition-duration: 150ms;
            }

            .duration-300{
                transition-duration: 300ms;
            }

            .ease-in-out{
                transition-timing-function: cubic-bezier(0.4, 0, 0.2, 1);
            }

            .transition-standard {
                transition: all 250ms ease-in-out;
            }

            .shadow-cta {
                box-shadow: 0 4px 6px -1px rgba(0, 0, 0, 0.1);
            }

            :root {
                /* Primary Colors */
                --color-primary: #1e40af;
                /* blue-800 - Academic authority blue */
                --color-primary-50: #eff6ff;
                /* blue-50 */
                --color-primary-100: #dbeafe;
                /* blue-100 */
                --color-primary-200: #bfdbfe;
                /* blue-200 */
                --color-primary-300: #93c5fd;
                /* blue-300 */
                --color-primary-400: #60a5fa;
                /* blue-400 */
                --color-primary-500: #3b82f6;
                /* blue-500 */
                --color-primary-600: #2563eb;
                /* blue-600 */
                --color-primary-700: #1d4ed8;
                /* blue-700 */
                --color-primary-800: #1e40af;
                /* blue-800 */
                --color-primary-900: #1e3a8a;
                /* blue-900 */
                /* Secondary Colors */
                --color-secondary: #3b82f6;
                /* blue-500 - Supporting blue */
                --color-secondary-50: #eff6ff;
                /* blue-50 */
                --color-secondary-100: #dbeafe;
                /* blue-100 */
                --color-secondary-200: #bfdbfe;
                /* blue-200 */
                --color-secondary-300: #93c5fd;
                /* blue-300 */
                --color-secondary-400: #60a5fa;
                /* blue-400 */
                --color-secondary-500: #3b82f6;
                /* blue-500 */
                --color-secondary-600: #2563eb;
                /* blue-600 */
                --color-secondary-700: #1d4ed8;
                /* blue-700 */
                --color-secondary-800: #1e40af;
                /* blue-800 */
                --color-secondary-900: #1e3a8a;
                /* blue-900 */
                /* Accent Colors */
                --color-accent: #f97316;
                /* orange-500 - Conversion orange */
                --color-accent-50: #fff7ed;
                /* orange-50 */
                --color-accent-100: #ffedd5;
                /* orange-100 */
                --color-accent-200: #fed7aa;
                /* orange-200 */
                --color-accent-300: #fdba74;
                /* orange-300 */
                --color-accent-400: #fb923c;
                /* orange-400 */
                --color-accent-500: #f97316;
                /* orange-500 */
                --color-accent-600: #ea580c;
                /* orange-600 */
                --color-accent-700: #c2410c;
                /* orange-700 */
                --color-accent-800: #9a3412;
                /* orange-800 */
                --color-accent-900: #7c2d12;
                /* orange-900 */
                /* Background Colors */
                --color-background: #ffffff;
                /* white */
                --color-surface: #f8fafc;
                /* slate-50 */
                /* Text Colors */
                --color-text-primary: #1f2937;
                /* gray-800 */
                --color-text-secondary: #6b7280;
                /* gray-500 */
                /* Status Colors */
                --color-success: #10b981;
                /* emerald-500 */
                --color-success-50: #ecfdf5;
                /* emerald-50 */
                --color-success-100: #d1fae5;
                /* emerald-100 */
                --color-success-500: #10b981;
                /* emerald-500 */
                --color-success-600: #059669;
                /* emerald-600 */
                --color-warning: #f59e0b;
                /* amber-500 */
                --color-warning-50: #fffbeb;
                /* amber-50 */
                --color-warning-100: #fef3c7;
                /* amber-100 */
                --color-warning-500: #f59e0b;
                /* amber-500 */
                --color-warning-600: #d97706;
                /* amber-600 */
                --color-error: #ef4444;
                /* red-500 */
                --color-error-50: #fef2f2;
                /* red-50 */
                --color-error-100: #fee2e2;
                /* red-100 */
                --color-error-500: #ef4444;
                /* red-500 */
                --color-error-600: #dc2626;
                /* red-600 */
                /* Border Colors */
                --color-border: #e5e7eb;
                /* gray-200 */
                --color-border-light: #f3f4f6;
                /* gray-100 */
            }

            /* Custom Components */

            /* Custom Utilities */

            .hover\:border-primary-400:hover{
                --tw-border-opacity: 1;
                border-color: rgb(96 165 250 / var(--tw-border-opacity, 1));
            }

            .hover\:bg-accent-600:hover{
                --tw-bg-opacity: 1;
                background-color: rgb(234 88 12 / var(--tw-bg-opacity, 1));
            }

            .hover\:bg-gray-100:hover{
                --tw-bg-opacity: 1;
                background-color: rgb(243 244 246 / var(--tw-bg-opacity, 1));
            }

            .hover\:bg-primary-50:hover{
                --tw-bg-opacity: 1;
                background-color: rgb(239 246 255 / var(--tw-bg-opacity, 1));
            }

            .hover\:bg-secondary-600:hover{
                --tw-bg-opacity: 1;
                background-color: rgb(37 99 235 / var(--tw-bg-opacity, 1));
            }

            .hover\:bg-opacity-30:hover{
                --tw-bg-opacity: 0.3;
            }

            .hover\:text-accent-600:hover{
                --tw-text-opacity: 1;
                color: rgb(234 88 12 / var(--tw-text-opacity, 1));
            }

            .hover\:text-primary:hover{
                --tw-text-opacity: 1;
                color: rgb(30 64 175 / var(--tw-text-opacity, 1));
            }

            .hover\:text-primary-600:hover{
                --tw-text-opacity: 1;
                color: rgb(37 99 235 / var(--tw-text-opacity, 1));
            }

            .hover\:text-success-600:hover{
                --tw-text-opacity: 1;
                color: rgb(5 150 105 / var(--tw-text-opacity, 1));
            }

            .hover\:text-white:hover{
                --tw-text-opacity: 1;
                color: rgb(255 255 255 / var(--tw-text-opacity, 1));
            }

            .hover\:underline:hover{
                text-decoration-line: underline;
            }

            .hover\:shadow-md:hover{
                --tw-shadow: 0 4px 6px -1px rgb(0 0 0 / 0.1), 0 2px 4px -2px rgb(0 0 0 / 0.1);
                --tw-shadow-colored: 0 4px 6px -1px var(--tw-shadow-color), 0 2px 4px -2px var(--tw-shadow-color);
                box-shadow: var(--tw-ring-offset-shadow, 0 0 #0000), var(--tw-ring-shadow, 0 0 #0000), var(--tw-shadow);
            }

            .hover\:shadow-xl:hover{
                --tw-shadow: 0 20px 25px -5px rgb(0 0 0 / 0.1), 0 8px 10px -6px rgb(0 0 0 / 0.1);
                --tw-shadow-colored: 0 20px 25px -5px var(--tw-shadow-color), 0 8px 10px -6px var(--tw-shadow-color);
                box-shadow: var(--tw-ring-offset-shadow, 0 0 #0000), var(--tw-ring-shadow, 0 0 #0000), var(--tw-shadow);
            }

            .group:hover .group-hover\:bg-accent-200{
                --tw-bg-opacity: 1;
                background-color: rgb(254 215 170 / var(--tw-bg-opacity, 1));
            }

            .group:hover .group-hover\:bg-primary-200{
                --tw-bg-opacity: 1;
                background-color: rgb(191 219 254 / var(--tw-bg-opacity, 1));
            }

            .group:hover .group-hover\:bg-secondary-200{
                --tw-bg-opacity: 1;
                background-color: rgb(191 219 254 / var(--tw-bg-opacity, 1));
            }

            @media (min-width: 640px){
                .sm\:flex-row{
                    flex-direction: row;
                }

                .sm\:px-6{
                    padding-left: 1.5rem;
                    padding-right: 1.5rem;
                }
            }

            @media (min-width: 768px){
                .md\:mt-0{
                    margin-top: 0px;
                }

                .md\:flex{
                    display: flex;
                }

                .md\:hidden{
                    display: none;
                }

                .md\:grid-cols-2{
                    grid-template-columns: repeat(2, minmax(0, 1fr));
                }

                .md\:grid-cols-3{
                    grid-template-columns: repeat(3, minmax(0, 1fr));
                }

                .md\:grid-cols-4{
                    grid-template-columns: repeat(4, minmax(0, 1fr));
                }

                .md\:flex-row{
                    flex-direction: row;
                }
            }

            @media (min-width: 1024px){
                .lg\:col-span-2{
                    grid-column: span 2 / span 2;
                }

                .lg\:grid-cols-2{
                    grid-template-columns: repeat(2, minmax(0, 1fr));
                }

                .lg\:grid-cols-3{
                    grid-template-columns: repeat(3, minmax(0, 1fr));
                }

                .lg\:grid-cols-4{
                    grid-template-columns: repeat(4, minmax(0, 1fr));
                }

                .lg\:grid-cols-6{
                    grid-template-columns: repeat(6, minmax(0, 1fr));
                }

                .lg\:justify-start{
                    justify-content: flex-start;
                }

                .lg\:px-8{
                    padding-left: 2rem;
                    padding-right: 2rem;
                }

                .lg\:text-left{
                    text-align: left;
                }

                .lg\:text-4xl{
                    font-size: 2.25rem;
                    line-height: 2.5rem;
                }

                .lg\:text-5xl{
                    font-size: 3rem;
                    line-height: 1;
                }

                .lg\:text-6xl{
                    font-size: 3.75rem;
                    line-height: 1;
                }
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

            .relative {
                position: relative;
            }


            /* Estilos para los nuevos modales */
            .modal {
                display: none;
                position: fixed;
                top: 0;
                left: 0;
                width: 100%;
                height: 100%;
                background-color: rgba(0, 0, 0, 0.5);
                z-index: 1000;
                opacity: 0;
                transition: opacity 0.3s ease-in-out;
            }

            .modal.show {
                display: flex;
                opacity: 1;
                align-items: center;
                justify-content: center;
            }

            .modal-content {
                background-color: white;
                border-radius: 1rem;
                width: 90%;
                max-width: 1000px;
                max-height: 85vh;
                transform: translateY(-20px);
                transition: transform 0.3s ease-in-out;
                overflow: hidden;
                box-shadow: 0 25px 50px -12px rgba(0, 0, 0, 0.25);
            }

            .modal.show .modal-content {
                transform: translateY(0);
            }

            .modal-header {
                padding: 1.5rem 2rem;
                border-bottom: 1px solid #e5e7eb;
                display: flex;
                justify-content: space-between;
                align-items: center;
                background-color: #f8fafc;
            }

            .modal-title {
                font-size: 1.5rem;
                font-weight: 600;
                color: #1e40af;
            }

            .modal-close {
                background: none;
                border: none;
                font-size: 1.5rem;
                cursor: pointer;
                color: #6b7280;
                padding: 0.5rem;
                border-radius: 0.375rem;
                transition: background-color 0.2s;
            }

            .modal-close:hover {
                background-color: #f3f4f6;
                color: #1f2937;
            }

            .modal-body {
                padding: 2rem;
                overflow-y: auto;
                max-height: calc(85vh - 120px);
            }

            /* Estilos específicos para el visor de documentos */
            .document-viewer {
                width: 100%;
                height: 60vh;
                border: 1px solid #e5e7eb;
                border-radius: 0.5rem;
                background-color: #f9fafb;
                display: flex;
                align-items: center;
                justify-content: center;
                overflow: hidden;
            }

            .document-iframe {
                width: 100%;
                height: 100%;
                border: none;
            }

            .document-unavailable {
                text-align: center;
                padding: 2rem;
            }

            .document-unavailable svg {
                color: #9ca3af;
                margin-bottom: 1rem;
            }

            .document-info {
                margin-top: 1rem;
                padding: 1rem;
                background-color: #f8fafc;
                border-radius: 0.5rem;
                border: 1px solid #e5e7eb;
            }

            /* Estilos para el calendario */
            .calendar-container {
                display: flex;
                flex-direction: column;
                gap: 1.5rem;
            }

            .calendar-header {
                display: flex;
                justify-content: space-between;
                align-items: center;
                margin-bottom: 1rem;
            }

            .calendar-nav {
                display: flex;
                gap: 0.5rem;
            }

            .calendar-nav button {
                padding: 0.5rem 1rem;
                border: 1px solid #e5e7eb;
                border-radius: 0.375rem;
                background-color: white;
                cursor: pointer;
                transition: all 0.2s;
            }

            .calendar-nav button:hover {
                background-color: #f3f4f6;
            }

            .calendar-grid {
                display: grid;
                grid-template-columns: repeat(7, 1fr);
                gap: 0.5rem;
            }

            .calendar-day-header {
                text-align: center;
                padding: 0.5rem;
                font-weight: 600;
                color: #374151;
                background-color: #f9fafb;
                border-radius: 0.375rem;
            }

            .calendar-day {
                text-align: center;
                padding: 0.75rem;
                border: 1px solid #e5e7eb;
                border-radius: 0.375rem;
                cursor: pointer;
                transition: all 0.2s;
                min-height: 80px;
                background-color: white;
            }

            .calendar-day:hover {
                background-color: #eff6ff;
                border-color: #3b82f6;
            }

            .calendar-day.today {
                background-color: #3b82f6;
                color: white;
                border-color: #3b82f6;
            }

            .calendar-day.has-event {
                background-color: #dbeafe;
                border-color: #60a5fa;
            }

            .calendar-day.has-event::after {
                content: '';
                display: block;
                width: 6px;
                height: 6px;
                background-color: #3b82f6;
                border-radius: 50%;
                margin: 4px auto 0;
            }

            .calendar-day.today.has-event::after {
                background-color: white;
            }

            .calendar-day.other-month {
                color: #9ca3af;
                background-color: #f9fafb;
            }

            .calendar-events {
                margin-top: 2rem;
            }

            .calendar-event {
                padding: 1rem;
                border-left: 4px solid #3b82f6;
                background-color: #f8fafc;
                border-radius: 0.5rem;
                margin-bottom: 1rem;
            }

            .calendar-event.accent {
                border-left-color: #f97316;
            }

            .calendar-event.success {
                border-left-color: #10b981;
            }
        </style>
    </head>
    <body class="font-inter text-text-primary">
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
                        <span class="ml-3 px-2 py-1 bg-secondary-100 text-secondary text-xs font-medium rounded-full">Estudiante</span>
                    </div>

                    <!-- User Profile -->
                    <div class="flex items-center space-x-4">
                        <!-- Notifications -->
                        <button class="p-2 text-text-secondary hover:text-primary transition-standard relative">
                            <svg class="w-6 h-6" fill="none" stroke="currentColor" viewBox="0 0 24 24">
                            <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M15 17h5l-5 5v-5zM4 17h5l-5 5v-5zM12 12l8-8m0 0l-8 8m8-8v8"/>
                            </svg>
                            <% if (mensajesNoLeidos > 0) {%>
                            <span class="absolute -top-1 -right-1 bg-accent text-white text-xs w-5 h-5 rounded-full flex items-center justify-center">
                                <%= mensajesNoLeidos%>
                            </span>
                            <% }%>
                        </button>

                        <!-- User Menu -->
                        <div class="relative">
                            <div class="flex items-center space-x-3 cursor-pointer" id="user-menu-button">
                                <div class="text-right">
                                    <!-- NOMBRE DINÁMICO -->
                                    <div class="text-sm font-medium text-primary">
                                        <%= nombreEstudiante%>
                                    </div>
                                    <div class="text-xs text-text-secondary">Estudiante</div>
                                </div>
                                <!-- FOTO DINÁMICA -->
                                <img src="<%= fotoPerfil%>" 
                                     alt="Foto de perfil de <%= nombreEstudiante%>" 
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
                                    <a href="${pageContext.request.contextPath}/logout" class="dropdown-item text-error">
                                        <svg fill="none" stroke="currentColor" viewBox="0 0 24 24">
                                        <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M17 16l4-4m0 0l-4-4m4 4H7m6 4v1a3 3 0 01-3 3H6a3 3 0 01-3-3V7a3 3 0 013-3h4a3 3 0 013 3v1"/>
                                        </svg>
                                        Cerrar Sesión
                                    </a>
                                </div>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
        </nav>

        <!-- Main Content -->
        <div class="max-w-7xl mx-auto px-4 sm:px-6 lg:px-8 py-8">
            <!-- Welcome Header -->
            <div class="mb-8">
                <!-- SALUDO DINÁMICO -->
                <h1 class="text-3xl font-bold text-primary mb-2">
                    ¡Bienvenid@, <%= estudiante.getNombre() != null ? estudiante.getNombre() : "Estudiante"%>!
                </h1>
                <p class="text-text-secondary">Gestiona tu proceso de tesis desde aquí. Sube documentos, revisa comentarios y mantente al día con el progreso.</p>
            </div>

            <!-- Quick Stats -->
            <div class="grid grid-cols-1 md:grid-cols-4 gap-6 mb-8">
                <div class="bg-white rounded-xl p-6 border border-gray-200 shadow-sm">
                    <div class="flex items-center">
                        <div class="w-12 h-12 bg-primary-100 rounded-lg flex items-center justify-center">
                            <svg class="w-6 h-6 text-primary" fill="none" stroke="currentColor" viewBox="0 0 24 24">
                            <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M9 12h6m-6 4h6m2 5H7a2 2 0 01-2-2V5a2 2 0 012-2h5.586a1 1 0 01.707.293l5.414 5.414a1 1 0 01.293.707V19a2 2 0 01-2 2z"/>
                            </svg>
                        </div>
                        <div class="ml-4">
                            <p class="text-sm text-text-secondary">Mi Tesis</p>
                            <!-- CONTADOR DINÁMICO -->
                            <p class="text-2xl font-bold text-primary">
                                <%= tesis != null ? 1 : 0%>
                            </p>
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
                            <p class="text-sm text-text-secondary">Progreso</p>
                            <!-- PROGRESO DINÁMICO -->
                            <p class="text-2xl font-bold text-success">
                                <%= progreso%>%
                            </p>
                        </div>
                    </div>
                </div>

                <div class="bg-white rounded-xl p-6 border border-gray-200 shadow-sm">
                    <div class="flex items-center">
                        <div class="w-12 h-12 bg-accent-100 rounded-lg flex items-center justify-center">
                            <svg class="w-6 h-6 text-accent" fill="none" stroke="currentColor" viewBox="0 0 24 24">
                            <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M7 8h10M7 12h4m1 8l-4-4H5a2 2 0 01-2-2V6a2 2 0 012-2h14a2 2 0 012 2v8a2 2 0 01-2 2h-3l-4 4z"/>
                            </svg>
                        </div>
                        <div class="ml-4">
                            <p class="text-sm text-text-secondary">Comentarios</p>
                            <!-- COMENTARIOS DINÁMICOS -->
                            <p class="text-2xl font-bold text-accent">
                                <%= totalMensajes%>
                            </p>
                        </div>
                    </div>
                </div>

                <div class="bg-white rounded-xl p-6 border border-gray-200 shadow-sm">
                    <div class="flex items-center">
                        <div class="w-12 h-12 bg-secondary-100 rounded-lg flex items-center justify-center">
                            <svg class="w-6 h-6 text-secondary" fill="none" stroke="currentColor" viewBox="0 0 24 24">
                            <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M12 8v4l3 3m6-3a9 9 0 11-18 0 9 9 0 0118 0z"/>
                            </svg>
                        </div>
                        <div class="ml-4">
                            <p class="text-sm text-text-secondary">Días Restantes</p>
                            <!-- DÍAS DINÁMICOS -->
                            <p class="text-2xl font-bold text-secondary">
                                <%= diasRestantes%>
                            </p>
                        </div>
                    </div>
                </div>
            </div>

            <!-- Main Dashboard Grid -->
            <div class="grid grid-cols-1 lg:grid-cols-3 gap-8">
                <!-- Left Column - Thesis Status & Upload -->
                <div class="lg:col-span-2 space-y-8">
                    <!-- Thesis Status Card -->
                    <div class="bg-white rounded-xl border border-gray-200 shadow-sm overflow-hidden">
                        <div class="px-6 py-4 border-b border-gray-200 bg-primary-50">
                            <h2 class="text-lg font-semibold text-primary flex items-center">
                                <svg class="w-5 h-5 mr-2" fill="none" stroke="currentColor" viewBox="0 0 24 24">
                                <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M9 12h6m-6 4h6m2 5H7a2 2 0 01-2-2V5a2 2 0 012-2h5.586a1 1 0 01.707.293l5.414 5.414a1 1 0 01.293.707V19a2 2 0 01-2 2z"/>
                                </svg>
                                Estado de tu Tesis
                            </h2>
                        </div>
                        <div class="p-6">
                            <!-- Progress Timeline -->
                            <div class="mb-6">
                                <div class="flex items-center justify-between mb-2">
                                    <span class="text-sm font-medium text-primary">Progreso General</span>
                                    <!-- PROGRESO DINÁMICO -->
                                    <span class="text-sm text-text-secondary">
                                        <%= progreso%>% completado
                                    </span>
                                </div>
                                <div class="w-full bg-gray-200 rounded-full h-3">
                                    <!-- BARRA DE PROGRESO DINÁMICA -->
                                    <div class="bg-gradient-to-r from-primary to-secondary h-3 rounded-full" style="width: <%= progreso%>%"></div>
                                </div>
                            </div>

                            <!-- Tesis Information -->
                            <% if (tesis != null) {%>
                            <div class="mb-4 p-4 bg-primary-50 rounded-lg">
                                <!-- TÍTULO DINÁMICO -->
                                <h3 class="font-medium text-primary mb-2">
                                    <%= tesis.getTitulo() != null ? tesis.getTitulo() : "Tesis sin título"%>
                                </h3>
                                <div class="flex items-center text-sm text-text-secondary">
                                    <svg class="w-4 h-4 mr-2" fill="none" stroke="currentColor" viewBox="0 0 24 24">
                                    <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M8 7V3m8 4V3m-9 8h10M5 21h14a2 2 0 01-2-2V7a2 2 0 012-2H5a2 2 0 00-2 2v12a2 2 0 002 2z"/>
                                    </svg>
                                    <% if (tesis.getFechaCreacion() != null) {%>
                                    Subido: <%= sdf.format(tesis.getFechaCreacion())%>
                                    <% } else { %>
                                    Fecha no disponible
                                    <% } %>
                                </div>
                                <div class="mt-2 flex items-center">
                                    <!-- ESTADO DINÁMICO -->
                                    <span class="px-3 py-1 rounded-full text-sm font-medium 
                                          <% if (tesis.getEstado() != null && ("EN_REVISION".equals(tesis.getEstado()) || "EN REVISION".equals(tesis.getEstado()))) { %>
                                          bg-blue-100 text-blue-800
                                          <% } else if (tesis.getEstado() != null && "APROBADA".equals(tesis.getEstado())) { %>
                                          bg-green-100 text-green-800
                                          <% } else if (tesis.getEstado() != null && "PENDIENTE".equals(tesis.getEstado())) { %>
                                          bg-yellow-100 text-yellow-800
                                          <% } else { %>
                                          bg-gray-100 text-gray-800
                                          <% }%>">
                                        <%= tesis.getEstado() != null ? tesis.getEstado() : "SIN ESTADO"%>
                                    </span>
                                </div>
                            </div>

                            <!-- Quick Actions -->
                            <div class="flex gap-3 mt-6">
                                <%
                                    String archivoRuta = null;
                                    try {
                                        if (tesis != null) {
                                            archivoRuta = tesis.getArchivo();
                                        }
                                    } catch (Exception e) {
                                        archivoRuta = null;
                                    }

                                    if (archivoRuta != null && !archivoRuta.trim().isEmpty()) {
                                %>
                                <button onclick="openModal('documentModal')" class="btn-accent flex-1 text-center">
                                    <svg class="w-4 h-4 mr-2 inline" fill="none" stroke="currentColor" viewBox="0 0 24 24">
                                    <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M15 12a3 3 0 11-6 0 3 3 0 016 0z"/>
                                    <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M2.458 12C3.732 7.943 7.523 5 12 5c4.478 0 8.268 2.943 9.542 7-1.274 4.057-5.064 7-9.542 7-4.477 0-8.268-2.943-9.542-7z"/>
                                    </svg>
                                    Ver Documento
                                </button>
                                <% } else if (tesis != null) { %>
                                <button class="btn-accent flex-1 text-center opacity-50 cursor-not-allowed" disabled>
                                    <svg class="w-4 h-4 mr-2 inline" fill="none" stroke="currentColor" viewBox="0 0 24 24">
                                    <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M9 12h6m-6 4h6m2 5H7a2 2 0 01-2-2V5a2 2 0 012-2h5.586a1 1 0 01.707.293l5.414 5.414a1 1 0 01.293.707V19a2 2 0 01-2 2z"/>
                                    </svg>
                                    Sin Documento
                                </button>
                                <% } %>
                            </div>
                            <% } else { %>
                            <!-- No hay tesis -->
                            <div class="text-center py-8">
                                <svg class="w-12 h-12 mx-auto text-gray-400" fill="none" stroke="currentColor" viewBox="0 0 24 24">
                                <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M9 12h6m-6 4h6m2 5H7a2 2 0 01-2-2V5a2 2 0 012-2h5.586a1 1 0 01.707.293l5.414 5.414a1 1 0 01.293.707V19a2 2 0 01-2 2z"/>
                                </svg>
                                <p class="mt-4 text-text-secondary">No tienes una tesis registrada aún.</p>

                            </div>
                            <% } %>
                        </div>
                    </div>

                    <!-- Messages & Communication -->
                    <div class="bg-white rounded-xl border border-gray-200 shadow-sm overflow-hidden">
                        <div class="px-6 py-4 border-b border-gray-200 bg-secondary-50">
                            <h2 class="text-lg font-semibold text-primary flex items-center justify-between">
                                <span class="flex items-center">
                                    <svg class="w-5 h-5 mr-2" fill="none" stroke="currentColor" viewBox="0 0 24 24">
                                    <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M8 12h.01M12 12h.01M16 12h.01M21 12c0 4.418-4.03 8-9 8a9.863 9.863 0 01-4.255-.949L3 20l1.395-3.72C3.512 15.042 3 13.574 3 12c0-4.418 4.03-8 9-8s9 3.582 9 8z"/>
                                    </svg>
                                    Mensajes con Asesor
                                </span>
                                <!-- CONTADOR DE MENSAJES NUEVOS DINÁMICO -->
                                <% if (mensajesNoLeidos > 0) {%>
                                <span class="bg-secondary text-white text-xs px-2 py-1 rounded-full">
                                    <%= mensajesNoLeidos%> nuevo(s)
                                </span>
                                <% } %>
                            </h2>
                        </div>
                        <div class="p-6">
                            <% if (!mensajes.isEmpty()) { %>
                            <div class="space-y-4" id="messages-container">
                                <%
                                    for (Mensaje mensaje : mensajes) {
                                        boolean isMine = false;
                                        String nombreRemitente = "Asesor";
                                        String fotoRemitente = "https://images.unsplash.com/photo-1659353888640-91aa7c25fa29";

                                        try {
                                            if (mensaje.getIdEstudiante() > 0 && mensaje.getIdEstudiante() == estudiante.getId()) {
                                                isMine = true;
                                                nombreRemitente = "Tú";
                                                fotoRemitente = fotoPerfil;
                                            } else if (mensaje.getIdDocente() > 0) {
                                                isMine = false;
                                                if (docenteAsignado != null) {
                                                    nombreRemitente = docenteAsignado.getNombre() + " " + docenteAsignado.getApellido();
                                                }
                                            }
                                        } catch (Exception e) {
                                            isMine = false;
                                            nombreRemitente = "Asesor";
                                        }
                                %>
                                <div class="flex items-start space-x-3 <%= isMine ? "justify-end" : ""%>">
                                    <% if (!isMine) {%>
                                    <img src="<%= fotoRemitente%>" 
                                         alt="<%= nombreRemitente%>" 
                                         class="w-10 h-10 rounded-full object-cover"
                                         onerror="this.src='https://images.unsplash.com/photo-1659353888640-91aa7c25fa29'; this.onerror=null;">
                                    <% }%>
                                    <div class="<%= isMine ? "bg-primary text-white rounded-lg" : "bg-secondary-50 rounded-lg"%> p-3 max-w-xs">
                                        <div class="flex items-center justify-between mb-1">
                                            <span class="font-medium <%= isMine ? "text-primary-200" : "text-secondary"%>">
                                                <%= nombreRemitente%>
                                            </span>
                                            <span class="text-xs <%= isMine ? "text-primary-200" : "text-text-secondary"%>">
                                                <% if (mensaje.getFechaEnvio() != null) {%>
                                                <%= msgSdf.format(mensaje.getFechaEnvio())%>
                                                <% } else { %>
                                                Fecha no disponible
                                                <% }%>
                                            </span>
                                        </div>
                                        <p class="text-sm <%= isMine ? "" : "text-text-secondary"%>">
                                            <%= mensaje.getContenido() != null ? mensaje.getContenido() : ""%>
                                        </p>
                                        <% if ("no_leido".equals(mensaje.getEstado()) && !isMine) { %>
                                        <span class="text-xs text-accent">● No leído</span>
                                        <% } %>
                                    </div>
                                    <% if (isMine) {%>
                                    <img src="<%= fotoRemitente%>" 
                                         alt="<%= nombreEstudiante%>" 
                                         class="w-10 h-10 rounded-full object-cover"
                                         onerror="this.src='<%= fotoPerfil%>'; this.onerror=null;">
                                    <% } %>
                                </div>
                                <% } %>
                            </div>
                            <% } else { %>
                            <!-- No hay mensajes -->
                            <div class="text-center py-8">
                                <svg class="w-12 h-12 mx-auto text-gray-400" fill="none" stroke="currentColor" viewBox="0 0 24 24">
                                <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M8 12h.01M12 12h.01M16 12h.01M21 12c0 4.418-4.03 8-9 8a9.863 9.863 0 01-4.255-.949L3 20l1.395-3.72C3.512 15.042 3 13.574 3 12c0-4.418 4.03-8 9-8s9 3.582 9 8z"/>
                                </svg>
                                <p class="mt-4 text-text-secondary">No tienes mensajes con tu asesor aún.</p>
                            </div>
                            <% } %>

                            <!-- Message Input -->
                            <% if (docenteAsignado != null && tesis != null && idAsignacion > 0) {%>
                            <div class="mt-4 pt-4 border-t border-gray-200">
                                <form id="messageForm" action="../MensajeController" method="POST">
                                    <input type="hidden" name="action" value="enviar">
                                    <input type="hidden" name="idAsignacion" value="<%= idAsignacion%>">
                                    <input type="hidden" name="idEstudiante" value="<%= estudiante.getId()%>">
                                    <input type="hidden" name="idDocente" value="<%= docenteAsignado.getId()%>">
                                    <input type="hidden" name="asunto" value="Consulta sobre tesis">
                                    <input type="hidden" name="tipoMensaje" value="consulta">

                                    <div class="flex space-x-2">
                                        <input type="text" name="contenido" placeholder="Escribe tu mensaje al asesor..." 
                                               class="flex-1 form-input text-sm" id="messageInput" required>
                                        <button type="submit" class="btn-primary px-4 py-2 text-sm">
                                            <svg class="w-4 h-4" fill="none" stroke="currentColor" viewBox="0 0 24 24">
                                            <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M12 19l9 2-9-18-9 18 9-2zm0 0v-8"/>
                                            </svg>
                                        </button>
                                    </div>
                                </form>
                            </div>
                            <% } %>
                        </div>
                    </div>
                </div>

                <!-- Right Column - Reviews & Information -->
                <div class="space-y-8">
                    <!-- Recent Reviews -->
                    <div class="bg-white rounded-xl border border-gray-200 shadow-sm overflow-hidden">
                        <div class="px-6 py-4 border-b border-gray-200 bg-accent-50">
                            <h2 class="text-lg font-semibold text-primary flex items-center justify-between">
                                <span class="flex items-center">
                                    <svg class="w-5 h-5 mr-2" fill="none" stroke="currentColor" viewBox="0 0 24 24">
                                    <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M7 8h10M7 12h4m1 8l-4-4H5a2 2 0 01-2-2V6a2 2 0 012-2h14a2 2 0 012 2v8a2 2 0 01-2 2h-3l-4 4z"/>
                                    </svg>
                                    Comentarios del Jurado
                                </span>
                                <span class="bg-accent text-white text-xs px-2 py-1 rounded-full">0</span>
                            </h2>
                        </div>
                        <div class="p-6">
                            <div class="text-center py-4">
                                <svg class="w-12 h-12 mx-auto text-gray-400" fill="none" stroke="currentColor" viewBox="0 0 24 24">
                                <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M7 8h10M7 12h4m1 8l-4-4H5a2 2 0 01-2-2V6a2 2 0 012-2h14a2 2 0 012 2v8a2 2 0 01-2 2h-3l-4 4z"/>
                                </svg>
                                <p class="mt-4 text-text-secondary">No hay comentarios del jurado aún.</p>
                                <p class="text-xs text-gray-500 mt-2">Los comentarios del jurado aparecerán aquí cuando revisen tu tesis.</p>
                            </div>

                            <a href="mensajes-jurado.jsp" class="w-full mt-4 text-sm text-primary hover:bg-primary-50 py-2 rounded-lg transition-standard block text-center">
                                Ver Todos los Comentarios del Jurado
                            </a>
                        </div>
                    </div>

                    <!-- Assigned Advisor -->
                    <% if (docenteAsignado != null) {%>
                    <div class="bg-white rounded-xl border border-gray-200 shadow-sm overflow-hidden">
                        <div class="px-6 py-4 border-b border-gray-200 bg-primary-50">
                            <h2 class="text-lg font-semibold text-primary flex items-center">
                                <svg class="w-5 h-5 mr-2" fill="none" stroke="currentColor" viewBox="0 0 24 24">
                                <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M16 7a4 4 0 11-8 0 4 4 0 018 0zM12 14a7 7 0 00-7 7h14a7 7 0 00-7-7z"/>
                                </svg>
                                Asesor Asignado
                            </h2>
                        </div>
                        <div class="p-6">
                            <div class="flex items-center space-x-4">
                                <img src="https://images.unsplash.com/photo-1659353888640-91aa7c25fa29" 
                                     alt="<%= docenteAsignado.getNombre()%>" 
                                     class="w-16 h-16 rounded-full object-cover"
                                     onerror="this.src='https://images.unsplash.com/photo-1659353888640-91aa7c25fa29'; this.onerror=null;">
                                <div>
                                    <!-- NOMBRE DEL ASESOR DINÁMICO -->
                                    <h3 class="font-semibold text-primary">
                                        <%= docenteAsignado.getNombre() != null ? docenteAsignado.getNombre() : ""%> 
                                        <%= docenteAsignado.getApellido() != null ? docenteAsignado.getApellido() : ""%>
                                    </h3>
                                    <!-- EMAIL DEL ASESOR DINÁMICO -->
                                    <p class="text-sm text-text-secondary">
                                        <%= docenteAsignado.getEmail() != null ? docenteAsignado.getEmail() : ""%>
                                    </p>
                                    <p class="text-sm text-text-secondary mt-1">Asesor de Tesis</p>
                                </div>
                            </div>
                            <div class="mt-4 space-y-2">
                                <% if (tesis != null && tesis.getEstado() != null
                                        && ("EN_REVISION".equals(tesis.getEstado()) || "EN REVISION".equals(tesis.getEstado()))) { %>
                                <div class="flex items-center text-sm text-text-secondary">
                                    <svg class="w-4 h-4 mr-2 text-accent" fill="none" stroke="currentColor" viewBox="0 0 24 24">
                                    <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M9 12l2 2 4-4m6 2a9 9 0 11-18 0 9 9 0 0118 0z"/>
                                    </svg>
                                    Revisando tu tesis
                                </div>
                                <% }%>
                                <div class="flex items-center text-sm text-text-secondary">
                                    <svg class="w-4 h-4 mr-2 text-secondary" fill="none" stroke="currentColor" viewBox="0 0 24 24">
                                    <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M3 8l7.89 5.26a2 2 0 002.22 0L21 8M5 19h14a2 2 0 002-2V7a2 2 0 00-2-2H5a2 2 0 00-2 2v10a2 2 0 002 2z"/>
                                    </svg>
                                    <%= docenteAsignado.getEmail() != null ? docenteAsignado.getEmail() : "Email no disponible"%>
                                </div>
                            </div>
                        </div>
                    </div>
                    <% } %>

                    <!-- Next Steps -->
                    <div class="bg-gradient-to-br from-primary to-secondary text-white rounded-xl p-6 shadow-sm">
                        <h3 class="text-lg font-semibold mb-4 flex items-center">
                            <svg class="w-5 h-5 mr-2" fill="none" stroke="currentColor" viewBox="0 0 24 24">
                            <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M9 5l7 7-7 7"/>
                            </svg>
                            Próximos Pasos
                        </h3>
                        <div class="space-y-3">
                            <% if (tesis == null) { %>
                            <div class="flex items-center">
                                <div class="w-2 h-2 bg-accent rounded-full mr-3"></div>
                                <span class="text-sm">Subir tu propuesta de tesis</span>
                            </div>
                            <% } else if (tesis.getEstado() != null && "PENDIENTE".equals(tesis.getEstado())) { %>
                            <div class="flex items-center">
                                <div class="w-2 h-2 bg-accent rounded-full mr-3"></div>
                                <span class="text-sm">Esperar asignación de asesor</span>
                            </div>
                            <% } else if (tesis.getEstado() != null
                                && ("EN_REVISION".equals(tesis.getEstado()) || "EN REVISION".equals(tesis.getEstado()))) { %>
                            <div class="flex items-center">
                                <div class="w-2 h-2 bg-accent rounded-full mr-3"></div>
                                <span class="text-sm">Revisar comentarios del asesor</span>
                            </div>
                            <div class="flex items-center">
                                <div class="w-2 h-2 bg-accent rounded-full mr-3"></div>
                                <span class="text-sm">Preparar defensa de tesis</span>
                            </div>
                            <% } else if (tesis.getEstado() != null && "APROBADA".equals(tesis.getEstado())) { %>
                            <div class="flex items-center">
                                <div class="w-2 h-2 bg-accent rounded-full mr-3"></div>
                                <span class="text-sm">¡Felicidades! Tesis aprobada</span>
                            </div>
                            <% } else if (tesis.getEstado() != null && "BORRADOR".equals(tesis.getEstado())) { %>
                            <div class="flex items-center">
                                <div class="w-2 h-2 bg-accent rounded-full mr-3"></div>
                                <span class="text-sm">Completar borrador de tesis</span>
                            </div>
                            <% } else { %>
                            <div class="flex items-center">
                                <div class="w-2 h-2 bg-accent rounded-full mr-3"></div>
                                <span class="text-sm">Iniciar proceso de tesis</span>
                            </div>
                            <% } %>
                            <div class="flex items-center">
                                <div class="w-2 h-2 bg-accent rounded-full mr-3"></div>
                                <span class="text-sm">Revisar fechas importantes</span>
                            </div>
                        </div>
                        <button onclick="openModal('calendarModal')" class="w-full mt-4 bg-white text-primary px-4 py-2 rounded-lg font-medium text-sm hover:bg-gray-100 transition-standard block text-center">
                            Ver Calendario
                        </button>

                    </div>
                </div>
            </div>
        </div>

        <!-- MODALES - Agregar antes del script final -->
        <!-- Modal para Ver Documento -->
        <div id="documentModal" class="modal">
            <div class="modal-content">
                <div class="modal-header">
                    <h3 class="modal-title">
                        <svg class="w-6 h-6 mr-2 inline" fill="none" stroke="currentColor" viewBox="0 0 24 24">
                        <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M9 12h6m-6 4h6m2 5H7a2 2 0 01-2-2V5a2 2 0 012-2h5.586a1 1 0 01.707.293l5.414 5.414a1 1 0 01.293.707V19a2 2 0 01-2 2z"/>
                        </svg>
                        Documento de Tesis - Vista de Lectura
                    </h3>
                    <button class="modal-close" onclick="closeModal('documentModal')">
                        &times;
                    </button>
                </div>
                <div class="modal-body">
                    <%
                        String archivoRuta = null;
                        String archivoNombre = "Documento no disponible";
                        String archivoExtension = "pdf";

                        if (tesis != null) {
                            archivoRuta = tesis.getArchivo();
                            archivoNombre = tesis.getTitulo() != null ? tesis.getTitulo() : "Documento de Tesis";

                            if (archivoRuta != null && !archivoRuta.trim().isEmpty()) {
                                // Detectar extensión del archivo
                                if (archivoRuta.toLowerCase().endsWith(".pdf")) {
                                    archivoExtension = "pdf";
                                } else if (archivoRuta.toLowerCase().endsWith(".doc")
                                        || archivoRuta.toLowerCase().endsWith(".docx")) {
                                    archivoExtension = "doc";
                                } else if (archivoRuta.toLowerCase().endsWith(".txt")) {
                                    archivoExtension = "txt";
                                }
                            }
                        }
                    %>

                    <% if (archivoRuta != null && !archivoRuta.trim().isEmpty()) { %>
                    <div class="document-viewer">
                        <% if (archivoExtension.equals("pdf")) {%>
                        <iframe src="<%= archivoRuta%>" class="document-iframe" 
                                title="Documento de tesis: <%= archivoNombre%>">
                        </iframe>
                        <% } else {%>
                        <div class="document-unavailable">
                            <svg class="w-16 h-16 mx-auto" fill="none" stroke="currentColor" viewBox="0 0 24 24">
                            <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M9 12h6m-6 4h6m2 5H7a2 2 0 01-2-2V5a2 2 0 012-2h5.586a1 1 0 01.707.293l5.414 5.414a1 1 0 01.293.707V19a2 2 0 01-2 2z"/>
                            </svg>
                            <p class="text-lg font-medium text-gray-700">Formato no compatible para vista previa</p>
                            <p class="text-gray-500 mt-2">El archivo se abrirá con la aplicación correspondiente</p>
                            <div class="mt-4">
                                <a href="<%= archivoRuta%>" target="_blank" 
                                   class="btn-primary inline-flex items-center">
                                    <svg class="w-5 h-5 mr-2" fill="none" stroke="currentColor" viewBox="0 0 24 24">
                                    <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M4 16v1a3 3 0 003 3h10a3 3 0 003-3v-1m-4-4l-4 4m0 0l-4-4m4 4V4"/>
                                    </svg>
                                    Descargar Archivo
                                </a>
                            </div>
                        </div>
                        <% }%>
                    </div>

                    <div class="document-info mt-4">
                        <div class="grid grid-cols-1 md:grid-cols-3 gap-4">
                            <div>
                                <p class="text-sm text-gray-500">Título</p>
                                <p class="font-medium"><%= archivoNombre%></p>
                            </div>
                            <div>
                                <p class="text-sm text-gray-500">Formato</p>
                                <p class="font-medium uppercase"><%= archivoExtension%></p>
                            </div>
                            <div>
                                <p class="text-sm text-gray-500">Tamaño</p>
                                <p class="font-medium">~2.5 MB</p>
                            </div>
                        </div>
                        <div class="mt-3">
                            <p class="text-sm text-gray-500">Nota</p>
                            <p class="text-sm text-gray-600">Este es un visor de solo lectura. Para editar el documento, debes descargarlo.</p>
                        </div>
                    </div>
                    <% } else { %>
                    <div class="text-center py-12">
                        <svg class="w-20 h-20 mx-auto text-gray-400" fill="none" stroke="currentColor" viewBox="0 0 24 24">
                        <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M9 12h6m-6 4h6m2 5H7a2 2 0 01-2-2V5a2 2 0 012-2h5.586a1 1 0 01.707.293l5.414 5.414a1 1 0 01.293.707V19a2 2 0 01-2 2z"/>
                        </svg>
                        <h3 class="mt-4 text-lg font-medium text-gray-700">Documento no disponible</h3>
                        <p class="mt-2 text-gray-500">No hay un documento de tesis cargado.</p>
                        <p class="text-sm text-gray-400 mt-1">Contacta a tu asesor para más información.</p>
                    </div>
                    <% }%>
                </div>
            </div>
        </div>

        <!-- Modal para Calendario -->
        <div id="calendarModal" class="modal">
            <div class="modal-content" style="max-width: 900px;">
                <div class="modal-header">
                    <h3 class="modal-title">
                        <svg class="w-6 h-6 mr-2 inline" fill="none" stroke="currentColor" viewBox="0 0 24 24">
                        <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M8 7V3m8 4V3m-9 8h10M5 21h14a2 2 0 01-2-2V7a2 2 0 012-2H5a2 2 0 00-2 2v12a2 2 0 002 2z"/>
                        </svg>
                        Calendario Académico
                    </h3>
                    <button class="modal-close" onclick="closeModal('calendarModal')">
                        &times;
                    </button>
                </div>
                <div class="modal-body">
                    <div class="calendar-container">
                        <div class="calendar-header">
                            <h4 id="currentMonth" class="text-xl font-semibold text-primary">Diciembre 2024</h4>
                            <div class="calendar-nav">
                                <button onclick="changeMonth(-1)">
                                    <svg class="w-5 h-5" fill="none" stroke="currentColor" viewBox="0 0 24 24">
                                    <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M15 19l-7-7 7-7"/>
                                    </svg>
                                </button>
                                <button onclick="goToToday()">Hoy</button>
                                <button onclick="changeMonth(1)">
                                    <svg class="w-5 h-5" fill="none" stroke="currentColor" viewBox="0 0 24 24">
                                    <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M9 5l7 7-7 7"/>
                                    </svg>
                                </button>
                            </div>
                        </div>

                        <div class="calendar-grid">
                            <div class="calendar-day-header">Dom</div>
                            <div class="calendar-day-header">Lun</div>
                            <div class="calendar-day-header">Mar</div>
                            <div class="calendar-day-header">Mié</div>
                            <div class="calendar-day-header">Jue</div>
                            <div class="calendar-day-header">Vie</div>
                            <div class="calendar-day-header">Sáb</div>

                            <!-- Los días se generarán con JavaScript -->
                            <div id="calendarDays" class="col-span-7"></div>
                        </div>

                        <div class="calendar-events">
                            <h5 class="text-lg font-medium text-primary mb-3">Eventos Próximos</h5>
                            <div id="calendarEvents">
                                <!-- Eventos se cargarán dinámicamente -->
                                <div class="calendar-event">
                                    <div class="flex justify-between items-start">
                                        <div>
                                            <h6 class="font-medium text-gray-900">Revisión de Tesis</h6>
                                            <p class="text-sm text-gray-600 mt-1">Entrega de correcciones finales</p>
                                        </div>
                                        <span class="text-sm font-medium text-primary bg-primary-50 px-3 py-1 rounded-full">
                                            15 Dic
                                        </span>
                                    </div>
                                </div>

                                <div class="calendar-event" style="border-left-color: #f97316;">
                                    <div class="flex justify-between items-start">
                                        <div>
                                            <h6 class="font-medium text-gray-900">Defensa de Tesis</h6>
                                            <p class="text-sm text-gray-600 mt-1">Presentación final ante el jurado</p>
                                        </div>
                                        <span class="text-sm font-medium text-accent bg-accent-50 px-3 py-1 rounded-full">
                                            20 Dic
                                        </span>
                                    </div>
                                </div>

                                <div class="calendar-event" style="border-left-color: #10b981;">
                                    <div class="flex justify-between items-start">
                                        <div>
                                            <h6 class="font-medium text-gray-900">Entrega Final</h6>
                                            <p class="text-sm text-gray-600 mt-1">Subir versión final al sistema</p>
                                        </div>
                                        <span class="text-sm font-medium text-success bg-success-50 px-3 py-1 rounded-full">
                                            30 Dic
                                        </span>
                                    </div>
                                </div>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
        </div>                   

        <!-- JavaScript -->
        <script>
            // User dropdown functionality
            const userMenuButton = document.getElementById('user-menu-button');
            const userDropdown = document.getElementById('user-dropdown');

            if (userMenuButton && userDropdown) {
                userMenuButton.addEventListener('click', function (e) {
                    e.stopPropagation();
                    userDropdown.classList.toggle('show');
                });

                document.addEventListener('click', function (e) {
                    if (!userMenuButton.contains(e.target) && !userDropdown.contains(e.target)) {
                        userDropdown.classList.remove('show');
                    }
                });
            }

            // Message form handling
            const messageForm = document.getElementById('messageForm');
            if (messageForm) {
                messageForm.addEventListener('submit', function (e) {
                    e.preventDefault();
                    const formData = new FormData(this);

                    fetch(this.action, {
                        method: 'POST',
                        body: formData
                    })
                            .then(response => response.json())
                            .then(data => {
                                if (data.success) {
                                    showNotification('Mensaje enviado correctamente', 'success');
                                    document.getElementById('messageInput').value = '';
                                    setTimeout(() => location.reload(), 1500);
                                } else {
                                    showNotification('Error: ' + data.error, 'error');
                                }
                            })
                            .catch(error => {
                                console.error('Error:', error);
                                showNotification('Error al enviar mensaje', 'error');
                            });
                });
            }

            // Auto-scroll para mensajes
            function scrollToBottom() {
                const messagesContainer = document.getElementById('messages-container');
                if (messagesContainer) {
                    messagesContainer.scrollTop = messagesContainer.scrollHeight;
                }
            }

            scrollToBottom();

            function showNotification(message, type = 'info') {
                const notification = document.createElement('div');
                notification.className = `fixed top-4 right-4 z-50 max-w-sm w-full bg-white border border-gray-200 rounded-lg shadow-lg p-4 transform translate-x-full transition-transform duration-300 ease-in-out`;

                const iconColor = type === 'success' ? 'text-success' :
                        type === 'error' ? 'text-error' : 'text-primary';
                const icon = type === 'success' ? 'M5 13l4 4L19 7' :
                        type === 'error' ? 'M6 18L18 6M6 6l12 12' :
                        'M13 16h-1v-4h-1m1-4h.01M21 12a9 9 0 11-18 0 9 9 0 0118 0z';

                notification.innerHTML = `
                    <div class="flex items-center">
                        <svg class="w-5 h-5 ${iconColor} mr-3" fill="none" stroke="currentColor" viewBox="0 0 24 24">
                            <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="${icon}"/>
                        </svg>
                        <p class="text-sm text-text-primary">${message}</p>
                    </div>
                `;

                document.body.appendChild(notification);

                setTimeout(() => {
                    notification.classList.remove('translate-x-full');
                }, 100);

                setTimeout(() => {
                    notification.classList.add('translate-x-full');
                    setTimeout(() => {
                        if (notification.parentNode) {
                            document.body.removeChild(notification);
                        }
                    }, 300);
                }, 5000);
            }

            // Mostrar notificación de bienvenida
            setTimeout(() => {
                showNotification('¡Bienvenid@ de vuelta, <%= estudiante.getNombre() != null ? estudiante.getNombre() : "Estudiante"%>!', 'info');
            }, 1000);






            // Funciones para manejar modales
            function openModal(modalId) {
                const modal = document.getElementById(modalId);
                if (modal) {
                    modal.classList.add('show');
                    document.body.style.overflow = 'hidden'; // Previene scroll en el fondo

                    // Si es el modal del calendario, inicializarlo
                    if (modalId === 'calendarModal') {
                        initializeCalendar();
                    }

                    // Si es el modal del documento y es un PDF, asegurar que se cargue correctamente
                    if (modalId === 'documentModal') {
                        const iframe = modal.querySelector('.document-iframe');
                        if (iframe) {
                            iframe.src = iframe.src; // Recargar para asegurar visibilidad
                        }
                    }
                }
            }

            function closeModal(modalId) {
                const modal = document.getElementById(modalId);
                if (modal) {
                    modal.classList.remove('show');
                    document.body.style.overflow = 'auto'; // Restaura scroll

                    // Si es el modal del documento con iframe, limpiar
                    if (modalId === 'documentModal') {
                        const iframe = modal.querySelector('.document-iframe');
                        if (iframe) {
                            // No limpiar el src para mantener el documento cargado
                        }
                    }
                }
            }

            // Cerrar modal al hacer clic fuera del contenido
            document.addEventListener('click', function (event) {
                const modals = document.querySelectorAll('.modal.show');
                modals.forEach(modal => {
                    if (event.target === modal) {
                        closeModal(modal.id);
                    }
                });
            });

            // Cerrar modal con tecla Escape
            document.addEventListener('keydown', function (event) {
                if (event.key === 'Escape') {
                    const modals = document.querySelectorAll('.modal.show');
                    modals.forEach(modal => {
                        closeModal(modal.id);
                    });
                }
            });

            // Variables para el calendario
            let currentDate = new Date();
            let currentMonth = currentDate.getMonth();
            let currentYear = currentDate.getFullYear();

            // Inicializar calendario
            function initializeCalendar() {
                renderCalendar();
                updateCalendarEvents();
            }

            // Renderizar calendario
            function renderCalendar() {
                const monthNames = [
                    "Enero", "Febrero", "Marzo", "Abril", "Mayo", "Junio",
                    "Julio", "Agosto", "Septiembre", "Octubre", "Noviembre", "Diciembre"
                ];

                // Actualizar título del mes
                document.getElementById('currentMonth').textContent =
                        `${monthNames[currentMonth]} ${currentYear}`;

                                // Obtener primer día del mes
                                const firstDay = new Date(currentYear, currentMonth, 1);
                                // Obtener último día del mes
                                const lastDay = new Date(currentYear, currentMonth + 1, 0);
                                // Obtener día de la semana del primer día (0 = Domingo, 1 = Lunes, etc.)
                                const firstDayIndex = firstDay.getDay();
                                // Obtener último día del mes
                                const lastDate = lastDay.getDate();
                                // Obtener último día del mes anterior
                                const prevLastDay = new Date(currentYear, currentMonth, 0);
                                const prevLastDate = prevLastDay.getDate();
                                // Obtener primer día del próximo mes
                                const nextDays = 7 - lastDay.getDay() - 1;

                                const calendarDays = document.getElementById('calendarDays');
                                let daysHTML = "";

                                // Días del mes anterior
                                for (let x = firstDayIndex; x > 0; x--) {
                                    const day = prevLastDate - x + 1;
                                    daysHTML += `<div class="calendar-day other-month">${day}</div>`;
                                }

                                // Días del mes actual
                                const today = new Date();
                                for (let i = 1; i <= lastDate; i++) {
                                    let dayClass = "calendar-day";
                                    const date = new Date(currentYear, currentMonth, i);

                                    // Verificar si es hoy
                                    if (i === today.getDate() &&
                                            currentMonth === today.getMonth() &&
                                            currentYear === today.getFullYear()) {
                                        dayClass += " today";
                                    }

                                    // Verificar si tiene eventos (aquí puedes agregar lógica para verificar eventos reales)
                                    const hasEvent = checkIfDateHasEvent(date);
                                    if (hasEvent) {
                                        dayClass += " has-event";
                                    }

                                    daysHTML += `<div class="${dayClass}" onclick="selectDate(${i})">${i}</div>`;
                                }

                                // Días del próximo mes
                                for (let j = 1; j <= nextDays; j++) {
                                    daysHTML += `<div class="calendar-day other-month">${j}</div>`;
                                }

                                calendarDays.innerHTML = daysHTML;
                            }

                            // Cambiar mes
                            function changeMonth(direction) {
                                currentMonth += direction;

                                if (currentMonth < 0) {
                                    currentMonth = 11;
                                    currentYear--;
                                }

                                if (currentMonth > 11) {
                                    currentMonth = 0;
                                    currentYear++;
                                }

                                renderCalendar();
                                updateCalendarEvents();
                            }

                            // Ir a hoy
                            function goToToday() {
                                const today = new Date();
                                currentMonth = today.getMonth();
                                currentYear = today.getFullYear();
                                renderCalendar();
                                updateCalendarEvents();
                            }

                            // Seleccionar fecha
                            function selectDate(day) {
                                const selectedDate = new Date(currentYear, currentMonth, day);
                                const options = {weekday: 'long', year: 'numeric', month: 'long', day: 'numeric'};
                                const formattedDate = selectedDate.toLocaleDateString('es-ES', options);

                                showNotification(`Fecha seleccionada: ${formattedDate}`, 'info');

                                // Aquí podrías agregar lógica para mostrar eventos específicos de esa fecha
                                const events = getEventsForDate(selectedDate);
                                if (events.length > 0) {
                                    console.log('Eventos para esta fecha:', events);
                                }
                            }

                            // Verificar si una fecha tiene eventos
                            function checkIfDateHasEvent(date) {
                                // Aquí puedes agregar lógica para verificar eventos reales
                                // Por ahora, simularemos algunos eventos
                                const eventDates = [
                                    new Date(currentYear, currentMonth, 15), // 15 del mes actual
                                    new Date(currentYear, currentMonth, 20), // 20 del mes actual
                                    new Date(currentYear, currentMonth, 30)  // 30 del mes actual
                                ];

                                return eventDates.some(eventDate =>
                                    eventDate.getDate() === date.getDate() &&
                                            eventDate.getMonth() === date.getMonth() &&
                                            eventDate.getFullYear() === date.getFullYear()
                                );
                            }

                            // Obtener eventos para una fecha específica
                            function getEventsForDate(date) {
                                // Aquí podrías obtener eventos de una base de datos o API
                                // Por ahora, devolvemos eventos simulados
                                const events = [];

                                if (date.getDate() === 15 && date.getMonth() === currentMonth) {
                                    events.push({
                                        title: "Revisión de Tesis",
                                        description: "Entrega de correcciones finales",
                                        type: "primary"
                                    });
                                }

                                if (date.getDate() === 20 && date.getMonth() === currentMonth) {
                                    events.push({
                                        title: "Defensa de Tesis",
                                        description: "Presentación final ante el jurado",
                                        type: "accent"
                                    });
                                }

                                if (date.getDate() === 30 && date.getMonth() === currentMonth) {
                                    events.push({
                                        title: "Entrega Final",
                                        description: "Subir versión final al sistema",
                                        type: "success"
                                    });
                                }

                                return events;
                            }

                            // Actualizar lista de eventos del calendario
                            function updateCalendarEvents() {
                                // Aquí podrías cargar eventos reales del mes actual
                                // Por ahora, mantenemos los eventos estáticos
                            }

        </script>
    </body>
</html>