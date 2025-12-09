-- Eliminar y recrear la base de datos

DROP DATABASE IF EXISTS thesisreview\_portal;

CREATE DATABASE thesisreview\_portal;

USE thesisreview\_portal;



-- Tabla de Carreras

CREATE TABLE carreras (

&nbsp;   id INT AUTO\_INCREMENT PRIMARY KEY,

&nbsp;   nombre VARCHAR(100) NOT NULL,

&nbsp;   facultad VARCHAR(100) NOT NULL,

&nbsp;   coordinador VARCHAR(100),

&nbsp;   duracion\_semestres INT DEFAULT 10,

&nbsp;   activa BOOLEAN DEFAULT TRUE,

&nbsp;   fecha\_creacion TIMESTAMP DEFAULT CURRENT\_TIMESTAMP,

&nbsp;   fecha\_actualizacion TIMESTAMP DEFAULT CURRENT\_TIMESTAMP ON UPDATE CURRENT\_TIMESTAMP

);



-- Tabla de Usuarios

CREATE TABLE usuarios (

&nbsp;   id INT AUTO\_INCREMENT PRIMARY KEY,

&nbsp;   nombre VARCHAR(50) NOT NULL,

&nbsp;   apellido VARCHAR(50) NOT NULL,

&nbsp;   email VARCHAR(100) UNIQUE NOT NULL,

&nbsp;   password VARCHAR(255) NOT NULL,

&nbsp;   tipo ENUM('ESTUDIANTE', 'DOCENTE', 'ADMINISTRADOR') NOT NULL,

&nbsp;   estado ENUM('ACTIVO', 'INACTIVO', 'SOBRECARGADO') DEFAULT 'ACTIVO',

&nbsp;   avatar VARCHAR(255),

&nbsp;   fecha\_registro TIMESTAMP DEFAULT CURRENT\_TIMESTAMP,

&nbsp;   ultimo\_acceso TIMESTAMP NULL,

&nbsp;   fecha\_actualizacion TIMESTAMP DEFAULT CURRENT\_TIMESTAMP ON UPDATE CURRENT\_TIMESTAMP

);







-- Tabla de Estudiantes

CREATE TABLE estudiantes (

&nbsp;   id INT PRIMARY KEY,

&nbsp;   codigo\_estudiante VARCHAR(20) UNIQUE NOT NULL,

&nbsp;   carrera\_id INT NOT NULL,

&nbsp;   estado\_tesis ENUM('SIN\_ENVIAR', 'EN\_REVISION', 'APROBADA', 'RECHAZADA') DEFAULT 'SIN\_ENVIAR',

&nbsp;   fecha\_inicio DATE,

&nbsp;   fecha\_estimada\_graduacion DATE,

&nbsp;   FOREIGN KEY (id) REFERENCES usuarios(id) ON DELETE CASCADE,

&nbsp;   FOREIGN KEY (carrera\_id) REFERENCES carreras(id)

);



-- Tabla de Docentes

CREATE TABLE docentes (

&nbsp;   id INT PRIMARY KEY,

&nbsp;   especialidad VARCHAR(100) NOT NULL,

&nbsp;   titulo ENUM('Prof.', 'Dr.', 'Dra.', 'Mg.') DEFAULT 'Prof.',

&nbsp;   tesis\_asignadas INT DEFAULT 0,

&nbsp;   capacidad\_maxima INT DEFAULT 5,

&nbsp;   carga\_trabajo DECIMAL(5,2) DEFAULT 0.00,

&nbsp;   activo BOOLEAN DEFAULT TRUE,

&nbsp;   FOREIGN KEY (id) REFERENCES usuarios(id) ON DELETE CASCADE

);







-- Insertar carreras

INSERT INTO carreras (nombre, facultad, coordinador, duracion\_semestres) VALUES

('Ingeniería Industrial', 'Facultad de Ingeniería', 'Dr. Carlos Mendoza', 10),

('Medicina', 'Facultad de Medicina', 'Dra. Ana López', 12);



-- Insertar usuario administrador

INSERT INTO usuarios (nombre, apellido, email, password, tipo, estado) VALUES

('Admin', 'García', 'admin@universidad.es', 'admin123', 'ADMINISTRADOR', 'ACTIVO');



-- Insertar docentes con emails que empiezan con "d." o contienen "docente"

INSERT INTO usuarios (nombre, apellido, email, password, tipo, estado) VALUES

('Miguel', 'Torres', 'd.miguel.torres@universidad.es', 'docente123', 'DOCENTE', 'ACTIVO'),

('Carmen', 'López', 'docente.carmen@universidad.es', 'docente123', 'DOCENTE', 'ACTIVO'),

('Roberto', 'Silva', 'prof.roberto@universidad.es', 'docente123', 'DOCENTE', 'ACTIVO');



INSERT INTO docentes (id, especialidad, titulo, capacidad\_maxima) VALUES

(2, 'Ingeniería', 'Prof.', 5),

(3, 'Medicina', 'Dra.', 4),

(4, 'Psicología', 'Dr.', 6);



-- Insertar estudiantes con emails normales

INSERT INTO usuarios (nombre, apellido, email, password, tipo, estado) VALUES

('María', 'González', 'maria.gonzalez@universidad.es', 'estudiante123', 'ESTUDIANTE', 'ACTIVO'),

('Carlos', 'Ruiz', 'carlos.ruiz@universidad.es', 'estudiante123', 'ESTUDIANTE', 'ACTIVO'),

('Ana', 'Martínez', 'ana.martinez@universidad.es', 'estudiante123', 'ESTUDIANTE', 'ACTIVO');



INSERT INTO estudiantes (id, codigo\_estudiante, carrera\_id, estado\_tesis, fecha\_inicio) VALUES

(5, '2023001', 1, 'EN\_REVISION', '2023-03-15'),

(6, '2023002', 2, 'APROBADA', '2023-03-15'),

(7, '2023003', 1, 'SIN\_ENVIAR', '2023-03-15');



UPDATE usuarios SET 

&nbsp; password = 'admin123',

&nbsp; estado = 'ACTIVO'

WHERE email = 'admin@universidad.es';



-- ============================================

-- 1. TABLAS FALTANTES PARA EL SISTEMA DE TESIS

-- ============================================



-- Tabla de Tesis (núcleo del sistema)

CREATE TABLE IF NOT EXISTS tesis (

&nbsp;   id INT AUTO\_INCREMENT PRIMARY KEY,

&nbsp;   estudiante\_id INT NOT NULL,

&nbsp;   titulo VARCHAR(500) NOT NULL,

&nbsp;   resumen TEXT,

&nbsp;   palabras\_clave VARCHAR(255),

&nbsp;   estado ENUM(

&nbsp;       'BORRADOR', 

&nbsp;       'SIN\_ENVIAR', 

&nbsp;       'PENDIENTE\_REVISION', 

&nbsp;       'EN\_REVISION', 

&nbsp;       'CORRECCIONES\_PENDIENTES',

&nbsp;       'APROBADA', 

&nbsp;       'RECHAZADA', 

&nbsp;       'ARCHIVADA'

&nbsp;   ) DEFAULT 'BORRADOR',

&nbsp;   fecha\_creacion TIMESTAMP DEFAULT CURRENT\_TIMESTAMP,

&nbsp;   fecha\_envio TIMESTAMP NULL,

&nbsp;   fecha\_aprobacion TIMESTAMP NULL,

&nbsp;   archivo\_principal VARCHAR(255),

&nbsp;   formato\_archivo ENUM('PDF', 'DOCX', 'DOC'),

&nbsp;   tamano\_archivo BIGINT,

&nbsp;   num\_paginas INT,

&nbsp;   nivel\_estudio ENUM('PREGRADO', 'MAESTRIA', 'DOCTORADO') DEFAULT 'PREGRADO',

&nbsp;   semestre INT,

&nbsp;   ano\_academico YEAR,

&nbsp;   nota\_final DECIMAL(4,2),

&nbsp;   observaciones TEXT,

&nbsp;   FOREIGN KEY (estudiante\_id) REFERENCES estudiantes(id) ON DELETE CASCADE

);



-- Tabla de Versiones de Tesis (historial)

CREATE TABLE IF NOT EXISTS versiones\_tesis (

&nbsp;   id INT AUTO\_INCREMENT PRIMARY KEY,

&nbsp;   tesis\_id INT NOT NULL,

&nbsp;   version\_num INT NOT NULL,

&nbsp;   archivo VARCHAR(255) NOT NULL,

&nbsp;   fecha\_subida TIMESTAMP DEFAULT CURRENT\_TIMESTAMP,

&nbsp;   tamano BIGINT,

&nbsp;   comentario\_version VARCHAR(500),

&nbsp;   usuario\_subida INT NOT NULL,

&nbsp;   checksum\_md5 VARCHAR(32),

&nbsp;   FOREIGN KEY (tesis\_id) REFERENCES tesis(id) ON DELETE CASCADE,

&nbsp;   FOREIGN KEY (usuario\_subida) REFERENCES usuarios(id),

&nbsp;   UNIQUE KEY (tesis\_id, version\_num)

);



-- Tabla de Asignaciones de Evaluación

CREATE TABLE IF NOT EXISTS asignaciones\_evaluacion (

&nbsp;   id INT AUTO\_INCREMENT PRIMARY KEY,

&nbsp;   tesis\_id INT NOT NULL,

&nbsp;   docente\_id INT NOT NULL,

&nbsp;   admin\_asignador INT NOT NULL,

&nbsp;   fecha\_asignacion TIMESTAMP DEFAULT CURRENT\_TIMESTAMP,

&nbsp;   fecha\_limite DATE,

&nbsp;   estado ENUM(

&nbsp;       'PENDIENTE', 

&nbsp;       'EN\_PROGRESO', 

&nbsp;       'COMPLETADA', 

&nbsp;       'VENCIDA', 

&nbsp;       'CANCELADA'

&nbsp;   ) DEFAULT 'PENDIENTE',

&nbsp;   prioridad ENUM('BAJA', 'MEDIA', 'ALTA') DEFAULT 'MEDIA',

&nbsp;   instrucciones\_especiales TEXT,

&nbsp;   fecha\_completada TIMESTAMP NULL,

&nbsp;   FOREIGN KEY (tesis\_id) REFERENCES tesis(id) ON DELETE CASCADE,

&nbsp;   FOREIGN KEY (docente\_id) REFERENCES docentes(id),

&nbsp;   FOREIGN KEY (admin\_asignador) REFERENCES usuarios(id),

&nbsp;   UNIQUE KEY (tesis\_id, docente\_id)

);



-- Tabla de Criterios de Evaluación

CREATE TABLE IF NOT EXISTS criterios\_evaluacion (

&nbsp;   id INT AUTO\_INCREMENT PRIMARY KEY,

&nbsp;   nombre VARCHAR(200) NOT NULL,

&nbsp;   descripcion TEXT,

&nbsp;   peso DECIMAL(3,2) DEFAULT 1.00,

&nbsp;   max\_puntuacion INT DEFAULT 10,

&nbsp;   categoria ENUM(

&nbsp;       'CONTENIDO', 

&nbsp;       'METODOLOGIA', 

&nbsp;       'ESTRUCTURA', 

&nbsp;       'REDACCION', 

&nbsp;       'REFERENCIAS'

&nbsp;   ),

&nbsp;   activo BOOLEAN DEFAULT TRUE

);



-- Tabla de Evaluaciones

CREATE TABLE IF NOT EXISTS evaluaciones (

&nbsp;   id INT AUTO\_INCREMENT PRIMARY KEY,

&nbsp;   asignacion\_id INT NOT NULL,

&nbsp;   fecha\_evaluacion TIMESTAMP DEFAULT CURRENT\_TIMESTAMP,

&nbsp;   puntuacion\_total DECIMAL(4,2),

&nbsp;   recomendacion ENUM('APROBADO', 'APROBADO\_CON\_MODIFICACIONES', 'RECHAZADO'),

&nbsp;   comentarios\_generales TEXT,

&nbsp;   fortalezas TEXT,

&nbsp;   debilidades TEXT,

&nbsp;   sugerencias TEXT,

&nbsp;   fecha\_revision DATE,

&nbsp;   archivo\_evaluacion VARCHAR(255),

&nbsp;   estado ENUM('BORRADOR', 'FINALIZADA') DEFAULT 'BORRADOR',

&nbsp;   FOREIGN KEY (asignacion\_id) REFERENCES asignaciones\_evaluacion(id) ON DELETE CASCADE

);



-- Tabla de Puntuaciones por Criterio

CREATE TABLE IF NOT EXISTS puntuaciones\_criterios (

&nbsp;   id INT AUTO\_INCREMENT PRIMARY KEY,

&nbsp;   evaluacion\_id INT NOT NULL,

&nbsp;   criterio\_id INT NOT NULL,

&nbsp;   puntuacion DECIMAL(4,2),

&nbsp;   comentario TEXT,

&nbsp;   FOREIGN KEY (evaluacion\_id) REFERENCES evaluaciones(id) ON DELETE CASCADE,

&nbsp;   FOREIGN KEY (criterio\_id) REFERENCES criterios\_evaluacion(id),

&nbsp;   UNIQUE KEY (evaluacion\_id, criterio\_id)

);



-- Tabla de Actividades (Log del Sistema)

