<!DOCTYPE html>
<html lang="es">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Login - Sistema Académico</title>
    <style>
        /* Estilos CSS proporcionados y modificados */
        @import url('https://fonts.googleapis.com/css2?family=Inter:wght@400;500;600;700&display=swap');
        @import url('https://fonts.googleapis.com/css2?family=Crimson+Text:wght@400;600&display=swap');
        
        * {
            margin: 0;
            padding: 0;
            box-sizing: border-box;
            font-family: 'Inter', sans-serif;
        }
        
        body {
            /* CAMBIA ESTA URL PARA MODIFICAR EL FONDO */
            background: url('proxy-image.png') no-repeat center center fixed;
            background-size: cover;
            min-height: 100vh;
            display: flex;
            align-items: center;
            justify-content: center;
            padding: 1rem;
            position: relative;
        }
        
        /* Overlay oscuro para mejorar legibilidad */
        body::before {
            content: '';
            position: absolute;
            top: 0;
            left: 0;
            right: 0;
            bottom: 0;
            background: rgba(0, 0, 0, 0.4);
            z-index: 0;
        }
        
        .main-container {
            display: flex;
            width: 100%;
            max-width: 1400px;
            position: relative;
            z-index: 2;
            gap: 2rem;
            align-items: center;
            justify-content: center;
        }
        
        .presentation-section {
            color: white;
            max-width: 600px;
            padding: 2rem;
            flex: 1;
        }
        
        .logo-container {
            margin-bottom: 2rem;
        }
        
        .logo {
            width: 160px;
            height: 160px;
            border-radius: 60%;
            object-fit: cover;
            border: 4px solid rgba(35, 105, 235, 0.8);
            box-shadow: 0 0 25px rgba(59, 130, 246, 0.5);
            animation: float 6s ease-in-out infinite, pulse 2s infinite alternate;
        }
        
        @keyframes float {
            0% {
                transform: translateY(0px);
            }
            50% {
                transform: translateY(-15px);
            }
            100% {
                transform: translateY(0px);
            }
        }
        
        @keyframes pulse {
            0% {
                box-shadow: 0 0 25px rgba(59, 130, 246, 0.5);
            }
            100% {
                box-shadow: 0 0 35px rgba(59, 130, 246, 0.8);
            }
        }
        
        .presentation-title {
            font-size: 3rem;
            font-weight: 700;
            margin-bottom: 1.5rem;
            text-shadow: 2px 2px 4px rgba(0, 0, 0, 0.5);
            letter-spacing: 1px;
            line-height: 1.2;
        }
        
        .presentation-text {
            font-size: 1.2rem;
            line-height: 1.6;
            margin-bottom: 2rem;
            text-shadow: 1px 1px 2px rgba(0, 0, 0, 0.5);
        }
        
        .features-list {
            list-style: none;
            margin-top: 2rem;
        }
        
        .features-list li {
            margin-bottom: 1.2rem;
            display: flex;
            align-items: center;
            font-size: 1.1rem;
        }
        
        .features-list li svg {
            margin-right: 1rem;
            color: #c7d2fe;
        }
        
        .login-container {
            width: 100%;
            max-width: 450px;
            flex: 1;
        }
        
        .card {
            background-color: rgba(255, 255, 255, 0.15);
            border-radius: 1.5rem;
            padding: 2.5rem;
            box-shadow: 0 15px 35px rgba(0, 0, 0, 0.3);
            backdrop-filter: blur(15px);
            border: 1px solid rgba(255, 255, 255, 0.2);
        }
        
        .text-center {
            text-align: center;
        }
        
        .mb-8 {
            margin-bottom: 2rem;
        }
        
        .text-3xl {
            font-size: 1.875rem;
            line-height: 2.25rem;
        }
        
        .font-bold {
            font-weight: 700;
        }
        
        .text-primary {
            color: #3b82f6;
        }
        
        .mb-2 {
            margin-bottom: 0.5rem;
        }
        
        .text-gray-600 {
            color: #e5e7eb;
        }
        
        .mb-6 {
            margin-bottom: 1.5rem;
        }
        
        .block {
            display: block;
        }
        
        .text-sm {
            font-size: 0.875rem;
            line-height: 1.25rem;
        }
        
        .font-medium {
            font-weight: 500;
        }
        
        .text-gray-700 {
            color: #f9fafb;
        }
        
        .mb-3 {
            margin-bottom: 0.75rem;
        }
        
        .grid {
            display: grid;
        }
        
        .grid-cols-3 {
            grid-template-columns: repeat(3, minmax(0, 1fr));
        }
        
        .gap-2 {
            gap: 0.5rem;
        }
        
        .role-btn {
            display: flex;
            flex-direction: column;
            align-items: center;
            padding: 0.75rem;
            border-radius: 0.5rem;
            border: 1px solid rgba(255, 255, 255, 0.3);
            background-color: rgba(255, 255, 255, 0.2);
            color: #f9fafb;
            font-weight: 500;
            transition: all 0.2s;
            cursor: pointer;
        }
        
        .role-btn:hover {
            border-color: #3b82f6;
            background-color: rgba(59, 130, 246, 0.3);
            color: #f9fafb;
        }
        
        .role-btn.active {
            border-color: #3b82f6;
            background-color: rgba(59, 130, 246, 0.3);
            color: #f9fafb;
        }
        
        .w-6 {
            width: 1.5rem;
        }
        
        .h-6 {
            height: 1.5rem;
        }
        
        .mx-auto {
            margin-left: auto;
            margin-right: auto;
        }
        
        .mb-1 {
            margin-bottom: 0.25rem;
        }
        
        .space-y-4 > * + * {
            margin-top: 1rem;
        }
        
        .form-input {
            width: 100%;
            padding: 0.75rem;
            border: 1px solid rgba(255, 255, 255, 0.3);
            border-radius: 0.375rem;
            font-size: 0.875rem;
            background-color: rgba(255, 255, 255, 0.1);
            color: white;
        }
        
        .form-input::placeholder {
            color: rgba(255, 255, 255, 0.7);
        }
        
        .form-input:focus {
            outline: none;
            border-color: #3b82f6;
            box-shadow: 0 0 0 3px rgba(59, 130, 246, 0.2);
            background-color: rgba(255, 255, 255, 0.15);
        }
        
        .flex {
            display: flex;
        }
        
        .items-center {
            align-items: center;
        }
        
        .justify-between {
            justify-content: space-between;
        }
        
        .w-4 {
            width: 1rem;
        }
        
        .h-4 {
            height: 1rem;
        }
        
        .rounded {
            border-radius: 0.25rem;
        }
        
        .focus\:ring-primary:focus {
            --tw-ring-color: rgba(59, 130, 246, 0.5);
        }
        
        .border-gray-300 {
            border-color: #d1d5db;
        }
        
        .ml-2 {
            margin-left: 0.5rem;
        }
        
        .hover\:underline:hover {
            text-decoration: underline;
        }
        
        .btn-primary {
            background-color: #3b82f6;
            color: white;
            font-weight: 500;
            padding: 0.75rem 1rem;
            border-radius: 0.5rem;
            border: none;
            cursor: pointer;
            transition: background-color 0.2s;
            width: 100%;
        }
        
        .btn-primary:hover {
            background-color: #2563eb;
        }
        
        .btn-secondary {
            background-color: rgba(107, 114, 128, 0.7);
            color: white;
            font-weight: 500;
            padding: 0.75rem 1rem;
            border-radius: 0.5rem;
            border: none;
            cursor: pointer;
            transition: background-color 0.2s;
            width: 100%;
        }
        
        .btn-secondary:hover {
            background-color: rgba(75, 85, 99, 0.8);
        }
        
        .btn-accent {
            background-color: rgba(139, 92, 246, 0.7);
            color: white;
            font-weight: 500;
            padding: 0.75rem 1rem;
            border-radius: 0.5rem;
            border: none;
            cursor: pointer;
            transition: background-color 0.2s;
            width: 100%;
        }
        
        .btn-accent:hover {
            background-color: rgba(124, 58, 237, 0.8);
        }
        
        .mt-6 {
            margin-top: 1.5rem;
        }
        
        .transition-standard {
            transition: all 0.2s;
        }
        
        .border-primary {
            border-color: #3b82f6;
        }
        
        .bg-primary-50 {
            background-color: rgba(59, 130, 246, 0.3);
        }
        
        .text-primary {
            color: #3b82f6;
        }
        
        .border-gray-200 {
            border-color: rgba(255, 255, 255, 0.3);
        }
        
        .bg-white {
            background-color: rgba(255, 255, 255, 0.2);
        }
        
        .text-gray-700 {
            color: #f9fafb;
        }
        
        /* Estilos para checkbox en modo vidrio */
        input[type="checkbox"] {
            background-color: rgba(255, 255, 255, 0.2);
            border: 1px solid rgba(255, 255, 255, 0.3);
        }
        
        input[type="checkbox"]:checked {
            background-color: #3b82f6;
            border-color: #3b82f6;
        }
        
        /* Responsive */
        @media (max-width: 1200px) {
            .main-container {
                max-width: 1100px;
                gap: 1.5rem;
            }
            
            .presentation-title {
                font-size: 2.5rem;
            }
            
            .presentation-text {
                font-size: 1.1rem;
            }
        }
        
        @media (max-width: 1024px) {
            .main-container {
                flex-direction: column;
                gap: 2rem;
            }
            
            .presentation-section {
                text-align: center;
                max-width: 800px;
            }
            
            .features-list li {
                justify-content: center;
            }
            
            .login-container {
                max-width: 500px;
            }
        }
        
        @media (max-width: 768px) {
            .logo {
                width: 140px;
                height: 140px;
            }
            
            .presentation-title {
                font-size: 2.2rem;
            }
            
            .presentation-text {
                font-size: 1.1rem;
            }
            
            .card {
                padding: 2rem;
            }
            
            .features-list li {
                font-size: 1rem;
            }
        }
        
        @media (max-width: 640px) {
            .presentation-title {
                font-size: 2rem;
            }
            
            .presentation-text {
                font-size: 1rem;
            }
            
            .logo {
                width: 120px;
                height: 120px;
            }
        }
        
        @media (max-width: 480px) {
            body {
                padding: 0.5rem;
            }
            
            .card {
                padding: 1.5rem;
            }
            
            .grid-cols-3 {
                grid-template-columns: 1fr;
                gap: 0.75rem;
            }
            
            .presentation-section {
                padding: 1rem;
            }
            
            .logo {
                width: 100px;
                height: 100px;
            }
            
            .presentation-title {
                font-size: 1.8rem;
            }
        }
            .spinner {
            display: inline-block;
            width: 20px;
            height: 20px;
            border: 3px solid rgba(255,255,255,.3);
            border-radius: 50%;
            border-top-color: #fff;
            animation: spin 1s ease-in-out infinite;
            margin-left: 10px;
        }
        
        @keyframes spin {
            to { transform: rotate(360deg); }
        }
        
        .hidden {
            display: none !important;
        }
        
        .alert {
            padding: 12px;
            border-radius: 8px;
            margin-top: 15px;
            text-align: center;
            font-size: 14px;
        }
        
        .alert-error {
            background-color: rgba(239, 68, 68, 0.2);
            border: 1px solid rgba(239, 68, 68, 0.5);
            color: #fecaca;
        }
        
        .alert-success {
            background-color: rgba(34, 197, 94, 0.2);
            border: 1px solid rgba(34, 197, 94, 0.5);
            color: #bbf7d0;
        }
    </style>
