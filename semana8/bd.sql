-- Crear la base de datos
CREATE DATABASE IF NOT EXISTS studymind_db;
USE studymind_db;

-- Tabla de Roles
CREATE TABLE rol (
    id_rol INT PRIMARY KEY AUTO_INCREMENT,
    nombre_rol VARCHAR(50) NOT NULL UNIQUE,
    descripcion TEXT
);

-- Tabla de Usuarios
CREATE TABLE usuario (
    id_usuario INT PRIMARY KEY AUTO_INCREMENT,
    nombre VARCHAR(100) NOT NULL,
    apellido VARCHAR(100) NOT NULL,
    email VARCHAR(150) NOT NULL UNIQUE,
    username VARCHAR(50) NOT NULL UNIQUE,
    password VARCHAR(255) NOT NULL,
    carrera VARCHAR(150),
    universidad VARCHAR(150),
    id_rol INT NOT NULL,
    fecha_registro DATETIME DEFAULT CURRENT_TIMESTAMP,
    estado ENUM('activo', 'inactivo', 'suspendido') DEFAULT 'activo',
    FOREIGN KEY (id_rol) REFERENCES rol(id_rol)
);

-- Tabla de Grupos de Estudio
CREATE TABLE grupo_estudio (
    id_grupo INT PRIMARY KEY AUTO_INCREMENT,
    nombre_grupo VARCHAR(150) NOT NULL,
    descripcion TEXT,
    curso_tema VARCHAR(150) NOT NULL,
    id_creador INT NOT NULL,
    fecha_creacion DATETIME DEFAULT CURRENT_TIMESTAMP,
    estado ENUM('activo', 'inactivo', 'reportado') DEFAULT 'activo',
    max_miembros INT DEFAULT 20,
    FOREIGN KEY (id_creador) REFERENCES usuario(id_usuario)
);

-- Tabla de Miembros de Grupo
CREATE TABLE miembro_grupo (
    id_miembro INT PRIMARY KEY AUTO_INCREMENT,
    id_grupo INT NOT NULL,
    id_usuario INT NOT NULL,
    fecha_union DATETIME DEFAULT CURRENT_TIMESTAMP,
    puntos_participacion INT DEFAULT 0,
    rol_grupo ENUM('miembro', 'moderador') DEFAULT 'miembro',
    FOREIGN KEY (id_grupo) REFERENCES grupo_estudio(id_grupo) ON DELETE CASCADE,
    FOREIGN KEY (id_usuario) REFERENCES usuario(id_usuario) ON DELETE CASCADE,
    UNIQUE KEY unique_miembro (id_grupo, id_usuario)
);

-- Tabla de Materiales
CREATE TABLE material (
    id_material INT PRIMARY KEY AUTO_INCREMENT,
    id_grupo INT NOT NULL,
    id_usuario INT NOT NULL,
    titulo VARCHAR(200) NOT NULL,
    descripcion TEXT,
    tipo_material ENUM('apunte', 'resumen', 'ejercicio', 'video', 'enlace', 'otro') NOT NULL,
    archivo_url VARCHAR(500),
    fecha_subida DATETIME DEFAULT CURRENT_TIMESTAMP,
    FOREIGN KEY (id_grupo) REFERENCES grupo_estudio(id_grupo) ON DELETE CASCADE,
    FOREIGN KEY (id_usuario) REFERENCES usuario(id_usuario)
);

-- Tabla de Tareas/Exámenes
CREATE TABLE tarea (
    id_tarea INT PRIMARY KEY AUTO_INCREMENT,
    id_grupo INT NOT NULL,
    titulo VARCHAR(200) NOT NULL,
    descripcion TEXT,
    fecha_limite DATETIME NOT NULL,
    tipo ENUM('tarea', 'examen', 'proyecto', 'repaso') NOT NULL,
    fecha_creacion DATETIME DEFAULT CURRENT_TIMESTAMP,
    FOREIGN KEY (id_grupo) REFERENCES grupo_estudio(id_grupo) ON DELETE CASCADE
);

-- Tabla de Mensajes/Chat
CREATE TABLE mensaje (
    id_mensaje INT PRIMARY KEY AUTO_INCREMENT,
    id_grupo INT NOT NULL,
    id_usuario INT NOT NULL,
    contenido TEXT NOT NULL,
    fecha_envio DATETIME DEFAULT CURRENT_TIMESTAMP,
    FOREIGN KEY (id_grupo) REFERENCES grupo_estudio(id_grupo) ON DELETE CASCADE,
    FOREIGN KEY (id_usuario) REFERENCES usuario(id_usuario)
);

-- Tabla de Reportes (para que el admin supervise)
CREATE TABLE reporte (
    id_reporte INT PRIMARY KEY AUTO_INCREMENT,
    id_grupo INT,
    id_usuario_reportado INT,
    id_usuario_reporta INT NOT NULL,
    tipo_reporte ENUM('contenido_inapropiado', 'spam', 'acoso', 'otro') NOT NULL,
    descripcion TEXT NOT NULL,
    estado ENUM('pendiente', 'en_revision', 'resuelto', 'rechazado') DEFAULT 'pendiente',
    fecha_reporte DATETIME DEFAULT CURRENT_TIMESTAMP,
    fecha_resolucion DATETIME,
    accion_tomada TEXT,
    FOREIGN KEY (id_grupo) REFERENCES grupo_estudio(id_grupo),
    FOREIGN KEY (id_usuario_reportado) REFERENCES usuario(id_usuario),
    FOREIGN KEY (id_usuario_reporta) REFERENCES usuario(id_usuario)
);