CREATE TABLE IF NOT EXISTS actividades (

&nbsp;   id INT AUTO\_INCREMENT PRIMARY KEY,

&nbsp;   usuario\_id INT NOT NULL,

&nbsp;   tipo\_accion ENUM(

&nbsp;       'LOGIN', 

&nbsp;       'LOGOUT', 

&nbsp;       'SUBIDA\_TESIS', 

&nbsp;       'ASIGNACION', 

&nbsp;       'EVALUACION', 

&nbsp;       'CREACION\_USUARIO',

&nbsp;       'MODIFICACION\_TESIS', 

&nbsp;       'DESCARGA\_ARCHIVO'

&nbsp;   ),

&nbsp;   descripcion VARCHAR(500),

&nbsp;   ip\_address VARCHAR(45),

&nbsp;   user\_agent TEXT,

&nbsp;   fecha\_hora TIMESTAMP DEFAULT CURRENT\_TIMESTAMP,

&nbsp;   detalles JSON,

&nbsp;   FOREIGN KEY (usuario\_id) REFERENCES usuarios(id)

);



-- Tabla de Notificaciones

CREATE TABLE IF NOT EXISTS notificaciones (

&nbsp;   id INT AUTO\_INCREMENT PRIMARY KEY,

&nbsp;   usuario\_destino INT NOT NULL,

&nbsp;   titulo VARCHAR(200) NOT NULL,

&nbsp;   mensaje TEXT,

&nbsp;   tipo ENUM(

&nbsp;       'ASIGNACION', 

&nbsp;       'RECORDATORIO', 

&nbsp;       'EVALUACION\_COMPLETADA',

&nbsp;       'PLAZO\_VENCIDO', 

&nbsp;       'SISTEMA', 

&nbsp;       'MENSAJE'

&nbsp;   ),

&nbsp;   leida BOOLEAN DEFAULT FALSE,

&nbsp;   fecha\_creacion TIMESTAMP DEFAULT CURRENT\_TIMESTAMP,

&nbsp;   fecha\_lectura TIMESTAMP NULL,

&nbsp;   url\_accion VARCHAR(500),

&nbsp;   FOREIGN KEY (usuario\_destino) REFERENCES usuarios(id)

);



-- Tabla de Configuración del Sistema

CREATE TABLE IF NOT EXISTS configuracion\_sistema (

&nbsp;   id INT AUTO\_INCREMENT PRIMARY KEY,

&nbsp;   clave VARCHAR(100) UNIQUE NOT NULL,

&nbsp;   valor TEXT,

&nbsp;   tipo ENUM('TEXTO', 'NUMERO', 'BOOLEANO', 'JSON', 'FECHA'),

&nbsp;   categoria VARCHAR(50),

&nbsp;   descripcion TEXT,

&nbsp;   editable BOOLEAN DEFAULT TRUE

);



-- ============================================

-- TABLAS PARA EL SISTEMA DE ASESORÍAS

-- ============================================



-- Tabla de Asesorías (Relación Docente-Estudiante)

CREATE TABLE IF NOT EXISTS asesorias (

&nbsp;   id INT AUTO\_INCREMENT PRIMARY KEY,

&nbsp;   docente\_id INT NOT NULL,

&nbsp;   estudiante\_id INT NOT NULL,

&nbsp;   tesis\_id INT NULL,

&nbsp;   titulo\_asesoria VARCHAR(500) NOT NULL,

&nbsp;   descripcion TEXT,

&nbsp;   fecha\_inicio DATE NOT NULL,

&nbsp;   fecha\_fin\_estimada DATE,

&nbsp;   fecha\_fin\_real DATE NULL,

&nbsp;   estado ENUM(

&nbsp;       'ACTIVA',

&nbsp;       'EN\_PAUSA', 

&nbsp;       'COMPLETADA', 

&nbsp;       'CANCELADA', 

&nbsp;       'SUSPENDIDA'

&nbsp;   ) DEFAULT 'ACTIVA',

&nbsp;   frecuencia\_reunion ENUM(

&nbsp;       'SEMANAL', 

&nbsp;       'QUINCENAL', 

&nbsp;       'MENSUAL', 

&nbsp;       'POR\_AVANCE', 

&nbsp;       'PERSONALIZADA'

&nbsp;   ) DEFAULT 'SEMANAL',

&nbsp;   duracion\_estimada\_horas INT DEFAULT 40,

&nbsp;   horas\_acumuladas INT DEFAULT 0,

&nbsp;   nivel\_asesoria ENUM(

&nbsp;       'PREGRADO', 

&nbsp;       'MAESTRIA', 

&nbsp;       'DOCTORADO', 

&nbsp;       'INVESTIGACION'

&nbsp;   ) DEFAULT 'PREGRADO',

&nbsp;   objetivo\_principal TEXT,

&nbsp;   area\_conocimiento VARCHAR(100),

&nbsp;   tema\_investigacion VARCHAR(500),

&nbsp;   archivos\_adjuntos JSON,

&nbsp;   calificacion\_estudiante DECIMAL(3,2) NULL,

&nbsp;   feedback\_estudiante TEXT,

&nbsp;   activa BOOLEAN DEFAULT TRUE,

&nbsp;   fecha\_creacion TIMESTAMP DEFAULT CURRENT\_TIMESTAMP,

&nbsp;   fecha\_actualizacion TIMESTAMP DEFAULT CURRENT\_TIMESTAMP ON UPDATE CURRENT\_TIMESTAMP,

&nbsp;   FOREIGN KEY (docente\_id) REFERENCES docentes(id) ON DELETE CASCADE,

&nbsp;   FOREIGN KEY (estudiante\_id) REFERENCES estudiantes(id) ON DELETE CASCADE,

&nbsp;   FOREIGN KEY (tesis\_id) REFERENCES tesis(id) ON DELETE SET NULL,

&nbsp;   UNIQUE KEY unique\_asesoria\_activa (docente\_id, estudiante\_id, tesis\_id, activa),

&nbsp;   INDEX idx\_estado (estado),

&nbsp;   INDEX idx\_docente (docente\_id, estado),

&nbsp;   INDEX idx\_estudiante (estudiante\_id, estado)

);



-- Tabla de Sesiones de Asesoría

CREATE TABLE IF NOT EXISTS sesiones\_asesoria (

&nbsp;   id INT AUTO\_INCREMENT PRIMARY KEY,

&nbsp;   asesoria\_id INT NOT NULL,

&nbsp;   titulo\_sesion VARCHAR(200) NOT NULL,

&nbsp;   descripcion TEXT,

&nbsp;   fecha\_sesion DATE NOT NULL,

&nbsp;   hora\_inicio TIME NOT NULL,

&nbsp;   hora\_fin TIME NOT NULL,

&nbsp;   duracion\_minutos INT NOT NULL,

&nbsp;   modalidad ENUM(

&nbsp;       'PRESENCIAL', 

&nbsp;       'VIRTUAL', 

&nbsp;       'HIBRIDA', 

&nbsp;       'TELEFONICA'

&nbsp;   ) DEFAULT 'VIRTUAL',

&nbsp;   plataforma VARCHAR(100) NULL,

&nbsp;   enlace\_reunion VARCHAR(500) NULL,

&nbsp;   lugar VARCHAR(200) NULL,

&nbsp;   estado ENUM(

&nbsp;       'PROGRAMADA', 

&nbsp;       'CONFIRMADA', 

&nbsp;       'EN\_CURSO', 

&nbsp;       'COMPLETADA', 

&nbsp;       'CANCELADA', 

&nbsp;       'REPROGRAMADA', 

&nbsp;       'AUSENTE'

&nbsp;   ) DEFAULT 'PROGRAMADA',

&nbsp;   temas\_tratados TEXT,

&nbsp;   acuerdos TEXT,

&nbsp;   observaciones TEXT,

&nbsp;   evidencias JSON,

&nbsp;   asistencia\_confirmada BOOLEAN DEFAULT FALSE,

&nbsp;   retroalimentacion\_docente TEXT,

&nbsp;   retroalimentacion\_estudiante TEXT,

&nbsp;   archivos\_compartidos JSON,

&nbsp;   proxima\_tareas TEXT,

&nbsp;   fecha\_proxima\_sesion DATE NULL,

&nbsp;   creador\_id INT NOT NULL,

&nbsp;   fecha\_creacion TIMESTAMP DEFAULT CURRENT\_TIMESTAMP,

&nbsp;   fecha\_actualizacion TIMESTAMP DEFAULT CURRENT\_TIMESTAMP ON UPDATE CURRENT\_TIMESTAMP,

&nbsp;   FOREIGN KEY (asesoria\_id) REFERENCES asesorias(id) ON DELETE CASCADE,

&nbsp;   FOREIGN KEY (creador\_id) REFERENCES usuarios(id),

&nbsp;   INDEX idx\_fecha\_sesion (fecha\_sesion),

&nbsp;   INDEX idx\_estado\_sesion (estado),

&nbsp;   INDEX idx\_asesoria\_fecha (asesoria\_id, fecha\_sesion)

);



-- Tabla de Tareas/Compromisos de Asesoría

CREATE TABLE IF NOT EXISTS tareas\_asesoria (

&nbsp;   id INT AUTO\_INCREMENT PRIMARY KEY,

&nbsp;   asesoria\_id INT NOT NULL,

&nbsp;   sesion\_id INT NULL,

&nbsp;   titulo VARCHAR(200) NOT NULL,

&nbsp;   descripcion TEXT,

&nbsp;   asignado\_a ENUM('ESTUDIANTE', 'DOCENTE', 'AMBOS') DEFAULT 'ESTUDIANTE',

&nbsp;   estado ENUM(

&nbsp;       'PENDIENTE', 

&nbsp;       'EN\_PROGRESO', 

&nbsp;       'COMPLETADA', 

&nbsp;       'RETRASADA', 

&nbsp;       'CANCELADA'

&nbsp;   ) DEFAULT 'PENDIENTE',

&nbsp;   prioridad ENUM('BAJA', 'MEDIA', 'ALTA', 'URGENTE') DEFAULT 'MEDIA',

&nbsp;   fecha\_asignacion DATE NOT NULL,

&nbsp;   fecha\_limite DATE,

&nbsp;   fecha\_completada DATE NULL,

&nbsp;   porcentaje\_avance INT DEFAULT 0,

&nbsp;   categoria ENUM(

&nbsp;       'LECTURA', 

&nbsp;       'ESCRITURA', 

&nbsp;       'INVESTIGACION', 

&nbsp;       'REVISION', 

&nbsp;       'CORRECCION', 

&nbsp;       'ENTREGA', 

&nbsp;       'OTRO'

&nbsp;   ) DEFAULT 'ESCRITURA',

&nbsp;   evidencias\_completado JSON,

&nbsp;   comentarios TEXT,

&nbsp;   recordatorio\_enviado BOOLEAN DEFAULT FALSE,

&nbsp;   fecha\_creacion TIMESTAMP DEFAULT CURRENT\_TIMESTAMP,

&nbsp;   fecha\_actualizacion TIMESTAMP DEFAULT CURRENT\_TIMESTAMP ON UPDATE CURRENT\_TIMESTAMP,

&nbsp;   FOREIGN KEY (asesoria\_id) REFERENCES asesorias(id) ON DELETE CASCADE,

&nbsp;   FOREIGN KEY (sesion\_id) REFERENCES sesiones\_asesoria(id) ON DELETE SET NULL,

&nbsp;   INDEX idx\_estado\_tarea (estado, fecha\_limite),

&nbsp;   INDEX idx\_asignado (asesoria\_id, asignado\_a)

);



-- Tabla de Recursos de Asesoría

CREATE TABLE IF NOT EXISTS recursos\_asesoria (

&nbsp;   id INT AUTO\_INCREMENT PRIMARY KEY,

&nbsp;   docente\_id INT NOT NULL,

&nbsp;   titulo VARCHAR(200) NOT NULL,

&nbsp;   descripcion TEXT,

&nbsp;   tipo\_recurso ENUM(

&nbsp;       'PLANTILLA', 

&nbsp;       'GUIA', 

&nbsp;       'EJEMPLO', 

&nbsp;       'RUBRICA', 

&nbsp;       'FORMATO', 

&nbsp;       'PRESENTACION', 

&nbsp;       'ARTICULO', 

&nbsp;       'LIBRO', 

&nbsp;       'VIDEO'

&nbsp;   ) DEFAULT 'PLANTILLA',

&nbsp;   categoria ENUM(

&nbsp;       'METODOLOGIA', 

&nbsp;       'ESTADISTICA', 

&nbsp;       'REDACCION', 

&nbsp;       'CITACION', 

&nbsp;       'ETICA', 

&nbsp;       'PRESENTACION', 

&nbsp;       'GENERAL'

&nbsp;   ) DEFAULT 'GENERAL',

&nbsp;   nivel ENUM('PREGRADO', 'MAESTRIA', 'DOCTORADO', 'TODOS') DEFAULT 'TODOS',

&nbsp;   archivo\_url VARCHAR(500),

&nbsp;   nombre\_archivo VARCHAR(255),

&nbsp;   tamano\_archivo BIGINT,

&nbsp;   formato\_archivo VARCHAR(10),

&nbsp;   visibilidad ENUM('PUBLICO', 'PRIVADO', 'COMPARTIDO') DEFAULT 'PRIVADO',

&nbsp;   veces\_descargado INT DEFAULT 0,

&nbsp;   veces\_compartido INT DEFAULT 0,

&nbsp;   etiquetas JSON,

&nbsp;   activo BOOLEAN DEFAULT TRUE,

&nbsp;   fecha\_creacion TIMESTAMP DEFAULT CURRENT\_TIMESTAMP,

&nbsp;   fecha\_actualizacion TIMESTAMP DEFAULT CURRENT\_TIMESTAMP ON UPDATE CURRENT\_TIMESTAMP,

&nbsp;   FOREIGN KEY (docente\_id) REFERENCES docentes(id) ON DELETE CASCADE,

&nbsp;   INDEX idx\_categoria (categoria),

&nbsp;   INDEX idx\_tipo (tipo\_recurso)

);