</head>
<body>
    <div class="main-container">
        <!-- Presentación con Logo (izquierda) -->
        <div class="presentation-section">
            <div class="logo-container">
                <img src="upla.png" alt="Logo del Sistema Académico" class="logo">
            </div>
            <h1 class="presentation-title">Sistema Académico Integral</h1>
            <p class="presentation-text">
                Bienvenido a nuestra plataforma académica integral. Accede a herramientas avanzadas para estudiantes, docentes y administradores, diseñadas para optimizar el proceso de enseñanza y aprendizaje.
            </p>
            
            <ul class="features-list">
                <li>
                    <svg class="w-6 h-6" fill="none" stroke="currentColor" viewBox="0 0 24 24" xmlns="http://www.w3.org/2000/svg">
                        <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M9 12l2 2 4-4m6 2a9 9 0 11-18 0 9 9 0 0118 0z"></path>
                    </svg>
                    Gestión académica simplificada
                </li>
                <li>
                    <svg class="w-6 h-6" fill="none" stroke="currentColor" viewBox="0 0 24 24" xmlns="http://www.w3.org/2000/svg">
                        <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M9 12l2 2 4-4m6 2a9 9 0 11-18 0 9 9 0 0118 0z"></path>
                    </svg>
                    Comunicación en tiempo real
                </li>
                <li>
                    <svg class="w-6 h-6" fill="none" stroke="currentColor" viewBox="0 0 24 24" xmlns="http://www.w3.org/2000/svg">
                        <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M9 12l2 2 4-4m6 2a9 9 0 11-18 0 9 9 0 0118 0z"></path>
                    </svg>
                    Recursos educativos innovadores
                </li>
            </ul>
        </div>
        
       <!-- Panel de Login (derecha) -->
        <div class="login-container">
            <!-- Tarjeta de Login -->
            <div class="card">
                <div class="text-center mb-8">
                    <h2 class="text-3xl font-bold text-primary mb-2">Acceso al Sistema</h2>
                    <p class="text-gray-600">Inicia sesión con tu cuenta de correo institucional</p>
                </div>
              
                
                <!-- Formulario de Login -->
                <form id="login-form" class="space-y-4" onsubmit="event.preventDefault(); login();">
                    <div>
                        <label for="email" class="block text-sm font-medium text-gray-700 mb-1">Email Institucional</label>
                        <input type="email" id="email" name="email" class="form-input w-full" 
                               placeholder="ejemplo@universidad.es" required
                               oninput="detectarRolPorEmail(this.value)">
                    </div>
                    
                    <div>
                        <label for="password" class="block text-sm font-medium text-gray-700 mb-1">Contraseña</label>
                        <input type="password" id="password" name="password" class="form-input w-full" 
                               placeholder="Ingresa tu contraseña" required>
                    </div>
                    
                    <div class="flex items-center justify-between">
                        <div class="flex items-center">
                            <input type="checkbox" id="remember" class="w-4 h-4 text-primary rounded focus:ring-primary border-gray-300">
                            <label for="remember" class="ml-2 text-sm text-gray-600">Recordarme</label>
                        </div>
                        <a href="#" class="text-sm text-primary hover:underline">¿Olvidaste tu contraseña?</a>
                    </div>
                    
                    <!-- Botón con spinner -->
                    <button type="submit" id="login-btn" class="btn-primary w-full flex justify-center items-center">
                        <span id="btn-text">Iniciar Sesión</span>
                        <span id="spinner" class="hidden spinner ml-2"></span>
                    </button>
                    
                    <!-- Mensajes de error/éxito -->
                    <div id="error-message" class="hidden alert alert-error"></div>
                    <div id="success-message" class="hidden alert alert-success"></div>
                </form>
                
                <div class="mt-6 text-center">
                    <p class="text-sm text-gray-600">
                        ¿No tienes una cuenta? 
                        <a href="#" class="text-primary font-medium hover:underline">Contacta al administrador</a>
                    </p>
                </div>
            </div>
        </div>
    </div>
    

   <script>
