# Backlog MVP: Historias de usuario y criterios de aceptación

## 1. Módulo: Autenticación

### 1.1 Inicio de sesión
**Como** usuario registrado **quiero** iniciar sesión en la app **para** acceder a mis proyectos y tareas.

**Criterios de aceptación**
- Doble entrada de email y contraseña.
- Si las credenciales son correctas, acceso a la pantalla de proyectos.
- Credenciales incorrectas muestran mensaje de error claro.
- Botón “Iniciar sesión” desactivado si los campos están vacíos.
- La sesión persiste hasta que el usuario cierre sesión manualmente.

### 1.2 Cerrar sesión
**Como** usuario **quiero** cerrar sesión **para** asegurar que nadie más acceda a mi información.

**Criterios de aceptación**
- Botón “Cerrar sesión” visible.
- Al hacer clic, regreso a la pantalla de inicio de sesión.
- La sesión guardada se elimina.

## 2. Módulo: Gestión de Proyectos

### 2.1 Ver lista de proyectos
**Como** usuario **quiero** ver los proyectos donde participo **para** tener una visión general de mi trabajo.

**Criterios de aceptación**
- Lista con nombre, cliente, ubicación y progreso.
- Se cargan solo proyectos asociados al usuario.
- Si no hay proyectos, mensaje: “No tienes proyectos asignados”.

### 2.2 Ver detalle de proyecto
**Como** usuario **quiero** ver el detalle de un proyecto **para** entender su estado general y acceder a sus módulos.

**Criterios de aceptación**
- Mostrar: nombre, cliente, fechas, responsable, progreso global.
- Acceso a Tareas, Partes diarios, Documentos y Equipo.
- Visualización del avance general del proyecto.

## 3. Módulo: Gestión de Tareas

### 3.1 Ver lista de tareas
**Como** usuario **quiero** ver todas las tareas del proyecto **para** saber qué debo hacer o supervisar.

**Criterios de aceptación**
- Lista filtrable por estado y ordenable por fecha y prioridad.
- Cada tarea muestra título, estado, responsable y fecha límite.
- Si no hay tareas, mensaje: “Aún no hay tareas en este proyecto”.

### 3.2 Crear una tarea
**Como** usuario **quiero** crear una nueva tarea dentro de un proyecto **para** organizar los trabajos necesarios.

**Criterios de aceptación**
- Captura de título, descripción, fechas, responsable y prioridad.
- Validación de todos los campos obligatorios.
- La tarea se guarda y aparece en la lista.
- Confirmación visual tras guardar.

### 3.3 Actualizar estado de una tarea
**Como** usuario **quiero** cambiar el estado de una tarea **para** reflejar su progreso.

**Criterios de aceptación**
- Permitir cambio Pendiente → En progreso → Finalizada.
- Estado actualizado en tiempo real en la lista.
- Registrar fecha de actualización.
- Notificar al responsable si el cambio lo realiza otra persona.

### 3.4 Añadir comentario a una tarea
**Como** usuario **quiero** agregar comentarios en una tarea **para** comunicar avances o dudas al equipo.

**Criterios de aceptación**
- Campo de texto para escribir y enviar.
- Cada comentario muestra autor, fecha y hora.
- Aparición inmediata en el hilo.
- Notificaciones a participantes de la tarea.

### 3.5 Subir fotos a una tarea
**Como** usuario **quiero** adjuntar fotos a una tarea **para** documentar el avance o incidencias.

**Criterios de aceptación**
- Subir fotos desde cámara o galería.
- Visualización en la pantalla de detalles de la tarea.
- Indicador de carga durante la subida.
- Mensaje de error claro si falla.

## 4. Módulo: Partes Diarios

### 4.1 Ver lista de partes diarios
**Como** usuario **quiero** ver los partes diarios de un proyecto **para** revisar el progreso histórico.

**Criterios de aceptación**
- Lista ordenada por fecha.
- Cada ítem muestra fecha, resumen y autor.
- Posibilidad de abrir cualquier parte.

### 4.2 Crear parte diario
**Como** usuario de campo **quiero** registrar el parte del día **para** dejar constancia del trabajo realizado.

**Criterios de aceptación**
- Ingreso de descripción, fotos, mano de obra presente e incidencias.
- Guardado automático con fecha del día.
- Notificación al director del proyecto.
- Visibilidad inmediata en la lista.

## 5. Módulo: Documentos

### 5.1 Subir documento
**Como** usuario **quiero** subir documentos asociados al proyecto **para** centralizar la información.

**Criterios de aceptación**
- Seleccionar documento (PDF o imagen).
- Indicar si pertenece al proyecto o a una tarea.
- El documento se sube y queda visible en la lista.
- Mensaje claro de error si falla.

### 5.2 Ver documentos
**Como** usuario **quiero** ver y abrir documentos del proyecto **para** consultar información en obra.

**Criterios de aceptación**
- Lista con nombre, tipo y fecha.
- Posibilidad de abrirlos (vista previa o app externa).
- Buscador y filtros por tipo.

## 6. Módulo: Notificaciones

### 6.1 Recibir notificaciones relevantes
**Como** usuario **quiero** recibir notificaciones de acciones importantes **para** estar al tanto de cambios en mis tareas.

**Criterios de aceptación**
- Notificar cuando: me asignan una tarea, cambia el estado de una tarea mía, añaden comentario a una tarea donde participo o se crea un parte diario en mi proyecto.
- Las notificaciones pueden activarse o desactivarse por el usuario.

## 7. Módulo: Configuración

### 7.1 Editar preferencias
**Como** usuario **quiero** configurar mis preferencias **para** personalizar mi experiencia.

**Criterios de aceptación**
- Activar o desactivar notificaciones por tipo.
- Modificar nombre y foto (opcional).
- Ver rol y empresa en solo lectura.