-- Tabla de Compartir Recursos con Estudiantes

CREATE TABLE IF NOT EXISTS recursos\_compartidos (

&nbsp;   id INT AUTO\_INCREMENT PRIMARY KEY,

&nbsp;   recurso\_id INT NOT NULL,

&nbsp;   asesoria\_id INT NOT NULL,

&nbsp;   docente\_id INT NOT NULL,

&nbsp;   estudiante\_id INT NOT NULL,

&nbsp;   fecha\_compartido TIMESTAMP DEFAULT CURRENT\_TIMESTAMP,

&nbsp;   comentario\_compartido TEXT,

&nbsp;   visto BOOLEAN DEFAULT FALSE,

&nbsp;   fecha\_visto TIMESTAMP NULL,

&nbsp;   descargado BOOLEAN DEFAULT FALSE,

&nbsp;   fecha\_descargado TIMESTAMP NULL,

&nbsp;   FOREIGN KEY (recurso\_id) REFERENCES recursos\_asesoria(id) ON DELETE CASCADE,

&nbsp;   FOREIGN KEY (asesoria\_id) REFERENCES asesorias(id) ON DELETE CASCADE,

&nbsp;   FOREIGN KEY (docente\_id) REFERENCES docentes(id),

&nbsp;   FOREIGN KEY (estudiante\_id) REFERENCES estudiantes(id),

&nbsp;   UNIQUE KEY (recurso\_id, asesoria\_id, estudiante\_id)

);



-- Tabla de Avances de Asesoría

CREATE TABLE IF NOT EXISTS avances\_asesoria (

&nbsp;   id INT AUTO\_INCREMENT PRIMARY KEY,

&nbsp;   asesoria\_id INT NOT NULL,

&nbsp;   fecha\_reporte DATE NOT NULL,

&nbsp;   periodo\_reporte ENUM(

&nbsp;       'SEMANAL', 

&nbsp;       'MENSUAL', 

&nbsp;       'TRIMESTRAL', 

&nbsp;       'PERSONALIZADO'

&nbsp;   ) DEFAULT 'MENSUAL',

&nbsp;   avance\_capitulos VARCHAR(500),

&nbsp;   avance\_porcentaje INT,

&nbsp;   actividades\_realizadas TEXT,

&nbsp;   dificultades\_encontradas TEXT,

&nbsp;   logros\_obtenidos TEXT,

&nbsp;   objetivos\_siguiente\_periodo TEXT,

&nbsp;   archivos\_evidencia JSON,

&nbsp;   retroalimentacion\_docente TEXT,

&nbsp;   aprobado BOOLEAN DEFAULT FALSE,

&nbsp;   fecha\_aprobacion DATE NULL,

&nbsp;   reportado\_por ENUM('ESTUDIANTE', 'DOCENTE') DEFAULT 'ESTUDIANTE',

&nbsp;   fecha\_creacion TIMESTAMP DEFAULT CURRENT\_TIMESTAMP,

&nbsp;   fecha\_actualizacion TIMESTAMP DEFAULT CURRENT\_TIMESTAMP ON UPDATE CURRENT\_TIMESTAMP,

&nbsp;   FOREIGN KEY (asesoria\_id) REFERENCES asesorias(id) ON DELETE CASCADE,

&nbsp;   INDEX idx\_fecha\_reporte (fecha\_reporte),

&nbsp;   INDEX idx\_asesoria\_periodo (asesoria\_id, periodo\_reporte)

);



-- Tabla de Evaluaciones de Asesoría

CREATE TABLE IF NOT EXISTS evaluaciones\_asesoria (

&nbsp;   id INT AUTO\_INCREMENT PRIMARY KEY,

&nbsp;   asesoria\_id INT NOT NULL,

&nbsp;   evaluador\_id INT NOT NULL,

&nbsp;   tipo\_evaluacion ENUM('ESTUDIANTE\_A\_DOCENTE', 'DOCENTE\_A\_ESTUDIANTE', 'AUTOEVALUACION') DEFAULT 'ESTUDIANTE\_A\_DOCENTE',

&nbsp;   fecha\_evaluacion DATE NOT NULL,

&nbsp;   calificacion\_general DECIMAL(3,2),

&nbsp;   comentarios\_generales TEXT,

&nbsp;   criterios JSON,

&nbsp;   fortalezas TEXT,

&nbsp;   areas\_mejora TEXT,

&nbsp;   recomendaciones TEXT,

&nbsp;   anonima BOOLEAN DEFAULT FALSE,

&nbsp;   completada BOOLEAN DEFAULT FALSE,

&nbsp;   fecha\_completada TIMESTAMP NULL,

&nbsp;   FOREIGN KEY (asesoria\_id) REFERENCES asesorias(id) ON DELETE CASCADE,

&nbsp;   FOREIGN KEY (evaluador\_id) REFERENCES usuarios(id),

&nbsp;   UNIQUE KEY unique\_evaluacion (asesoria\_id, evaluador\_id, tipo\_evaluacion)

);





-- ============================================

-- 2. DATOS INICIALES NECESARIOS

-- ============================================



-- Insertar criterios de evaluación por defecto

INSERT INTO criterios\_evaluacion (nombre, descripcion, peso, max\_puntuacion, categoria) VALUES

('Originalidad', 'Grado de novedad y contribución al campo', 1.2, 10, 'CONTENIDO'),

('Rigor Metodológico', 'Adecuación y solidez de la metodología', 1.3, 10, 'METODOLOGIA'),

('Estructura y Organización', 'Coherencia y organización del documento', 1.0, 10, 'ESTRUCTURA'),

('Calidad de Redacción', 'Claridad, precisión y corrección lingüística', 0.9, 10, 'REDACCION'),

('Referencias Bibliográficas', 'Actualidad y pertinencia de las referencias', 0.8, 10, 'REFERENCIAS'),

('Análisis de Resultados', 'Profundidad y validez del análisis', 1.1, 10, 'CONTENIDO');



-- Insertar configuraciones del sistema

INSERT INTO configuracion\_sistema (clave, valor, tipo, categoria, descripcion) VALUES

('MAX\_TESIS\_DOCENTE', '5', 'NUMERO', 'LIMITES', 'Máximo de tesis que puede evaluar un docente'),

('MAX\_TAMANO\_ARCHIVO', '52428800', 'NUMERO', 'ARCHIVOS', 'Tamaño máximo de archivo en bytes (50MB)'),

('FORMATOS\_PERMITIDOS', 'pdf,docx', 'TEXTO', 'ARCHIVOS', 'Formatos de archivo permitidos'),

('DIAS\_EVALUACION', '30', 'NUMERO', 'EVALUACION', 'Días por defecto para evaluación'),

('NOMBRE\_UNIVERSIDAD', 'ThesisReview University', 'TEXTO', 'GENERAL', 'Nombre de la institución'),

('EMAIL\_SOPORTE', 'soporte@thesisreview.edu', 'TEXTO', 'GENERAL', 'Email de soporte'),

('NOTIFICAR\_VENCIMIENTOS', 'true', 'BOOLEANO', 'NOTIFICACIONES', 'Notificar cuando se venzan plazos'),

('DIAS\_RECORDATORIO', '3', 'NUMERO', 'NOTIFICACIONES', 'Días de anticipación para recordatorios');



-- Insertar tesis de ejemplo

INSERT INTO tesis (estudiante\_id, titulo, resumen, palabras\_clave, estado, archivo\_principal, formato\_archivo, nivel\_estudio, semestre, ano\_academico) VALUES

(5, 'Optimización de Procesos Industriales en Manufactura', 'Estudio sobre la mejora de eficiencia en líneas de producción industrial', 'optimización, procesos, manufactura, eficiencia', 'EN\_REVISION', 'tesis\_2023001.pdf', 'PDF', 'PREGRADO', 10, 2025),

(6, 'Análisis de Datos en Sistemas de Salud Digital', 'Implementación de big data para mejorar diagnósticos médicos', 'salud digital, big data, diagnóstico, inteligencia artificial', 'SIN\_ENVIAR', NULL, NULL, 'PREGRADO', 12, 2025),

(7, 'Impacto Psicológico en Terapias Virtuales', 'Estudio del efecto de terapias en línea en pacientes con ansiedad', 'psicología, terapias virtuales, ansiedad, salud mental', 'SIN\_ENVIAR', NULL, NULL, 'PREGRADO', 8, 2025);

-- Insertar versiones de tesis de ejemplo

INSERT INTO versiones\_tesis (tesis\_id, version\_num, archivo, tamano, comentario\_version, usuario\_subida) VALUES

(1, 1, 'tesis\_v1\_borrador.pdf', 2200000, 'Primer borrador', 5),

(1, 2, 'tesis\_v2\_final.pdf', 2400000, 'Versión final para revisión', 5);



-- Insertar asignaciones de ejemplo

INSERT INTO asignaciones\_evaluacion (tesis\_id, docente\_id, admin\_asignador, fecha\_limite, estado, prioridad) VALUES

(1, 2, 1, DATE\_ADD(CURDATE(), INTERVAL 30 DAY), 'EN\_PROGRESO', 'MEDIA');



-- Insertar evaluación de ejemplo

INSERT INTO evaluaciones (asignacion\_id, puntuacion\_total, recomendacion, comentarios\_generales, estado) VALUES

(1, 85.50, 'APROBADO\_CON\_MODIFICACIONES', 'Excelente trabajo, requiere algunas correcciones menores en la metodología', 'FINALIZADA');



-- Insertar puntuaciones de ejemplo

INSERT INTO puntuaciones\_criterios (evaluacion\_id, criterio\_id, puntuacion, comentario) VALUES

(1, 1, 9.0, 'Muy original en su planteamiento'),

(1, 2, 8.5, 'Metodología sólida pero mejorable'),

(1, 3, 8.0, 'Estructura clara y lógica');



-- Insertar actividad de ejemplo

INSERT INTO actividades (usuario\_id, tipo\_accion, descripcion, ip\_address, detalles) VALUES

(1, 'LOGIN', 'Inicio de sesión del administrador', '192.168.1.100', '{"navegador": "Chrome", "sistema": "Windows 10"}'),

(5, 'SUBIDA\_TESIS', 'Subida de tesis: Optimización de Procesos Industriales', '192.168.1.101', '{"tesis\_id": 1, "version": 2}');



-- Insertar notificación de ejemplo

INSERT INTO notificaciones (usuario\_destino, titulo, mensaje, tipo, url\_accion) VALUES

(2, 'Nueva tesis asignada', 'Se te ha asignado la tesis "Optimización de Procesos Industriales"', 'ASIGNACION', '/docente/tesis/1'),

(5, 'Tesis en revisión', 'Tu tesis ha sido asignada para revisión al Prof. Miguel Torres', 'ASIGNACION', '/estudiante/tesis/1');





-- ============================================

-- 3. DATOS INICIALES PARA EL SISTEMA DE ASESORÍAS

-- ============================================



-- Insertar asesorías (relacionadas con tesis existentes)

INSERT INTO asesorias (

&nbsp;   docente\_id, 

&nbsp;   estudiante\_id, 

&nbsp;   tesis\_id, 

&nbsp;   titulo\_asesoria, 

&nbsp;   descripcion, 

&nbsp;   fecha\_inicio, 

&nbsp;   estado, 

&nbsp;   frecuencia\_reunion,

&nbsp;   nivel\_asesoria,

&nbsp;   tema\_investigacion,

&nbsp;   horas\_acumuladas

) VALUES

-- Asesoría activa para María González (tesis 1)

(2, 5, 1, 'Asesoría Tesis - Optimización de Procesos Industriales', 

&nbsp;'Asesoramiento integral para el desarrollo de tesis de pregrado en Ingeniería Industrial sobre optimización de procesos de manufactura utilizando metodologías Lean Six Sigma.',

&nbsp;'2025-02-15', 'ACTIVA', 'SEMANAL', 'PREGRADO', 

&nbsp;'Optimización de Procesos Industriales en Manufactura', 24),



-- Asesoría en pausa para Carlos Ruiz (tesis 2)

(3, 6, 2, 'Asesoría Investigación - Análisis de Datos en Salud Digital', 

&nbsp;'Orientación para investigación aplicada en sistemas de salud digital con enfoque en big data y diagnóstico médico.',

&nbsp;'2025-01-10', 'EN\_PAUSA', 'QUINCENAL', 'PREGRADO', 

&nbsp;'Análisis de Datos en Sistemas de Salud Digital', 15),



-- Asesoría completada para Ana Martínez (tesis 3)

(4, 7, 3, 'Asesoría Tesis - Impacto de Terapias Virtuales', 

&nbsp;'Acompañamiento en investigación sobre impacto psicológico de terapias virtuales en pacientes con trastornos de ansiedad.',

&nbsp;'2025-01-20', 'COMPLETADA', 'MENSUAL', 'PREGRADO', 

&nbsp;'Impacto Psicológico en Terapias Virtuales', 45),



-- Asesoría adicional activa (sin tesis asignada aún)

(2, 6, NULL, 'Asesoría Metodológica - Diseño de Investigación', 

&nbsp;'Apoyo en el diseño metodológico para proyecto de investigación en salud pública.',

&nbsp;'2025-03-01', 'ACTIVA', 'MENSUAL', 'PREGRADO', 

&nbsp;'Metodología de Investigación en Salud', 8);