// Elementos del DOM
let emailInput, passwordInput, loginBtn, btnText, spinner;
let errorMsg, successMsg;

// Inicialización principal
document.addEventListener('DOMContentLoaded', function() {
    console.log('=== PÁGINA CARGADA - INICIALIZANDO ===');
    
    // Inicializar elementos
    emailInput = document.getElementById('email');
    passwordInput = document.getElementById('password');
    loginBtn = document.getElementById('login-btn');
    btnText = document.getElementById('btn-text');
    spinner = document.getElementById('spinner');
    
    errorMsg = document.getElementById('error-message');
    successMsg = document.getElementById('success-message');
    
    // Cargar email guardado si existe
    const emailGuardado = localStorage.getItem('email_guardado');
    if (emailGuardado) {
        emailInput.value = emailGuardado;
        document.getElementById('remember').checked = true;
        predecirRolPorEmail(emailGuardado);
    }
    
    // Detectar rol mientras se escribe
    if (emailInput) {
        emailInput.addEventListener('input', function(e) {
            predecirRolPorEmail(e.target.value);
        });
    }
    
    // Permitir login con Enter
    if (passwordInput) {
        passwordInput.addEventListener('keypress', function(e) {
            if (e.key === 'Enter') {
                iniciarSesion();
            }
        });
    }
    
    // Asignar evento al botón de login
    if (loginBtn) {
        loginBtn.addEventListener('click', iniciarSesion);
    }
    
    // Crear botón de prueba de conexión
    crearBotonPrueba();
    
    console.log('=== INICIALIZACIÓN COMPLETADA ===');
});

