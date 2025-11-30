# Diseño funcional: NotasAI

## Ejemplos de pantallas y módulos

### 1. Autenticación
- Pantalla de login.
- Recuperación de contraseña.
- (Futuro) Selección de empresa u organización.

### 2. Proyectos
- Lista de proyectos con nombre, cliente, ubicación y progreso.
- Detalle de proyecto con progreso general y accesos a **Tareas**, **Parte diario**, **Documentos** y **Equipo**.

### 3. Tareas
- Lista de tareas filtrable y ordenable.
- Detalle de tarea con título y descripción.
- Estado, prioridad, fechas y responsable.
- Comentarios tipo chat y fotos adjuntas.
- Botones “Actualizar estado” y “Añadir comentario/foto”.

### 4. Parte diario
- Lista de partes diarios por fecha.
- Formulario para crear un parte con: fecha, descripción, mano de obra (texto o selección), incidencias y fotos.
- Vista detalle de un parte ya registrado.

### 5. Documentos
- Lista de documentos por tipo (planos, contratos, actas, etc.).
- Buscador y filtros.
- Vista previa (nombre y posibilidad de abrir con otra app).

### 6. Perfil / Configuración
- Datos del usuario.
- Preferencias de notificación.
- Cerrar sesión.

### Estructura típica de una pantalla de Detalle de Tarea
- Encabezado con título de la tarea y chip de estado (Pendiente / En progreso / Finalizada).
- **Información**: proyecto, responsable, fechas (inicio y vencimiento) y prioridad.
- **Progreso**: slider o indicador de porcentaje.
- **Comentarios**: lista tipo chat y campo de texto para añadir nuevos.
- **Adjuntos**: grid o lista de fotos y documentos.
- **Acciones**: cambiar estado, añadir foto y ver historial de cambios (futuro).

## Esquema básico de base de datos (conceptual)

### Entidades principales
- **Usuario**: id, nombre, email, rol (admin, director_obra, jefe_obra, supervisor, etc.).
- **Proyecto**: id, nombre, cliente, ubicación, fecha_inicio, fecha_fin_estimada, responsable_id (Usuario), progreso_global (0–100, calculado).
- **Tarea**: id, proyecto_id, título, descripción, responsable_id, fecha_inicio, fecha_fin, estado (pendiente, en_progreso, finalizada), prioridad (baja, media, alta), porcentaje_avance (0–100), fecha_creacion, fecha_actualizacion.
- **Comentario**: id, tarea_id, usuario_id, mensaje, fecha.
- **ParteDiario**: id, proyecto_id, fecha, descripción, mano_obra, incidencias, usuario_id (creador).
- **Documento**: id, proyecto_id, tarea_id (opcional), nombre, tipo (plano, contrato, informe, etc.), url_remota o ruta_local, fecha_subida, usuario_id.
- **AdjuntoFoto**: id, tarea_id o parte_diario_id, url_remota o ruta_local, fecha_subida, usuario_id.

## Riesgos y buenas prácticas

### Riesgos
- Conectividad limitada en obra → necesidad de soporte offline y sincronización robusta.
- Adopción por parte del equipo: la app debe ser simple y rápida.
- Volumen de fotos y documentos: almacenamiento y rendimiento.
- Seguridad de la información: datos sensibles de clientes, contratos y planos.

### Buenas prácticas
- MVP bien enfocado: priorizar tareas, partes diarios y comunicación básica en la v1.
- Diseño sencillo y claro: pocas opciones por pantalla, botones grandes y texto legible.
- Modo offline: caché local de proyectos/tareas recientes y cola de acciones pendientes.
- Notificaciones configurables por el usuario.
- Pruebas con usuarios reales de obra antes de cerrar el diseño.