-- Insertar sesiones de asesoría

INSERT INTO sesiones\_asesoria (

&nbsp;   asesoria\_id, 

&nbsp;   titulo\_sesion, 

&nbsp;   descripcion,

&nbsp;   fecha\_sesion, 

&nbsp;   hora\_inicio, 

&nbsp;   hora\_fin, 

&nbsp;   duracion\_minutos, 

&nbsp;   modalidad, 

&nbsp;   estado, 

&nbsp;   temas\_tratados,

&nbsp;   acuerdos,

&nbsp;   creador\_id

) VALUES

-- Sesiones para asesoría 1 (María González - Activa)

(1, 'Definición del Problema de Investigación', 

&nbsp;'Primera sesión de trabajo para delimitación del problema y objetivos',

&nbsp;'2025-02-20', '10:00:00', '11:30:00', 90, 'PRESENCIAL', 'COMPLETADA',

&nbsp;'Revisión del problema de investigación, formulación de preguntas, alcances y limitaciones',

&nbsp;'Estudiante entregará marco conceptual ampliado para próxima sesión', 2),



(1, 'Revisión del Marco Teórico', 

&nbsp;'Análisis de literatura y construcción de fundamentación teórica',

&nbsp;'2025-02-27', '10:00:00', '11:00:00', 60, 'VIRTUAL', 'COMPLETADA',

&nbsp;'Evaluación de fuentes bibliográficas, estructuración del marco teórico, identificación de vacíos',

&nbsp;'Revisar 5 artículos adicionales sobre Lean Manufacturing', 2),



(1, 'Diseño Metodológico', 

&nbsp;'Definición de metodología, población, muestra e instrumentos',

&nbsp;'2025-03-05', '14:00:00', '15:30:00', 90, 'PRESENCIAL', 'COMPLETADA',

&nbsp;'Selección de metodología mixta, diseño de cuestionarios, protocolo de entrevistas',

&nbsp;'Aplicar cuestionario piloto a 10 participantes', 2),



(1, 'Avance Capítulo 3 - Metodología', 

&nbsp;'Revisión del capítulo metodológico completo',

&nbsp;'2025-11-10', '09:00:00', '10:30:00', 90, 'VIRTUAL', 'COMPLETADA',

&nbsp;'Estructura del capítulo, validez y confiabilidad, procedimiento de recolección',

&nbsp;'Corregir sección 3.2 y agregar matriz de operacionalización', 2),



(1, 'Análisis de Datos Preliminares', 

&nbsp;'Revisión inicial de resultados estadísticos',

&nbsp;'2025-11-28', '16:00:00', '17:00:00', 60, 'PRESENCIA', 'COMPLETADA',

&nbsp;'Análisis descriptivo, pruebas de normalidad, correlaciones',

&nbsp;'Preparar gráficos para presentación de resultados', 2),



(1, 'Revisión Capítulo 4 - Resultados', 

&nbsp;'Análisis exhaustivo de resultados y discusión',

&nbsp;'2025-12-15', '10:00:00', '12:00:00', 120, 'PRESENCIA', 'PROGRAMADA',

&nbsp;'Interpretación de hallazgos, contrastación con teoría, validación de hipótesis',

&nbsp;'Preparar borrador completo de capítulo 4', 2),



-- Sesiones para asesoría 2 (Carlos Ruiz - En pausa)

(2, 'Protocolo de Investigación', 

&nbsp;'Elaboración del protocolo inicial de investigación',

&nbsp;'2025-01-15', '14:00:00', '15:30:00', 90, 'PRESENCIA', 'COMPLETADA',

&nbsp;'Estructura del protocolo, justificación, objetivos generales y específicos',

&nbsp;'Completar revisión bibliográfica para fundamentación', 3),



(2, 'Aspectos Éticos en Investigación Médica', 

&nbsp;'Revisión de consideraciones éticas y consentimiento informado',

&nbsp;'2025-01-30', '10:00:00', '11:00:00', 60, 'VIRTUAL', 'COMPLETADA',

&nbsp;'Comité de ética, confidencialidad de datos, consentimiento informado',

&nbsp;'Preparar documentos para aprobación del comité de ética', 3),



-- Sesiones para asesoría 3 (Ana Martínez - Completada)

(3, 'Defensa de Propuesta', 

&nbsp;'Preparación para defensa del proyecto de tesis',

&nbsp;'2025-02-05', '11:00:00', '12:30:00', 90, 'PRESENCIA', 'COMPLETADA',

&nbsp;'Estructura de presentación, manejo de tiempo, respuestas a preguntas frecuentes',

&nbsp;'Practicar presentación completa 3 veces', 4),



(3, 'Revisión Final de Tesis', 

&nbsp;'Última revisión integral antes de entrega final',

&nbsp;'2025-10-20', '09:00:00', '11:00:00', 120, 'PRESENCIA', 'COMPLETADA',

&nbsp;'Revisión de formato APA, coherencia general, conclusiones y recomendaciones',

&nbsp;'Realizar correcciones finales y entregar versión definitiva', 4),



(3, 'Preparación para Publicación', 

&nbsp;'Adaptación de tesis para publicación académica',

&nbsp;'2025-11-05', '15:00:00', '16:00:00', 60, 'VIRTUAL', 'COMPLETADA',

&nbsp;'Selección de revista, adaptación de formato, envío de manuscrito',

&nbsp;'Enviar artículo a revista indexada en psicología', 4),



-- Sesión para asesoría 4 (adicional)

(4, 'Introducción a la Metodología de Investigación', 

&nbsp;'Sesión introductoria sobre diseño de investigación',

&nbsp;'2025-03-05', '16:00:00', '17:00:00', 60, 'VIRTUAL', 'COMPLETADA',

&nbsp;'Tipos de investigación, variables, hipótesis, diseño muestral',

&nbsp;'Leer capítulo 2 del libro de metodología de Hernández', 2);



-- Insertar tareas de asesoría

INSERT INTO tareas\_asesoria (

&nbsp;   asesoria\_id, 

&nbsp;   sesion\_id, 

&nbsp;   titulo, 

&nbsp;   descripcion, 

&nbsp;   asignado\_a, 

&nbsp;   estado, 

&nbsp;   prioridad, 

&nbsp;   fecha\_asignacion, 

&nbsp;   fecha\_limite,

&nbsp;   categoria,

&nbsp;   porcentaje\_avance

) VALUES

-- Tareas para asesoría 1 (María González)

(1, 1, 'Revisión de literatura sobre Lean Manufacturing', 

&nbsp;'Revisar al menos 10 artículos científicos sobre aplicación de Lean Manufacturing en industria automotriz', 

&nbsp;'ESTUDIANTE', 'COMPLETADA', 'ALTA', '2025-02-20', '2025-02-25', 'LECTURA', 100),



(1, 2, 'Redacción del marco teórico', 

&nbsp;'Escribir secciones 2.1 a 2.3 del marco teórico (Antecedentes, Bases Teóricas, Definición de Términos)', 

&nbsp;'ESTUDIANTE', 'COMPLETADA', 'ALTA', '2025-02-27', '2025-03-05', 'ESCRITURA', 100),



(1, 3, 'Diseño del cuestionario', 

&nbsp;'Elaborar cuestionario de 25 preguntas para medición de variables de investigación', 

&nbsp;'ESTUDIANTE', 'EN\_PROGRESO', 'MEDIA', '2025-03-05', '2025-03-12', 'INVESTIGACION', 60),



(1, 4, 'Aplicación piloto del instrumento', 

&nbsp;'Aplicar cuestionario a 10 trabajadores de planta para validación inicial', 

&nbsp;'ESTUDIANTE', 'PENDIENTE', 'MEDIA', '2025-11-10', '2025-11-17', 'INVESTIGACION', 0),



(1, 5, 'Análisis estadístico con SPSS', 

&nbsp;'Realizar análisis descriptivo e inferencial de los datos recolectados', 

&nbsp;'ESTUDIANTE', 'PENDIENTE', 'ALTA', '2025-11-28', '2025-12-05', 'ESTADISTICA', 0),



(1, 6, 'Revisión de retroalimentación del jurado', 

&nbsp;'Incorporar observaciones del comité evaluador en la versión final', 

&nbsp;'DOCENTE', 'PENDIENTE', 'URGENTE', '2025-12-15', '2025-12-22', 'REVISION', 0),



-- Tareas para asesoría 2 (Carlos Ruiz)

(2, 7, 'Elaboración de consentimiento informado', 

&nbsp;'Redactar documento de consentimiento informado según normativa ética internacional', 

&nbsp;'ESTUDIANTE', 'COMPLETADA', 'ALTA', '2025-01-15', '2025-01-22', 'ESCRITURA', 100),



(2, 8, 'Revisión de protocolo por comité de ética', 

&nbsp;'Enviar protocolo completo al comité de ética de la facultad de medicina', 

&nbsp;'ESTUDIANTE', 'EN\_PROGRESO', 'MEDIA', '2025-01-30', '2025-02-15', 'ETICA', 30),



-- Tareas para asesoría 3 (Ana Martínez - Completadas)

(3, 10, 'Corrección de estilo APA', 

&nbsp;'Ajustar formato de citas y referencias según 7ma edición APA', 

&nbsp;'ESTUDIANTE', 'COMPLETADA', 'ALTA', '2025-10-20', '2025-10-25', 'CORRECCION', 100),



(3, 11, 'Envío a revista científica', 

&nbsp;'Completar proceso de envío del artículo a revista indexada', 

&nbsp;'ESTUDIANTE', 'COMPLETADA', 'MEDIA', '2025-11-05', '2025-11-10', 'PUBLICACION', 100),



-- Tareas para asesoría 4 (adicional)

(4, 12, 'Lectura de capítulos metodológicos', 

&nbsp;'Leer y resumir capítulos 3 y 4 del libro de metodología de investigación', 

&nbsp;'ESTUDIANTE', 'PENDIENTE', 'BAJA', '2025-03-05', '2025-03-12', 'LECTURA', 0);



-- Insertar recursos de asesoría

INSERT INTO recursos\_asesoria (

&nbsp;   docente\_id, 

&nbsp;   titulo, 

&nbsp;   descripcion, 

&nbsp;   tipo\_recurso, 

&nbsp;   categoria, 

&nbsp;   nivel,

&nbsp;   archivo\_url,

&nbsp;   nombre\_archivo,

&nbsp;   tamano\_archivo,

&nbsp;   formato\_archivo,

&nbsp;   visibilidad,

&nbsp;   veces\_descargado,

&nbsp;   etiquetas

) VALUES

-- Recursos del docente 2 (Ingeniería)

(2, 'Plantilla de Tesis - Formato APA 7ma Edición', 

&nbsp;'Plantilla estructurada con todos los elementos necesarios para tesis de pregrado según normas APA',

&nbsp;'PLANTILLA', 'METODOLOGIA', 'PREGRADO', 

&nbsp;'/recursos/plantillas/plantilla-tesis-apa7.docx', 'plantilla-tesis-apa7.docx', 24576, 'DOCX', 'PUBLICO', 42,

&nbsp;'\["APA", "tesis", "plantilla", "formato"]'),



(2, 'Guía de Análisis Estadístico con SPSS 25', 

&nbsp;'Manual completo con ejemplos prácticos para análisis estadístico desde básico hasta avanzado',

&nbsp;'GUIA', 'ESTADISTICA', 'TODOS', 

&nbsp;'/recursos/guias/guia-spss25.pdf', 'guia-spss25.pdf', 5120000, 'PDF', 'PUBLICO', 128,

&nbsp;'\["SPSS", "estadistica", "analisis", "datos"]'),



(2, 'Ejemplo de Cuestionario Validado', 

&nbsp;'Instrumento de investigación validado para estudios en ingeniería industrial',

&nbsp;'EJEMPLO', 'METODOLOGIA', 'PREGRADO', 

&nbsp;'/recursos/ejemplos/cuestionario-validado.pdf', 'cuestionario-validado.pdf', 1024000, 'PDF', 'PRIVADO', 5,

&nbsp;'\["cuestionario", "validacion", "instrumento"]'),



-- Recursos del docente 3 (Medicina)

(3, 'Protocolo de Investigación en Salud', 

&nbsp;'Estructura completa de protocolo para investigación clínica y epidemiológica',

&nbsp;'PLANTILLA', 'ETICA', 'MAESTRIA', 

&nbsp;'/recursos/plantillas/protocolo-salud.docx', 'protocolo-salud.docx', 30720, 'DOCX', 'PUBLICO', 31,

&nbsp;'\["protocolo", "salud", "investigacion", "clinica"]'),



(3, 'Manual de Ética en Investigación Biomédica', 

&nbsp;'Guía completa sobre consideraciones éticas en investigación con seres humanos',

&nbsp;'GUIA', 'ETICA', 'TODOS', 

&nbsp;'/recursos/guias/etica-biomedica.pdf', 'etica-biomedica.pdf', 4096000, 'PDF', 'PUBLICO', 89,

&nbsp;'\["etica", "biomedica", "consentimiento", "investigacion"]'),



-- Recursos del docente 4 (Psicología)

(4, 'Rúbrica de Evaluación de Tesis en Ciencias Sociales', 

&nbsp;'Instrumento de evaluación detallado con criterios cualitativos y cuantitativos',

&nbsp;'RUBRICA', 'EVALUACION', 'PREGRADO', 

&nbsp;'/recursos/rubricas/rubrica-tesis-sociales.pdf', 'rubrica-tesis-sociales.pdf', 1536000, 'PDF', 'PUBLICO', 67,

&nbsp;'\["rubrica", "evaluacion", "tesis", "sociales"]'),