// Función para predecir rol por email (solo visual)
function predecirRolPorEmail(email) {
    if (!email) {
        ocultarRoleDisplay();
        return;
    }
    
    const roleDisplay = document.getElementById('role-display');
    const roleText = document.getElementById('role-text');
    
    if (!roleDisplay || !roleText) return;
    
    email = email.toLowerCase();
    
    if (email.includes('@')) {
        if (email === 'admin@universidad.es') {
            roleDisplay.classList.remove('hidden');
            roleDisplay.style.backgroundColor = 'rgba(59, 130, 246, 0.2)';
            roleDisplay.style.border = '1px solid rgba(59, 130, 246, 0.5)';
        } else if (email.startsWith('d.') || email.includes('docente') || email.includes('prof.')) {
            roleDisplay.classList.remove('hidden');
            roleDisplay.style.backgroundColor = 'rgba(139, 92, 246, 0.2)';
            roleDisplay.style.border = '1px solid rgba(139, 92, 246, 0.5)';
        } else if (email.includes('@universidad.es')) {
            roleDisplay.classList.remove('hidden');
            roleDisplay.style.backgroundColor = 'rgba(34, 197, 94, 0.2)';
            roleDisplay.style.border = '1px solid rgba(34, 197, 94, 0.5)';
        } else {
            ocultarRoleDisplay();
        }
    } else {
        ocultarRoleDisplay();
    }
}