-- Tabla de Estado de Ánimo (para bienestar emocional)
CREATE TABLE estado_animo (
    id_estado INT PRIMARY KEY AUTO_INCREMENT,
    id_usuario INT NOT NULL,
    estado ENUM('feliz', 'estresado', 'motivado', 'cansado', 'ansioso') NOT NULL,
    comentario TEXT,
    fecha_registro DATETIME DEFAULT CURRENT_TIMESTAMP,
    FOREIGN KEY (id_usuario) REFERENCES usuario(id_usuario)
);

-- Tabla de Ejercicios de Relajación
CREATE TABLE ejercicio_relajacion (
    id_ejercicio INT PRIMARY KEY AUTO_INCREMENT,
    titulo VARCHAR(150) NOT NULL,
    descripcion TEXT NOT NULL,
    duracion_minutos INT,
    tipo ENUM('respiracion', 'meditacion', 'estiramiento', 'mindfulness') NOT NULL,
    instrucciones TEXT NOT NULL
);

-- Tabla de Publicaciones del Admin
CREATE TABLE publicacion (
    id_publicacion INT PRIMARY KEY AUTO_INCREMENT,
    titulo VARCHAR(200) NOT NULL,
    contenido TEXT NOT NULL,
    fecha_publicacion DATETIME DEFAULT CURRENT_TIMESTAMP,
    activa BOOLEAN DEFAULT TRUE
);

-- ============================================
-- INSERTAR DATOS INICIALES
-- ============================================

-- Insertar roles
INSERT INTO rol (nombre_rol, descripcion) VALUES 
('administrador', 'Administrador del sistema con acceso completo'),
('usuario', 'Usuario estándar de la plataforma');

-- Insertar usuario administrador (contraseña: admin123)
INSERT INTO usuario (nombre, apellido, email, username, password, carrera, universidad, id_rol) VALUES
('Admin', 'Sistema', 'admin@studymind.com', 'admin', 'admin123', 'N/A', 'StudyMind', 1);

-- Insertar usuarios de ejemplo
INSERT INTO usuario (nombre, apellido, email, username, password, carrera, universidad, id_rol) VALUES
('Juan', 'Pérez', 'juan.perez@mail.com', 'juanp', '123456', 'Ingeniería de Sistemas', 'Universidad Nacional', 2),
('Ana', 'Torres', 'ana.torres@mail.com', 'anat', '123456', 'Medicina', 'Universidad Nacional', 2),
('Carlos', 'Mendoza', 'carlos.m@mail.com', 'carlosm', '123456', 'Derecho', 'Universidad Central', 2);

-- Insertar ejercicios de relajación
INSERT INTO ejercicio_relajacion (titulo, descripcion, duracion_minutos, tipo, instrucciones) VALUES
('Respiración 4-7-8', 'Técnica de respiración para reducir ansiedad', 5, 'respiracion', 
 '1. Inhala por la nariz durante 4 segundos\n2. Mantén la respiración por 7 segundos\n3. Exhala por la boca durante 8 segundos\n4. Repite 4 veces'),
('Meditación Guiada', 'Ejercicio de meditación para claridad mental', 10, 'meditacion',
 '1. Siéntate cómodamente\n2. Cierra los ojos\n3. Enfócate en tu respiración\n4. Deja pasar los pensamientos sin juzgarlos'),
('Estiramiento de Cuello', 'Ejercicios para aliviar tensión', 3, 'estiramiento',
 '1. Inclina la cabeza hacia un lado\n2. Mantén 10 segundos\n3. Cambia de lado\n4. Repite 3 veces');

-- Insertar grupos de estudio de ejemplo
INSERT INTO grupo_estudio (nombre_grupo, descripcion, curso_tema, id_creador) VALUES
('Cálculo I - Grupo A', 'Grupo de estudio para preparar parciales', 'Cálculo I', 2),
('Anatomía Humana', 'Repaso semanal de anatomía', 'Anatomía', 3);

-- Insertar miembros en grupos
INSERT INTO miembro_grupo (id_grupo, id_usuario, puntos_participacion) VALUES
(1, 2, 50),
(1, 4, 30),
(2, 3, 80);

-- Insertar tareas de ejemplo
INSERT INTO tarea (id_grupo, titulo, descripcion, fecha_limite, tipo) VALUES
(1, 'Parcial de Derivadas', 'Estudiar capítulos 3 y 4', '2025-10-25 10:00:00', 'examen'),
(2, 'Trabajo de Sistema Digestivo', 'Entregar resumen completo', '2025-10-30 23:59:00', 'proyecto');

-- Insertar estados de ánimo de ejemplo
INSERT INTO estado_animo (id_usuario, estado, comentario) VALUES
(2, 'feliz', 'Buen día de estudio'),
(3, 'estresado', 'Mucho trabajo');