(4, 'Presentación para Defensa de Tesis', 

&nbsp;'Plantilla profesional para presentación en PowerPoint con estructura recomendada',

&nbsp;'PLANTILLA', 'PRESENTACION', 'PREGRADO', 

&nbsp;'/recursos/plantillas/presentacion-defensa.pptx', 'presentacion-defensa.pptx', 10240000, 'PPTX', 'PUBLICO', 124,

&nbsp;'\["presentacion", "defensa", "powerpoint", "tesis"]');



-- Insertar recursos compartidos

INSERT INTO recursos\_compartidos (

&nbsp;   recurso\_id, 

&nbsp;   asesoria\_id, 

&nbsp;   docente\_id, 

&nbsp;   estudiante\_id, 

&nbsp;   comentario\_compartido,

&nbsp;   visto,

&nbsp;   descargado

) VALUES

(1, 1, 2, 5, 'Utiliza esta plantilla como base para estructurar tu tesis', TRUE, TRUE),

(2, 1, 2, 5, 'Consulta esta guía para el análisis de tus datos', TRUE, FALSE),

(3, 1, 2, 5, 'Ejemplo de cuestionario ya validado, adapta según tu investigación', FALSE, FALSE),

(5, 2, 3, 6, 'Es fundamental seguir estos lineamientos éticos', TRUE, TRUE),

(6, 3, 4, 7, 'Esta rúbrica será usada para evaluar tu tesis', TRUE, TRUE),

(7, 3, 4, 7, 'Prepara tu defensa con esta presentación', TRUE, TRUE);



-- Insertar avances de asesoría

INSERT INTO avances\_asesoria (

&nbsp;   asesoria\_id, 

&nbsp;   fecha\_reporte, 

&nbsp;   periodo\_reporte, 

&nbsp;   avance\_capitulos,

&nbsp;   avance\_porcentaje, 

&nbsp;   actividades\_realizadas,

&nbsp;   dificultades\_encontradas,

&nbsp;   logros\_obtenidos,

&nbsp;   objetivos\_siguiente\_periodo,

&nbsp;   reportado\_por,

&nbsp;   aprobado,

&nbsp;   fecha\_aprobacion

) VALUES

-- Avances para asesoría 1 (María González)

(1, '2025-03-01', 'MENSUAL', 'Capítulo 1: 100%, Capítulo 2: 80%, Capítulo 3: 60%', 

&nbsp;65, 

&nbsp;'Completado marco teórico, diseñada metodología, aplicado cuestionario piloto',

&nbsp;'Dificultad para acceder a algunas empresas para aplicación de instrumentos',

&nbsp;'Artículo aceptado en congreso internacional de ingeniería industrial',

&nbsp;'Finalizar recolección de datos, comenzar análisis estadístico',

&nbsp;'ESTUDIANTE', TRUE, '2025-03-05'),



(1, '2025-04-01', 'MENSUAL', 'Capítulo 1: 100%, Capítulo 2: 100%, Capítulo 3: 100%, Capítulo 4: 40%', 

&nbsp;80, 

&nbsp;'Completada recolección de datos (n=120), análisis descriptivo realizado',

&nbsp;'Algunos participantes no completaron todos los ítems del cuestionario',

&nbsp;'Datos validados estadísticamente, alta confiabilidad del instrumento (α=0.89)',

&nbsp;'Completar análisis inferencial, redactar capítulo de resultados',

&nbsp;'ESTUDIANTE', TRUE, '2025-04-05'),



-- Avances para asesoría 2 (Carlos Ruiz)

(2, '2025-02-01', 'MENSUAL', 'Protocolo: 70%, Revisión bibliográfica: 60%', 

&nbsp;45, 

&nbsp;'Revisada literatura científica, elaborado protocolo inicial',

&nbsp;'Retraso en aprobación del comité de ética por alta demanda',

&nbsp;'Protocolo bien estructurado según estándares internacionales',

&nbsp;'Obtener aprobación ética, comenzar reclutamiento de participantes',

&nbsp;'ESTUDIANTE', TRUE, '2025-02-10'),



-- Avances para asesoría 3 (Ana Martínez - Completada)

(3, '2025-10-01', 'MENSUAL', 'Tesis completa: 100%', 

&nbsp;100, 

&nbsp;'Tesis finalizada, defensa exitosa, correcciones incorporadas',

&nbsp;'Ninguna significativa',

&nbsp;'Tesis aprobada con mención sobresaliente (18/20), artículo en revisión',

&nbsp;'Publicación en revista indexada, seguimiento a participantes',

&nbsp;'ESTUDIANTE', TRUE, '2025-10-10');



-- Insertar evaluaciones de asesoría

INSERT INTO evaluaciones\_asesoria (

&nbsp;   asesoria\_id, 

&nbsp;   evaluador\_id, 

&nbsp;   tipo\_evaluacion, 

&nbsp;   fecha\_evaluacion, 

&nbsp;   calificacion\_general,

&nbsp;   comentarios\_generales,

&nbsp;   criterios,

&nbsp;   fortalezas,

&nbsp;   areas\_mejora,

&nbsp;   recomendaciones,

&nbsp;   completada,

&nbsp;   fecha\_completada

) VALUES

-- Evaluación del estudiante (María) hacia el docente (asesoría 1)

(1, 5, 'ESTUDIANTE\_A\_DOCENTE', '2025-04-01', 4.8,

&nbsp;'Excelente asesor, muy dedicado y con amplio conocimiento en el área',

&nbsp;'{"puntualidad": 5, "conocimiento": 5, "disponibilidad": 4.5, "claridad": 4.5, "retroalimentacion": 5}',

&nbsp;'Siempre disponible para resolver dudas, explicaciones muy claras, retroalimentación constructiva',

&nbsp;'Podría ser más estricto con los plazos de entrega',

&nbsp;'Continuar con el mismo nivel de dedicación, excelente trabajo',

&nbsp;TRUE, '2025-04-01'),



-- Evaluación del docente (Roberto) hacia el estudiante (asesoría 3)

(3, 4, 'DOCENTE\_A\_ESTUDIANTE', '2025-10-15', 4.9,

&nbsp;'Estudiante excepcional, muy comprometido y con gran capacidad de investigación',

&nbsp;'{"responsabilidad": 5, "creatividad": 4.5, "dedicacion": 5, "calidad\_trabajo": 5, "iniciativa": 4.5}',

&nbsp;'Alta autonomía en el trabajo, excelentes habilidades de escritura académica, proactivo',

&nbsp;'Podría mejorar en presentaciones orales ante público grande',

&nbsp;'Recomiendo fuertemente para programas de posgrado, gran potencial investigativo',

&nbsp;TRUE, '2025-10-15'),



-- Autoevaluación del docente (Miguel)

(1, 2, 'AUTOEVALUACION', '2025-04-01', 4.5,

&nbsp;'Siento que he podido guiar adecuadamente, pero hay áreas de mejora',

&nbsp;'{"preparacion": 5, "paciencia": 4, "organizacion": 4, "innovacion": 4, "seguimiento": 5}',

&nbsp;'Buena planificación de sesiones, seguimiento constante al estudiante',

&nbsp;'Debería diversificar más los recursos de enseñanza y ser más flexible con metodologías',

&nbsp;'Incorporar más ejemplos prácticos y estudios de caso en las sesiones',

&nbsp;TRUE, '2025-04-01');



-- ============================================

-- 4. ACTUALIZACIÓN DE DATOS EXISTENTES

-- ============================================



-- Actualizar docentes con contadores de asesorías

UPDATE docentes d

SET 

&nbsp;   asesorias\_activas = (

&nbsp;       SELECT COUNT(\*) 

&nbsp;       FROM asesorias a 

&nbsp;       WHERE a.docente\_id = d.id AND a.estado = 'ACTIVA' AND a.activa = TRUE

&nbsp;   ),

&nbsp;   horas\_asesoria\_acumuladas = (

&nbsp;       SELECT COALESCE(SUM(a.horas\_acumuladas), 0)

&nbsp;       FROM asesorias a 

&nbsp;       WHERE a.docente\_id = d.id

&nbsp;   ),

&nbsp;   carga\_trabajo = ROUND(

&nbsp;       (tesis\_asignadas + (

&nbsp;           SELECT COUNT(\*) 

&nbsp;           FROM asesorias a 

&nbsp;           WHERE a.docente\_id = d.id AND a.estado = 'ACTIVA' AND a.activa = TRUE

&nbsp;       )) / capacidad\_maxima, 

&nbsp;       2

&nbsp;   )

WHERE d.id IN (2, 3, 4);



-- Actualizar estudiantes con información de asesoría

UPDATE estudiantes e

SET estado\_tesis = 'EN\_REVISION'

WHERE id = 5;  -- María González tiene asesoría activa



UPDATE estudiantes e

SET estado\_tesis = 'APROBADA'

WHERE id = 7;  -- Ana Martínez tiene asesoría completada



-- Insertar configuraciones específicas para asesorías

INSERT INTO configuracion\_sistema (clave, valor, tipo, categoria, descripcion) VALUES

('ASESORIAS\_MAX\_DOCENTE', '8', 'NUMERO', 'LIMITES', 'Máximo de asesorías activas por docente'),

('HORAS\_MAX\_SEMANALES\_DOCENTE', '15', 'NUMERO', 'LIMITES', 'Horas máximas de asesoría por semana'),

('SESION\_MINIMA\_DURACION', '30', 'NUMERO', 'ASESORIAS', 'Duración mínima de sesión en minutos'),

('SESION\_MAXIMA\_DURACION', '180', 'NUMERO', 'ASESORIAS', 'Duración máxima de sesión en minutos'),

('NOTIFICACION\_SESION\_PROXIMA', '24', 'NUMERO', 'NOTIFICACIONES', 'Horas antes para notificar sesión próxima'),

('EVALUACION\_ASESORIA\_OBLIGATORIA', 'true', 'BOOLEANO', 'ASESORIAS', 'Evaluación obligatoria al finalizar asesoría'),

('CALIFICACION\_MINIMA\_APROBACION', '3.5', 'NUMERO', 'EVALUACION', 'Calificación mínima para aprobación en asesoría'),

('PERIODO\_REPORTE\_AVANCE', 'MENSUAL', 'TEXTO', 'ASESORIAS', 'Periodo por defecto para reporte de avances');



-- Insertar actividades relacionadas con asesorías

INSERT INTO actividades (usuario\_id, tipo\_accion, descripcion, ip\_address, detalles) VALUES

(2, 'ASIGNACION', 'Inicio de asesoría con estudiante María González', '192.168.1.100', 

&nbsp;'{"asesoria\_id": 1, "estudiante": "María González", "tematica": "Optimización de procesos"}'),



(5, 'MODIFICACION\_TESIS', 'Avance significativo en tesis bajo asesoría', '192.168.1.101', 

&nbsp;'{"asesoria\_id": 1, "avance": "65%", "capitulos": "1,2,3 completados"}'),



(4, 'EVALUACION', 'Evaluación positiva de asesoría completada', '192.168.1.102', 

&nbsp;'{"asesoria\_id": 3, "calificacion": 4.9, "estudiante": "Ana Martínez"}'),



(3, 'MODIFICACION\_TESIS', 'Pausa de asesoría por prácticas hospitalarias', '192.168.1.103', 

&nbsp;'{"asesoria\_id": 2, "razon": "Prácticas hospitalarias", "duracion": "3 meses"}');



-- Insertar notificaciones relacionadas con asesorías

INSERT INTO notificaciones (usuario\_destino, titulo, mensaje, tipo, leida, url\_accion) VALUES

(2, 'Nueva sesión programada', 'Tienes una sesión de asesoría programada para el 15 de diciembre con María González', 'RECORDATORIO', FALSE, '/docente/asesorias/1/sesiones/6'),



(5, 'Recordatorio de tarea pendiente', 'Tu tarea "Diseño del cuestionario" vence el 12 de marzo', 'RECORDATORIO', FALSE, '/estudiante/tareas/3'),



(3, 'Asesoría en pausa', 'Tu asesoría con Carlos Ruiz ha sido pausada temporalmente', 'SISTEMA', TRUE, '/docente/asesorias/2'),



(7, 'Asesoría completada exitosamente', '¡Felicidades! Has completado tu asesoría con el Dr. Roberto Silva', 'SISTEMA', TRUE, '/estudiante/asesorias/3'),



(2, 'Evaluación recibida', 'María González ha evaluado tu asesoría con 4.8/5.0', 'EVALUACION\_COMPLETADA', FALSE, '/docente/evaluaciones/1');



-- ============================================

-- 5. ACTUALIZACIÓN DE ESTADÍSTICAS

-- ============================================



-- Actualizar estadísticas en docentes

UPDATE docentes 

SET 

&nbsp;   tesis\_asignadas = (

&nbsp;       SELECT COUNT(\*) 

&nbsp;       FROM asignaciones\_evaluacion ae 

&nbsp;       WHERE ae.docente\_id = docentes.id AND ae.estado IN ('PENDIENTE', 'EN\_PROGRESO')

&nbsp;   )

WHERE id IN (2, 3, 4);



-- Calcular horas acumuladas reales basadas en sesiones completadas

UPDATE asesorias a

SET horas\_acumuladas = (

&nbsp;   SELECT COALESCE(SUM(sa.duracion\_minutos), 0) / 60

&nbsp;   FROM sesiones\_asesoria sa

&nbsp;   WHERE sa.asesoria\_id = a.id AND sa.estado = 'COMPLETADA'

)