function ocultarRoleDisplay() {
    const roleDisplay = document.getElementById('role-display');
    if (roleDisplay) {
        roleDisplay.classList.add('hidden');
    }
}

// Función para mostrar mensajes
function mostrarError(mensaje) {
    if (errorMsg) {
        errorMsg.textContent = mensaje;
        errorMsg.classList.remove('hidden');
        if (successMsg) successMsg.classList.add('hidden');
    } else {
        console.error('Error:', mensaje);
    }
}

function mostrarExito(mensaje) {
    if (successMsg) {
        successMsg.textContent = mensaje;
        successMsg.classList.remove('hidden');
        if (errorMsg) errorMsg.classList.add('hidden');
    } else {
        console.log('Éxito:', mensaje);
    }
}

function ocultarMensajes() {
    if (errorMsg) errorMsg.classList.add('hidden');
    if (successMsg) successMsg.classList.add('hidden');
}

// Función para validar formato de email
function validarEmail(email) {
    const emailRegex = /^[^\s@]+@[^\s@]+\.[^\s@]+$/;
    return emailRegex.test(email);
}

// Función PRINCIPAL de inicio de sesión
async function iniciarSesion() {
    console.log('=== INICIANDO PROCESO DE LOGIN ===');
    
    // Obtener valores actuales
    const email = emailInput ? emailInput.value.trim() : '';
    const password = passwordInput ? passwordInput.value : '';
    
    console.log('Datos ingresados:', { 
        email, 
        password: password ? '[PROVIDED]' : 'empty' 
    });
    
    // Validaciones básicas
    if (!email || !password) {
        mostrarError('Por favor, completa todos los campos');
        return;
    }
    
    if (!validarEmail(email)) {
        mostrarError('Por favor, ingresa un email válido');
        return;
    }
    
    // Ocultar mensajes previos
    ocultarMensajes();
    
    // Activar estado de carga
    if (loginBtn) loginBtn.disabled = true;
    if (btnText) btnText.textContent = 'Verificando...';
    if (spinner) spinner.classList.remove('hidden');
    
    try {
        // Enviar datos de login
        console.log('Enviando credenciales...');
        
        const formData = new URLSearchParams();
        formData.append('email', email);
        formData.append('password', password);
        
        const response = await fetch('login', {
            method: 'POST',
            headers: {
                'Content-Type': 'application/x-www-form-urlencoded; charset=UTF-8'
            },
            body: formData.toString()
        });
        
        console.log('Respuesta recibida:', {
            status: response.status,
            statusText: response.statusText,
            ok: response.ok
        });
        
        // Leer respuesta
        const responseText = await response.text();
        console.log('Respuesta del servidor:', responseText.substring(0, 200));
        
        // Verificar si la respuesta está vacía
        if (!responseText || responseText.trim() === '') {
            throw new Error('El servidor devolvió una respuesta vacía');
        }
        
        // Intentar parsear como JSON
        let result;
        try {
            result = JSON.parse(responseText);
            console.log('JSON parseado:', result);
        } catch (jsonError) {
            console.error('Error parseando JSON:', jsonError);
            console.error('Texto recibido:', responseText);
            
            if (responseText.includes('<html') || responseText.includes('<!DOCTYPE')) {
                if (responseText.includes('HTTP Status 500')) {
                    mostrarError('Error interno del servidor (500)');
                } else if (responseText.includes('HTTP Status 404')) {
                    mostrarError('Servlet no encontrado (404)');
                } else {
                    mostrarError('Error de configuración del servidor');
                }
            } else {
                mostrarError('Formato de respuesta inválido');
            }
            return;
        }
        
        // Procesar resultado
        if (result.success) {
            console.log('? Login exitoso!');
            console.log('Redireccionando a:', result.redirectUrl);
            
            mostrarExito(`¡Login exitoso! Redirigiendo...`);
            
            // Guardar email si está marcado "Recordarme"
            const rememberCheckbox = document.getElementById('remember');
            if (rememberCheckbox && rememberCheckbox.checked) {
                localStorage.setItem('email_guardado', email);
            } else {
                localStorage.removeItem('email_guardado');
            }
            
            // Redirigir después de 1 segundo
            setTimeout(() => {
                if (result.redirectUrl) {
                    window.location.href = result.redirectUrl;
                } else {
                    mostrarError('Error: No se especificó página de destino');
                }
            }, 1000);
            
        } else {
            console.log('? Login fallido:', result.message);
            mostrarError(result.message || 'Error desconocido');
        }
        
    } catch (error) {
        console.error('? ERROR en proceso de login:', error);
        
        // Mensajes específicos según el tipo de error
        if (error.message.includes('Failed to fetch')) {
            mostrarError('No se pudo conectar al servidor. Verifica que Tomcat esté ejecutándose.');
        } else if (error.message.includes('respuesta vacía')) {
            mostrarError('El servidor no respondió. Revisa la consola de Tomcat.');
        } else if (error.message.includes('NetworkError')) {
            mostrarError('Error de red. Verifica tu conexión a internet.');
        } else {
            mostrarError('Error: ' + error.message);
        }
        
    } finally {
        // Restaurar estado del botón
        if (loginBtn) loginBtn.disabled = false;
        if (btnText) btnText.textContent = 'Iniciar Sesión';
        if (spinner) spinner.classList.add('hidden');
        console.log('=== PROCESO DE LOGIN FINALIZADO ===\n');
    }
}

