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
            border-radius: 50%;
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
                    <p class="text-gray-600">Inicia sesión con tu cuenta</p>
                </div>
                
                <!-- Selector de Rol -->
                <div class="mb-6">
                    <label class="block text-sm font-medium text-gray-700 mb-3">Selecciona tu rol:</label>
                    <div class="grid grid-cols-3 gap-2">
                        <button id="role-docente" class="role-btn py-3 rounded-lg border border-gray-200 bg-white text-gray-700 font-medium transition-standard active">
                            <svg class="w-6 h-6 mx-auto mb-1" fill="none" stroke="currentColor" viewBox="0 0 24 24" xmlns="http://www.w3.org/2000/svg">
                                <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M16 7a4 4 0 11-8 0 4 4 0 018 0zM12 14a7 7 0 00-7 7h14a7 7 0 00-7-7z"></path>
                            </svg>
                            Docente
                        </button>
                        <button id="role-estudiante" class="role-btn py-3 rounded-lg border border-gray-200 bg-white text-gray-700 font-medium transition-standard">
                            <svg class="w-6 h-6 mx-auto mb-1" fill="none" stroke="currentColor" viewBox="0 0 24 24" xmlns="http://www.w3.org/2000/svg">
                                <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M12 14l9-5-9-5-9 5 9 5z"></path>
                                <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M12 14l9-5-9-5-9 5 9 5zm0 0l9 5m-9-5v10"></path>
                            </svg>
                            Estudiante
                        </button>
                        <button id="role-administrador" class="role-btn py-3 rounded-lg border border-gray-200 bg-white text-gray-700 font-medium transition-standard">
                            <svg class="w-6 h-6 mx-auto mb-1" fill="none" stroke="currentColor" viewBox="0 0 24 24" xmlns="http://www.w3.org/2000/svg">
                                <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M10.325 4.317c.426-1.756 2.924-1.756 3.35 0a1.724 1.724 0 002.573 1.066c1.543-.94 3.31.826 2.37 2.37a1.724 1.724 0 001.065 2.572c1.756.426 1.756 2.924 0 3.35a1.724 1.724 0 00-1.066 2.573c.94 1.543-.826 3.31-2.37 2.37a1.724 1.724 0 00-2.572 1.065c-.426 1.756-2.924 1.756-3.35 0a1.724 1.724 0 00-2.573-1.066c-1.543.94-3.31-.826-2.37-2.37a1.724 1.724 0 00-1.065-2.572c-1.756-.426-1.756-2.924 0-3.35a1.724 1.724 0 001.066-2.573c-.94-1.543.826-3.31 2.37-2.37.996.608 2.296.07 2.572-1.065z"></path>
                                <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M15 12a3 3 0 11-6 0 3 3 0 016 0z"></path>
                            </svg>
                            Administrador
                        </button>
                    </div>
                </div>
                
                <!-- Formulario de Login -->
                <form id="login-form" class="space-y-4">
                    <div>
                        <label for="username" class="block text-sm font-medium text-gray-700 mb-1">Usuario</label>
                        <input type="text" id="username" class="form-input w-full" placeholder="Ingresa tu usuario" required>
                    </div>
                    
                    <div>
                        <label for="password" class="block text-sm font-medium text-gray-700 mb-1">Contraseña</label>
                        <input type="password" id="password" class="form-input w-full" placeholder="Ingresa tu contraseña" required>
                    </div>
                    
                    <div class="flex items-center justify-between">
                        <div class="flex items-center">
                            <input type="checkbox" id="remember" class="w-4 h-4 text-primary rounded focus:ring-primary border-gray-300">
                            <label for="remember" class="ml-2 text-sm text-gray-600">Recordarme</label>
                        </div>
                        <a href="#" class="text-sm text-primary hover:underline">¿Olvidaste tu contraseña?</a>
                    </div>
                    
                    <button type="submit" id="login-btn" class="btn-primary w-full">Iniciar Sesión</button>
                </form>
                
                <div class="mt-6 text-center">
                    <p class="text-sm text-gray-600">
                        ¿No tienes una cuenta? 
                        <a href="#" class="text-primary font-medium hover:underline">Regístrate</a>
                    </p>
                </div>
            </div>
        </div>
    </div>

    <script>
        document.addEventListener('DOMContentLoaded', function() {
            const roleButtons = document.querySelectorAll('.role-btn');
            const loginBtn = document.getElementById('login-btn');
            let selectedRole = 'docente'; // Valor por defecto
            
            // Manejar la selección de roles
            roleButtons.forEach(button => {
                button.addEventListener('click', function() {
                    // Remover clase activa de todos los botones
                    roleButtons.forEach(btn => {
                        btn.classList.remove('active', 'border-primary', 'bg-primary-50', 'text-primary');
                        btn.classList.add('border-gray-200', 'bg-white', 'text-gray-700');
                    });
                    
                    // Añadir clase activa al botón seleccionado
                    this.classList.remove('border-gray-200', 'bg-white', 'text-gray-700');
                    this.classList.add('active', 'border-primary', 'bg-primary-50', 'text-primary');
                    
                    // Actualizar rol seleccionado
                    selectedRole = this.id.replace('role-', '');
                    
                    // Actualizar texto del botón de login según el rol
                    updateLoginButton();
                });
            });
            
            // Actualizar el texto del botón de login según el rol
            function updateLoginButton() {
                let buttonText = '';
                let buttonClass = '';
                
                switch(selectedRole) {
                    case 'docente':
                        buttonText = 'Acceder como Docente';
                        buttonClass = 'btn-primary';
                        break;
                    case 'estudiante':
                        buttonText = 'Acceder como Estudiante';
                        buttonClass = 'btn-secondary';
                        break;
                    case 'administrador':
                        buttonText = 'Acceder como Administrador';
                        buttonClass = 'btn-accent';
                        break;
                }
                
                // Remover clases anteriores
                loginBtn.classList.remove('btn-primary', 'btn-secondary', 'btn-accent');
                
                // Añadir nueva clase y texto
                loginBtn.classList.add(buttonClass);
                loginBtn.textContent = buttonText;
            }
            
            // Manejar el envío del formulario
            document.getElementById('login-form').addEventListener('submit', function(e) {
                e.preventDefault();
                
                const username = document.getElementById('username').value;
                const password = document.getElementById('password').value;
                const remember = document.getElementById('remember').checked;
                
                // Aquí iría la lógica de autenticación
                console.log(`Iniciando sesión como ${selectedRole}`);
                console.log(`Usuario: ${username}`);
                console.log(`Contraseña: ${password}`);
                console.log(`Recordar: ${remember}`);
                
                // Redireccionar según el rol seleccionado
                redirectByRole(selectedRole);
            });
            
            // Función para redireccionar según el rol
            function redirectByRole(role) {
                let redirectUrl = '';
                
                switch(role) {
                    case 'docente':
                        redirectUrl = 'Docente.jsp';
                        break;
                    case 'estudiante':
                        redirectUrl = 'estudiante.jsp';
                        break;
                    case 'administrador':
                        redirectUrl = 'administrador.jsp';
                        break;
                    default:
                        redirectUrl = 'dashboard.html';
                }
                
                // Redirección a la página correspondiente
                // En un entorno real, esto se haría después de validar las credenciales
                window.location.href = redirectUrl;
            }
            
            // Inicializar el botón de login
            updateLoginButton();
        });
    </script>
</body>
</html>