WHERE id IN (1, 2, 3, 4);



-- Actualizar satisfacción promedio en asesorías basada en evaluaciones

UPDATE asesorias a

SET calificacion\_estudiante = (

&nbsp;   SELECT AVG(ea.calificacion\_general)

&nbsp;   FROM evaluaciones\_asesoria ea

&nbsp;   WHERE ea.asesoria\_id = a.id 

&nbsp;   AND ea.tipo\_evaluacion = 'ESTUDIANTE\_A\_DOCENTE'

&nbsp;   AND ea.completada = TRUE

)

WHERE id IN (1, 2, 3);



-- ============================================

-- 6. CONSULTA DE VERIFICACIÓN

-- ============================================



-- Verificar datos insertados

SELECT '===== RESUMEN DE DATOS INSERTADOS =====' as mensaje;



SELECT 

&nbsp;   'ASESORÍAS' as tipo,

&nbsp;   COUNT(\*) as cantidad,

&nbsp;   CONCAT(SUM(CASE WHEN estado = 'ACTIVA' THEN 1 ELSE 0 END), ' activas') as detalle

FROM asesorias

UNION ALL

SELECT 

&nbsp;   'SESIONES',

&nbsp;   COUNT(\*),

&nbsp;   CONCAT(SUM(CASE WHEN estado = 'COMPLETADA' THEN 1 ELSE 0 END), ' completadas')

FROM sesiones\_asesoria

UNION ALL

SELECT 

&nbsp;   'TAREAS',

&nbsp;   COUNT(\*),

&nbsp;   CONCAT(SUM(CASE WHEN estado = 'PENDIENTE' THEN 1 ELSE 0 END), ' pendientes')

FROM tareas\_asesoria

UNION ALL

SELECT 

&nbsp;   'RECURSOS',

&nbsp;   COUNT(\*),

&nbsp;   CONCAT(SUM(CASE WHEN visibilidad = 'PUBLICO' THEN 1 ELSE 0 END), ' públicos')

FROM recursos\_asesoria;



-- Mostrar asesorías activas con sus detalles

SELECT 

&nbsp;   '===== ASESORÍAS ACTIVAS =====' as mensaje;



SELECT 

&nbsp;   a.id,

&nbsp;   CONCAT(d.titulo, ' ', u.nombre, ' ', u.apellido) as docente,

&nbsp;   CONCAT(e.nombre, ' ', e.apellido) as estudiante,

&nbsp;   a.titulo\_asesoria,

&nbsp;   a.estado,

&nbsp;   a.horas\_acumuladas,

&nbsp;   (SELECT COUNT(\*) FROM sesiones\_asesoria sa WHERE sa.asesoria\_id = a.id AND sa.estado = 'COMPLETADA') as sesiones\_completadas

FROM asesorias a

INNER JOIN docentes d ON a.docente\_id = d.id

INNER JOIN usuarios u ON d.id = u.id

INNER JOIN estudiantes est ON a.estudiante\_id = est.id

INNER JOIN usuarios e ON est.id = e.id

WHERE a.activa = TRUE

ORDER BY a.estado, a.fecha\_inicio DESC;



-- Mostrar próximas sesiones programadas

SELECT 

&nbsp;   '===== PRÓXIMAS SESIONES =====' as mensaje;



SELECT 

&nbsp;   sa.titulo\_sesion,

&nbsp;   sa.fecha\_sesion,

&nbsp;   sa.hora\_inicio,

&nbsp;   sa.hora\_fin,

&nbsp;   CONCAT(u.nombre, ' ', u.apellido) as estudiante,

&nbsp;   a.titulo\_asesoria

FROM sesiones\_asesoria sa

INNER JOIN asesorias a ON sa.asesoria\_id = a.id

INNER JOIN estudiantes est ON a.estudiante\_id = est.id

INNER JOIN usuarios u ON est.id = u.id

WHERE sa.estado = 'PROGRAMADA'

AND sa.fecha\_sesion >= CURDATE()

ORDER BY sa.fecha\_sesion, sa.hora\_inicio;



COMMIT;



SELECT 'Datos de asesorías insertados y actualizados exitosamente' as mensaje;

-- ============================================

-- 3. MEJORAS A TABLAS EXISTENTES

-- ============================================



-- Añadir columna de teléfono a usuarios

-- ============================================

-- 1. PROCEDIMIENTO PARA AGREGAR COLUMNAS SI NO EXISTEN

-- ============================================



DELIMITER $$



-- Procedimiento para agregar columna a usuarios

DROP PROCEDURE IF EXISTS AddColumnToUsuarios$$

CREATE PROCEDURE AddColumnToUsuarios()

BEGIN

&nbsp;   -- Verificar y agregar teléfono si no existe

&nbsp;   IF NOT EXISTS (

&nbsp;       SELECT \* FROM information\_schema.columns 

&nbsp;       WHERE table\_schema = DATABASE() 

&nbsp;       AND table\_name = 'usuarios' 

&nbsp;       AND column\_name = 'telefono'

&nbsp;   ) THEN

&nbsp;       ALTER TABLE usuarios 

&nbsp;       ADD COLUMN telefono VARCHAR(20) AFTER avatar;

&nbsp;   END IF;



&nbsp;   -- Verificar y agregar dirección si no existe

&nbsp;   IF NOT EXISTS (

&nbsp;       SELECT \* FROM information\_schema.columns 

&nbsp;       WHERE table\_schema = DATABASE() 

&nbsp;       AND table\_name = 'usuarios' 

&nbsp;       AND column\_name = 'direccion'

&nbsp;   ) THEN

&nbsp;       ALTER TABLE usuarios 

&nbsp;       ADD COLUMN direccion TEXT AFTER telefono;

&nbsp;   END IF;



&nbsp;   -- Verificar y agregar fecha\_nacimiento si no existe

&nbsp;   IF NOT EXISTS (

&nbsp;       SELECT \* FROM information\_schema.columns 

&nbsp;       WHERE table\_schema = DATABASE() 

&nbsp;       AND table\_name = 'usuarios' 

&nbsp;       AND column\_name = 'fecha\_nacimiento'

&nbsp;   ) THEN

&nbsp;       ALTER TABLE usuarios 

&nbsp;       ADD COLUMN fecha\_nacimiento DATE AFTER direccion;

&nbsp;   END IF;

END$$



-- Procedimiento para agregar columnas a docentes

DROP PROCEDURE IF EXISTS AddColumnToDocentes$$

CREATE PROCEDURE AddColumnToDocentes()

BEGIN

&nbsp;   -- Verificar y agregar tesis\_pendientes si no existe

&nbsp;   IF NOT EXISTS (

&nbsp;       SELECT \* FROM information\_schema.columns 

&nbsp;       WHERE table\_schema = DATABASE() 

&nbsp;       AND table\_name = 'docentes' 

&nbsp;       AND column\_name = 'tesis\_pendientes'

&nbsp;   ) THEN

&nbsp;       ALTER TABLE docentes 

&nbsp;       ADD COLUMN tesis\_pendientes INT DEFAULT 0 AFTER tesis\_asignadas;

&nbsp;   END IF;



&nbsp;   -- Verificar y agregar tesis\_completadas si no existe

&nbsp;   IF NOT EXISTS (

&nbsp;       SELECT \* FROM information\_schema.columns 

&nbsp;       WHERE table\_schema = DATABASE() 

&nbsp;       AND table\_name = 'docentes' 

&nbsp;       AND column\_name = 'tesis\_completadas'

&nbsp;   ) THEN

&nbsp;       ALTER TABLE docentes 

&nbsp;       ADD COLUMN tesis\_completadas INT DEFAULT 0 AFTER tesis\_pendientes;

&nbsp;   END IF;

END$$



DELIMITER ;



-- ============================================

-- 2. EJECUTAR LOS PROCEDIMIENTOS

-- ============================================



CALL AddColumnToUsuarios();

CALL AddColumnToDocentes();



-- ============================================

-- 3. ELIMINAR LOS PROCEDIMIENTOS TEMPORALES

-- ============================================



DROP PROCEDURE IF EXISTS AddColumnToUsuarios;

DROP PROCEDURE IF EXISTS AddColumnToDocentes;

-- Actualizar carga de trabajo en docentes

UPDATE docentes SET 

&nbsp;   tesis\_asignadas = 1,

&nbsp;   tesis\_pendientes = 1,

&nbsp;   carga\_trabajo = ROUND((tesis\_asignadas / capacidad\_maxima) \* 100, 2)

WHERE id = 2;



-- Actualizar estado de docentes basado en carga

UPDATE docentes 

SET estado = CASE 

&nbsp;   WHEN carga\_trabajo >= 90 THEN 'SOBRECARGADO'

&nbsp;   WHEN carga\_trabajo >= 70 THEN 'ALTA\_CARGA'

&nbsp;   ELSE 'ACTIVO'

END

WHERE id IN (2, 3, 4);



-- ============================================

-- 4. VISTAS ÚTILES PARA REPORTES

-- ============================================



-- Vista para dashboard de administrador

CREATE OR REPLACE VIEW vista\_dashboard AS

SELECT 

&nbsp;   -- Estadísticas de usuarios

&nbsp;   (SELECT COUNT(\*) FROM usuarios WHERE tipo = 'ESTUDIANTE' AND estado = 'ACTIVO') AS estudiantes\_activos,

&nbsp;   (SELECT COUNT(\*) FROM usuarios WHERE tipo = 'DOCENTE' AND estado = 'ACTIVO') AS docentes\_activos,

&nbsp;   (SELECT COUNT(\*) FROM tesis) AS tesis\_totales,

&nbsp;   (SELECT COUNT(\*) FROM tesis WHERE estado = 'SIN\_ENVIAR' OR estado = 'BORRADOR') AS tesis\_sin\_asignar,

&nbsp;   

&nbsp;   -- Estadísticas de evaluación

&nbsp;   (SELECT COUNT(\*) FROM tesis WHERE estado = 'APROBADA') AS tesis\_aprobadas,

&nbsp;   (SELECT COUNT(\*) FROM tesis WHERE estado = 'EN\_REVISION') AS tesis\_en\_revision,

&nbsp;   

&nbsp;   -- Porcentajes

&nbsp;   (SELECT ROUND((COUNT(\*) / (SELECT COUNT(\*) FROM tesis WHERE estado != 'BORRADOR')) \* 100, 0) 

&nbsp;    FROM tesis WHERE estado = 'APROBADA') AS porcentaje\_aprobadas,

&nbsp;   

&nbsp;   (SELECT ROUND(AVG(carga\_trabajo), 0) FROM docentes) AS carga\_docentes\_promedio,

&nbsp;   

&nbsp;   -- Eficiencia del sistema

&nbsp;   (SELECT ROUND((COUNT(\*) / (SELECT COUNT(\*) FROM asignaciones\_evaluacion WHERE estado = 'COMPLETADA')) \* 100, 0)

&nbsp;    FROM asignaciones\_evaluacion WHERE estado = 'COMPLETADA' AND fecha\_completada <= fecha\_limite) AS eficiencia\_porcentaje;



-- Vista para tesis pendientes de asignación

CREATE OR REPLACE VIEW vista\_tesis\_pendientes AS

SELECT 

&nbsp;   t.id,

&nbsp;   t.titulo,

&nbsp;   CONCAT(u.nombre, ' ', u.apellido) AS estudiante,

&nbsp;   c.nombre AS carrera,

&nbsp;   t.fecha\_creacion,

&nbsp;   t.estado

FROM tesis t

JOIN estudiantes e ON t.estudiante\_id = e.id

JOIN usuarios u ON e.id = u.id

JOIN carreras c ON e.carrera\_id = c.id

WHERE t.estado IN ('SIN\_ENVIAR', 'BORRADOR', 'PENDIENTE\_REVISION')

ORDER BY t.fecha\_creacion DESC;



-- Vista para carga de trabajo de docentes

CREATE OR REPLACE VIEW vista\_carga\_docentes AS

SELECT 

&nbsp;   d.id,

&nbsp;   CONCAT(d.titulo, ' ', u.nombre, ' ', u.apellido) AS docente,

&nbsp;   d.especialidad,

&nbsp;   d.tesis\_asignadas,

&nbsp;   d.tesis\_pendientes,

&nbsp;   d.tesis\_completadas,

&nbsp;   d.capacidad\_maxima,

&nbsp;   d.carga\_trabajo,

&nbsp;   CASE 

&nbsp;       WHEN d.carga\_trabajo >= 90 THEN 'SOBRECARGADO'

&nbsp;       WHEN d.carga\_trabajo >= 70 THEN 'ALTA CARGA'

&nbsp;       WHEN d.carga\_trabajo >= 50 THEN 'MEDIA CARGA'

&nbsp;       ELSE 'BAJA CARGA'

&nbsp;   END AS nivel\_carga,

&nbsp;   GROUP\_CONCAT(DISTINCT t.titulo SEPARATOR '; ') AS tesis\_asignadas\_lista

FROM docentes d

JOIN usuarios u ON d.id = u.id

LEFT JOIN asignaciones\_evaluacion ae ON d.id = ae.docente\_id AND ae.estado IN ('PENDIENTE', 'EN\_PROGRESO')

LEFT JOIN tesis t ON ae.tesis\_id = t.id

GROUP BY d.id, u.nombre, u.apellido, d.especialidad;



-- ============================================

-- 5. ÍNDICES PARA MEJORAR EL RENDIMIENTO

-- ============================================



-- Índices para búsquedas frecuentes