// Función para probar la base de datos directamente
async function testDatabaseConnection() {
    console.log('=== PRUEBA DE CONEXIÓN A BASE DE DATOS ===');
    
    try {
        const response = await fetch('test', { method: 'GET' });
        
        if (!response.ok) {
            throw new Error(`HTTP ${response.status}: ${response.statusText}`);
        }
        
        const text = await response.text();
        alert('Respuesta del servidor:\n\n' + text);
        
    } catch (error) {
        console.error('Error en prueba de conexión:', error);
        alert('Error en prueba de conexión:\n' + error.message);
    }
}

// Función para crear botón de prueba
function crearBotonPrueba() {
    if (document.getElementById('debug-btn')) return;
    
    const testBtn = document.createElement('button');
    testBtn.id = 'debug-btn';
    testBtn.textContent = '? Probar Conexión';
    testBtn.style.cssText = `
        position: fixed;
        bottom: 20px;
        right: 20px;
        z-index: 9999;
        padding: 10px 15px;
        background: #007bff;
        color: white;
        border: none;
        border-radius: 5px;
        cursor: pointer;
        font-size: 12px;
        box-shadow: 0 2px 5px rgba(0,0,0,0.2);
    `;
    testBtn.title = 'Click para probar conexión con el servidor';
    testBtn.onclick = testDatabaseConnection;
    
    document.body.appendChild(testBtn);
}

// Función para verificar sesión existente
async function verificarSesion() {
    console.log('Verificando sesión activa...');
    
    try {
        const response = await fetch('checkSession');
        if (response.ok) {
            const data = await response.json();
            if (data.loggedIn && data.redirectUrl) {
                console.log('Sesión activa encontrada, redirigiendo...');
                window.location.href = data.redirectUrl;
            }
        }
    } catch (error) {
        console.log('No hay sesión activa o error:', error.message);
    }
}

// Verificar sesión después de un breve delay
setTimeout(verificarSesion, 1000);
</script>
</body>
</html>