CREATE INDEX idx\_usuarios\_tipo\_estado ON usuarios(tipo, estado);

CREATE INDEX idx\_usuarios\_email ON usuarios(email);

CREATE INDEX idx\_tesis\_estudiante\_estado ON tesis(estudiante\_id, estado);

CREATE INDEX idx\_tesis\_estado\_fecha ON tesis(estado, fecha\_creacion DESC);

CREATE INDEX idx\_asignaciones\_docente\_estado ON asignaciones\_evaluacion(docente\_id, estado);

CREATE INDEX idx\_asignaciones\_tesis ON asignaciones\_evaluacion(tesis\_id);

CREATE INDEX idx\_evaluaciones\_asignacion ON evaluaciones(asignacion\_id);

CREATE INDEX idx\_actividades\_usuario\_fecha ON actividades(usuario\_id, fecha\_hora DESC);

CREATE INDEX idx\_notificaciones\_usuario\_leida ON notificaciones(usuario\_destino, leida, fecha\_creacion DESC);



-- ============================================

-- 6. PROCEDIMIENTOS ALMACENADOS ÚTILES

-- ============================================



-- Procedimiento para asignar tesis automáticamente

DELIMITER //

CREATE PROCEDURE sp\_asignar\_tesis\_automaticamente(

&nbsp;   IN p\_tesis\_id INT,

&nbsp;   IN p\_admin\_id INT

)

BEGIN

&nbsp;   DECLARE v\_docente\_id INT;

&nbsp;   DECLARE v\_especialidad\_necesaria VARCHAR(100);

&nbsp;   

&nbsp;   -- Obtener especialidad necesaria basada en la carrera del estudiante

&nbsp;   SELECT c.nombre INTO v\_especialidad\_necesaria

&nbsp;   FROM tesis t

&nbsp;   JOIN estudiantes e ON t.estudiante\_id = e.id

&nbsp;   JOIN carreras c ON e.carrera\_id = c.id

&nbsp;   WHERE t.id = p\_tesis\_id;

&nbsp;   

&nbsp;   -- Buscar docente disponible con menor carga de trabajo en esa especialidad

&nbsp;   SELECT d.id INTO v\_docente\_id

&nbsp;   FROM docentes d

&nbsp;   JOIN usuarios u ON d.id = u.id

&nbsp;   WHERE d.especialidad LIKE CONCAT('%', v\_especialidad\_necesaria, '%')

&nbsp;     AND d.tesis\_asignadas < d.capacidad\_maxima

&nbsp;     AND u.estado = 'ACTIVO'

&nbsp;   ORDER BY d.carga\_trabajo ASC

&nbsp;   LIMIT 1;

&nbsp;   

&nbsp;   IF v\_docente\_id IS NOT NULL THEN

&nbsp;       -- Asignar tesis

&nbsp;       INSERT INTO asignaciones\_evaluacion (tesis\_id, docente\_id, admin\_asignador, fecha\_limite, estado)

&nbsp;       VALUES (p\_tesis\_id, v\_docente\_id, p\_admin\_id, 

&nbsp;               DATE\_ADD(CURDATE(), INTERVAL 30 DAY), 'PENDIENTE');

&nbsp;       

&nbsp;       -- Actualizar contadores

&nbsp;       UPDATE docentes 

&nbsp;       SET tesis\_asignadas = tesis\_asignadas + 1,

&nbsp;           tesis\_pendientes = tesis\_pendientes + 1,

&nbsp;           carga\_trabajo = ROUND(((tesis\_asignadas + 1) / capacidad\_maxima) \* 100, 2)

&nbsp;       WHERE id = v\_docente\_id;

&nbsp;       

&nbsp;       -- Actualizar estado de tesis

&nbsp;       UPDATE tesis 

&nbsp;       SET estado = 'EN\_REVISION'

&nbsp;       WHERE id = p\_tesis\_id;

&nbsp;       

&nbsp;       SELECT 'Tesis asignada exitosamente' AS mensaje, v\_docente\_id AS docente\_asignado;

&nbsp;   ELSE

&nbsp;       SELECT 'No hay docentes disponibles para esta especialidad' AS mensaje;

&nbsp;   END IF;

END//

DELIMITER ;



-- Procedimiento para generar reporte de actividad

DELIMITER //

CREATE PROCEDURE sp\_generar\_reporte\_actividad(

&nbsp;   IN p\_fecha\_inicio DATE,

&nbsp;   IN p\_fecha\_fin DATE

)

BEGIN

&nbsp;   SELECT 

&nbsp;       DATE(fecha\_hora) AS fecha,

&nbsp;       tipo\_accion,

&nbsp;       COUNT(\*) AS total\_acciones,

&nbsp;       GROUP\_CONCAT(DISTINCT descripcion ORDER BY fecha\_hora DESC SEPARATOR '; ') AS actividades

&nbsp;   FROM actividades

&nbsp;   WHERE DATE(fecha\_hora) BETWEEN p\_fecha\_inicio AND p\_fecha\_fin

&nbsp;   GROUP BY DATE(fecha\_hora), tipo\_accion

&nbsp;   ORDER BY fecha DESC, total\_acciones DESC;

END//

DELIMITER ;



-- ============================================

-- 7. DISPARADORES (TRIGGERS)

-- ============================================



-- Trigger para actualizar estado de estudiante cuando su tesis es aprobada

DELIMITER //

CREATE TRIGGER tr\_tesis\_aprobada

AFTER UPDATE ON tesis

FOR EACH ROW

BEGIN

&nbsp;   IF NEW.estado = 'APROBADA' AND OLD.estado != 'APROBADA' THEN

&nbsp;       UPDATE estudiantes 

&nbsp;       SET estado\_tesis = 'APROBADA'

&nbsp;       WHERE id = NEW.estudiante\_id;

&nbsp;   END IF;

END//

DELIMITER ;



-- Trigger para registrar actividades automáticamente

DELIMITER //

CREATE TRIGGER tr\_registrar\_login

AFTER UPDATE ON usuarios

FOR EACH ROW

BEGIN

&nbsp;   IF NEW.ultimo\_acceso IS NOT NULL AND OLD.ultimo\_acceso IS NULL THEN

&nbsp;       INSERT INTO actividades (usuario\_id, tipo\_accion, descripcion)

&nbsp;       VALUES (NEW.id, 'LOGIN', CONCAT('Inicio de sesión de ', NEW.nombre, ' ', NEW.apellido));

&nbsp;   END IF;

END//

DELIMITER ;



-- Trigger para actualizar carga de trabajo de docentes

DELIMITER //

CREATE TRIGGER tr\_actualizar\_carga\_docente

AFTER UPDATE ON asignaciones\_evaluacion

FOR EACH ROW

BEGIN

&nbsp;   IF NEW.estado = 'COMPLETADA' AND OLD.estado != 'COMPLETADA' THEN

&nbsp;       UPDATE docentes 

&nbsp;       SET tesis\_completadas = tesis\_completadas + 1,

&nbsp;           tesis\_pendientes = tesis\_pendientes - 1

&nbsp;       WHERE id = NEW.docente\_id;

&nbsp;   END IF;

END//

DELIMITER ;



-- ============================================

-- 8. VERIFICACIÓN FINAL

-- ============================================



SELECT 'Base de datos ThesisReview Portal actualizada exitosamente' AS mensaje;



-- Mostrar resumen de la base de datos

SELECT 

&nbsp;   (SELECT COUNT(\*) FROM usuarios) AS total\_usuarios,

&nbsp;   (SELECT COUNT(\*) FROM tesis) AS total\_tesis,

&nbsp;   (SELECT COUNT(\*) FROM asignaciones\_evaluacion) AS total\_asignaciones,

&nbsp;   (SELECT COUNT(\*) FROM evaluaciones) AS total\_evaluaciones;

&nbsp;   

&nbsp;   -- ============================================

-- TRIGGERS Y PROCEDIMIENTOS UTILES

-- ============================================



-- Trigger para actualizar horas acumuladas en asesoría cuando se completa una sesión

DELIMITER $$

CREATE TRIGGER actualizar\_horas\_asesoria

AFTER UPDATE ON sesiones\_asesoria

FOR EACH ROW

BEGIN

&nbsp;   IF NEW.estado = 'COMPLETADA' AND OLD.estado != 'COMPLETADA' THEN

&nbsp;       UPDATE asesorias 

&nbsp;       SET horas\_acumuladas = horas\_acumuladas + (NEW.duracion\_minutos / 60)

&nbsp;       WHERE id = NEW.asesoria\_id;

&nbsp;   END IF;

END$$

DELIMITER ;



-- Trigger para actualizar estado de asesoría cuando se completa

DELIMITER $$

CREATE TRIGGER actualizar\_estado\_asesoria\_completada

AFTER UPDATE ON avances\_asesoria

FOR EACH ROW

BEGIN

&nbsp;   IF NEW.aprobado = TRUE AND NEW.avance\_porcentaje = 100 THEN

&nbsp;       UPDATE asesorias 

&nbsp;       SET estado = 'COMPLETADA', fecha\_fin\_real = CURDATE()

&nbsp;       WHERE id = NEW.asesoria\_id;

&nbsp;   END IF;

END$$

DELIMITER ;



-- Procedimiento para obtener estadísticas de asesorías por docente

DELIMITER $$

CREATE PROCEDURE obtener\_estadisticas\_asesorias\_docente(IN p\_docente\_id INT)

BEGIN

&nbsp;   SELECT 

&nbsp;       COUNT(\*) as total\_asesorias,

&nbsp;       SUM(CASE WHEN estado = 'ACTIVA' THEN 1 ELSE 0 END) as activas,

&nbsp;       SUM(CASE WHEN estado = 'COMPLETADA' THEN 1 ELSE 0 END) as completadas,

&nbsp;       SUM(horas\_acumuladas) as horas\_totales,

&nbsp;       AVG(calificacion\_estudiante) as calificacion\_promedio

&nbsp;   FROM asesorias 

&nbsp;   WHERE docente\_id = p\_docente\_id;

END$$

DELIMITER ;



-- Procedimiento para obtener próximas sesiones

DELIMITER $$

CREATE PROCEDURE obtener\_proximas\_sesiones\_docente(IN p\_docente\_id INT, IN p\_dias INT)

BEGIN

&nbsp;   SELECT 

&nbsp;       sa.\*,

&nbsp;       a.titulo\_asesoria,

&nbsp;       CONCAT(u.nombre, ' ', u.apellido) as nombre\_estudiante,

&nbsp;       e.codigo\_estudiante

&nbsp;   FROM sesiones\_asesoria sa

&nbsp;   INNER JOIN asesorias a ON sa.asesoria\_id = a.id

&nbsp;   INNER JOIN estudiantes e ON a.estudiante\_id = e.id

&nbsp;   INNER JOIN usuarios u ON e.id = u.id

&nbsp;   WHERE a.docente\_id = p\_docente\_id 

&nbsp;       AND sa.fecha\_sesion BETWEEN CURDATE() AND DATE\_ADD(CURDATE(), INTERVAL p\_dias DAY)

&nbsp;       AND sa.estado IN ('PROGRAMADA', 'CONFIRMADA')

&nbsp;   ORDER BY sa.fecha\_sesion, sa.hora\_inicio;

END$$

DELIMITER ;



-- ============================================

-- VISTAS UTILES

-- ============================================



-- Vista para panel de asesorías docente

CREATE OR REPLACE VIEW vista\_panel\_asesorias AS

SELECT 

&nbsp;   a.id as asesoria\_id,

&nbsp;   a.titulo\_asesoria,

&nbsp;   a.estado as estado\_asesoria,

&nbsp;   a.fecha\_inicio,

&nbsp;   a.horas\_acumuladas,

&nbsp;   CONCAT(ud.nombre, ' ', ud.apellido) as nombre\_docente,

&nbsp;   CONCAT(ue.nombre, ' ', ue.apellido) as nombre\_estudiante,

&nbsp;   e.codigo\_estudiante,

&nbsp;   c.nombre as carrera,

&nbsp;   t.titulo as titulo\_tesis,

&nbsp;   t.estado as estado\_tesis,

&nbsp;   COUNT(DISTINCT sa.id) as total\_sesiones,

&nbsp;   COUNT(DISTINCT CASE WHEN sa.estado = 'COMPLETADA' THEN sa.id END) as sesiones\_completadas,

&nbsp;   COUNT(DISTINCT ta.id) as total\_tareas,

&nbsp;   COUNT(DISTINCT CASE WHEN ta.estado = 'PENDIENTE' THEN ta.id END) as tareas\_pendientes

FROM asesorias a

INNER JOIN docentes d ON a.docente\_id = d.id

INNER JOIN usuarios ud ON d.id = ud.id

INNER JOIN estudiantes est ON a.estudiante\_id = est.id

INNER JOIN usuarios ue ON est.id = ue.id

INNER JOIN carreras c ON est.carrera\_id = c.id

LEFT JOIN tesis t ON a.tesis\_id = t.id

LEFT JOIN sesiones\_asesoria sa ON a.id = sa.asesoria\_id

LEFT JOIN tareas\_asesoria ta ON a.id = ta.asesoria\_id

GROUP BY a.id

ORDER BY a.fecha\_creacion DESC;



-- Vista para calendario de sesiones

CREATE OR REPLACE VIEW vista\_calendario\_sesiones AS

SELECT 

&nbsp;   sa.id as sesion\_id,

&nbsp;   sa.titulo\_sesion,

&nbsp;   sa.fecha\_sesion,

&nbsp;   sa.hora\_inicio,

&nbsp;   sa.hora\_fin,

&nbsp;   sa.estado as estado\_sesion,

&nbsp;   sa.modalidad,

&nbsp;   a.id as asesoria\_id,

&nbsp;   a.titulo\_asesoria,

&nbsp;   CONCAT(ud.nombre, ' ', ud.apellido) as nombre\_docente,

&nbsp;   CONCAT(ue.nombre, ' ', ue.apellido) as nombre\_estudiante,

&nbsp;   e.codigo\_estudiante

FROM sesiones\_asesoria sa

INNER JOIN asesorias a ON sa.asesoria\_id = a.id

INNER JOIN docentes d ON a.docente\_id = d.id

INNER JOIN usuarios ud ON d.id = ud.id

INNER JOIN estudiantes est ON a.estudiante\_id = est.id

INNER JOIN usuarios ue ON est.id = ue.id

INNER JOIN estudiantes e ON est.id = e.id

WHERE sa.estado IN ('PROGRAMADA', 'CONFIRMADA')

ORDER BY sa.fecha\_sesion, sa.hora\_inicio;



-- ============================================

-- ACTUALIZACIONES A TABLAS EXISTENTES

-- ============================================



-- Agregar columna de asesorías activas a la tabla de docentes

ALTER TABLE docentes 

ADD COLUMN asesorias\_activas INT DEFAULT 0 AFTER tesis\_asignadas,

ADD COLUMN horas\_asesoria\_acumuladas INT DEFAULT 0 AFTER capacidad\_maxima;



-- Actualizar datos iniciales de docentes

UPDATE docentes d

SET asesorias\_activas = (

&nbsp;   SELECT COUNT(\*) 

&nbsp;   FROM asesorias a 

&nbsp;   WHERE a.docente\_id = d.id AND a.estado = 'ACTIVA'

);



-- Actualizar triggers para mantener contadores actualizados

DELIMITER $$

CREATE TRIGGER actualizar\_contador\_asesorias\_docente

AFTER INSERT ON asesorias

FOR EACH ROW

BEGIN

&nbsp;   UPDATE docentes 

&nbsp;   SET asesorias\_activas = asesorias\_activas + 1 

&nbsp;   WHERE id = NEW.docente\_id AND NEW.estado = 'ACTIVA';

&nbsp;   

&nbsp;   UPDATE docentes 

&nbsp;   SET carga\_trabajo = LEAST(1.0, (tesis\_asignadas + asesorias\_activas) / capacidad\_maxima)

&nbsp;   WHERE id = NEW.docente\_id;

END$$

DELIMITER ;



DELIMITER $$

CREATE TRIGGER actualizar\_contador\_asesorias\_docente\_update

AFTER UPDATE ON asesorias

FOR EACH ROW

BEGIN

&nbsp;   IF OLD.estado = 'ACTIVA' AND NEW.estado != 'ACTIVA' THEN

&nbsp;       UPDATE docentes 

&nbsp;       SET asesorias\_activas = asesorias\_activas - 1 

&nbsp;       WHERE id = NEW.docente\_id;

&nbsp;   ELSEIF OLD.estado != 'ACTIVA' AND NEW.estado = 'ACTIVA' THEN

&nbsp;       UPDATE docentes 

&nbsp;       SET asesorias\_activas = asesorias\_activas + 1 

&nbsp;       WHERE id = NEW.docente\_id;

&nbsp;   END IF;

&nbsp;   

&nbsp;   UPDATE docentes 

&nbsp;   SET carga\_trabajo = LEAST(1.0, (tesis\_asignadas + asesorias\_activas) / capacidad\_maxima)

&nbsp;   WHERE id = NEW.docente\_id;

END$$

DELIMITER ;



-- Insertar configuración para el sistema de asesorías

INSERT INTO configuracion\_sistema (clave, valor, tipo, categoria, descripcion) VALUES

('duracion\_maxima\_asesoria\_meses', '12', 'NUMERO', 'ASESORIAS', 'Duración máxima en meses para una asesoría'),

('horas\_maximas\_semana\_docente', '20', 'NUMERO', 'ASESORIAS', 'Horas máximas de asesoría por semana para un docente'),

('notificaciones\_sesiones\_programadas', 'true', 'BOOLEANO', 'NOTIFICACIONES', 'Enviar notificaciones para sesiones programadas'),

('recordatorio\_tareas\_antes\_dias', '2', 'NUMERO', 'NOTIFICACIONES', 'Días antes para enviar recordatorio de tareas pendientes');





-- ============================================

-- TABLA ASIGNACIONES (FALTANTE)

-- ============================================



CREATE TABLE IF NOT EXISTS asignaciones (

&nbsp;   id INT AUTO\_INCREMENT PRIMARY KEY,

&nbsp;   id\_tesis INT NOT NULL,

&nbsp;   id\_docente INT NOT NULL,

&nbsp;   rol ENUM('JURADO', 'ASESOR') NOT NULL,

&nbsp;   estado ENUM('ASIGNADA', 'EN\_REVISION', 'EN\_PROGRESO', 'COMPLETADA', 'EVALUADA', 'CANCELADA') DEFAULT 'ASIGNADA',

&nbsp;   fecha\_asignacion TIMESTAMP DEFAULT CURRENT\_TIMESTAMP,

&nbsp;   fecha\_limite DATE,

&nbsp;   fecha\_completada TIMESTAMP NULL,

&nbsp;   observaciones TEXT,

&nbsp;   calificacion DECIMAL(4,2),

&nbsp;   feedback TEXT,

&nbsp;   FOREIGN KEY (id\_tesis) REFERENCES tesis(id) ON DELETE CASCADE,

&nbsp;   FOREIGN KEY (id\_docente) REFERENCES docentes(id) ON DELETE CASCADE,

&nbsp;   INDEX idx\_docente\_estado (id\_docente, estado),

&nbsp;   INDEX idx\_tesis (id\_tesis),

&nbsp;   INDEX idx\_fecha\_limite (fecha\_limite)

);



-- Insertar asignaciones de ejemplo para el docente (id=2 - Miguel Torres)

INSERT INTO asignaciones (id\_tesis, id\_docente, rol, estado, fecha\_asignacion, fecha\_limite, observaciones) VALUES

-- Asignaciones como JURADO (para revisión)

(1, 2, 'JURADO', 'ASIGNADA', '2025-12-01', '2025-12-31', 'Revisar metodología y resultados'),

(2, 2, 'JURADO', 'EN\_REVISION', '2025-11-15', '2025-12-20', 'En proceso de revisión de capítulos'),

(3, 2, 'JURADO', 'COMPLETADA', '2025-10-01', '2025-10-31', 'Revisión completada - Tesis aprobada'),



-- Asignaciones como ASESOR (CORREGIDO: 'EN\_PAUSA' cambiado a 'EN\_PROGRESO')

(1, 2, 'ASESOR', 'EN\_PROGRESO', '2025-02-15', '2025-12-31', 'Asesoría activa - María González'),

(2, 3, 'ASESOR', 'EN\_PROGRESO', '2025-01-10', NULL, 'Asesoría en pausa por prácticas'),

(3, 4, 'ASESOR', 'COMPLETADA', '2025-01-20', '2025-10-20', 'Asesoría completada exitosamente'),



-- Otras asignaciones de ejemplo

(2, 2, 'JURADO', 'ASIGNADA', '2025-12-05', '2026-01-15', 'Revisión pendiente de asignación');





UPDATE docentes d

SET 

&nbsp;   tesis\_asignadas = (

&nbsp;       SELECT COUNT(\*) 

&nbsp;       FROM asignaciones a 

&nbsp;       WHERE a.id\_docente = d.id AND a.rol = 'JURADO'

&nbsp;   ),

&nbsp;   tesis\_pendientes = (

&nbsp;       SELECT COUNT(\*) 

&nbsp;       FROM asignaciones a 

&nbsp;       WHERE a.id\_docente = d.id AND a.rol = 'JURADO' 

&nbsp;       AND a.estado IN ('ASIGNADA', 'EN\_REVISION')

&nbsp;   ),

&nbsp;   tesis\_completadas = (

&nbsp;       SELECT COUNT(\*) 

&nbsp;       FROM asignaciones a 

&nbsp;       WHERE a.id\_docente = d.id AND a.rol = 'JURADO' 

&nbsp;       AND a.estado IN ('COMPLETADA', 'EVALUADA')

&nbsp;   ),

&nbsp;   carga\_trabajo = ROUND(

&nbsp;       ((

&nbsp;           SELECT COUNT(\*) 

&nbsp;           FROM asignaciones a 

&nbsp;           WHERE a.id\_docente = d.id AND a.rol = 'JURADO'

&nbsp;       ) / NULLIF(capacidad\_maxima, 0)) \* 100, 

&nbsp;       2

&nbsp;   )

WHERE d.id IN (2, 3, 4);



-- ============================================

-- VERIFICACIÓN DE LA CREACIÓN

-- ============================================



-- Verificar que la tabla se creó correctamente

SELECT 'Tabla ASIGNACIONES creada exitosamente' AS mensaje;



-- Mostrar conteo de asignaciones por docente y rol

SELECT 

&nbsp;   CONCAT(u.nombre, ' ', u.apellido) AS docente,

&nbsp;   a.rol,

&nbsp;   COUNT(\*) AS total\_asignaciones,

&nbsp;   SUM(CASE WHEN a.estado = 'ASIGNADA' THEN 1 ELSE 0 END) AS pendientes,

&nbsp;   SUM(CASE WHEN a.estado = 'EN\_REVISION' THEN 1 ELSE 0 END) AS en\_revision,

&nbsp;   SUM(CASE WHEN a.estado IN ('COMPLETADA', 'EVALUADA') THEN 1 ELSE 0 END) AS completadas

FROM asignaciones a

INNER JOIN docentes d ON a.id\_docente = d.id

INNER JOIN usuarios u ON d.id = u.id

GROUP BY a.id\_docente, a.rol

ORDER BY u.apellido, a.rol;



-- Mostrar asignaciones específicas del docente Miguel Torres (id=2)

SELECT 

&nbsp;   'Asignaciones del docente Miguel Torres (ID: 2)' AS titulo;

&nbsp;   

SELECT 

&nbsp;   a.id,

&nbsp;   t.titulo AS titulo\_tesis,

&nbsp;   a.rol,

&nbsp;   a.estado,

&nbsp;   DATE(a.fecha\_asignacion) AS fecha\_asignacion,

&nbsp;   a.fecha\_limite,

&nbsp;   a.observaciones

FROM asignaciones a

INNER JOIN tesis t ON a.id\_tesis = t.id

WHERE a.id\_docente = 2

ORDER BY a.estado, a.fecha\_limite;



-- Ver estructura de la tabla docentes

DESCRIBE docentes;



-- Ver estructura de la tabla usuarios

DESCRIBE usuarios;



-- Ver estructura de la tabla asignaciones

DESCRIBE asignaciones;

-- Tabla para almacenar mensajes enviados a estudiantes

CREATE TABLE mensajes (

&nbsp;   id\_mensaje INT PRIMARY KEY AUTO\_INCREMENT,

&nbsp;   id\_asignacion INT NOT NULL,

&nbsp;   id\_docente INT NOT NULL,

&nbsp;   id\_estudiante INT NOT NULL,

&nbsp;   asunto VARCHAR(255) NOT NULL,

&nbsp;   contenido TEXT NOT NULL,

&nbsp;   tipo\_mensaje ENUM('general', 'observaciones', 'correcciones', 'cita', 'urgente') DEFAULT 'general',

&nbsp;   fecha\_envio DATETIME DEFAULT CURRENT\_TIMESTAMP,

&nbsp;   estado ENUM('enviado', 'leido', 'no\_leido') DEFAULT 'no\_leido',

&nbsp;   adjuntos TEXT, -- JSON para almacenar rutas de archivos adjuntos

&nbsp;   

&nbsp;   -- Foreign Keys

&nbsp;   FOREIGN KEY (id\_asignacion) REFERENCES asignaciones(id) ON DELETE CASCADE,

&nbsp;   FOREIGN KEY (id\_docente) REFERENCES usuarios(id) ON DELETE CASCADE,

&nbsp;   FOREIGN KEY (id\_estudiante) REFERENCES usuarios(id) ON DELETE CASCADE,

&nbsp;   

&nbsp;   -- Índices para mejor performance

&nbsp;   INDEX idx\_mensajes\_estudiante (id\_estudiante),

&nbsp;   INDEX idx\_mensajes\_docente (id\_docente),

&nbsp;   INDEX idx\_mensajes\_fecha (fecha\_envio),

&nbsp;   INDEX idx\_mensajes\_estado (estado)

);



-- Tabla para respuestas a mensajes (opcional, si quieres mantener hilos de conversación)

CREATE TABLE respuestas\_mensajes (

&nbsp;   id\_respuesta INT PRIMARY KEY AUTO\_INCREMENT,

&nbsp;   id\_mensaje\_original INT NOT NULL,

&nbsp;   id\_remitente INT NOT NULL,

&nbsp;   contenido TEXT NOT NULL,

&nbsp;   fecha\_respuesta DATETIME DEFAULT CURRENT\_TIMESTAMP,

&nbsp;   leido BOOLEAN DEFAULT FALSE,

&nbsp;   

&nbsp;   FOREIGN KEY (id\_mensaje\_original) REFERENCES mensajes(id\_mensaje) ON DELETE CASCADE,

&nbsp;   FOREIGN KEY (id\_remitente) REFERENCES usuarios(id) ON DELETE CASCADE

);



