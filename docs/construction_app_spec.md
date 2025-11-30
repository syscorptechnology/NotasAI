# MVP de app de gestión de obra (iOS con SwiftUI)

## 1. Necesidades habituales en obra
- Seguimiento de avances por fases (cimentación, estructura, acabados, etc.).
- Estado de tareas e hitos con responsables claros.
- Parte o registro diario: qué se hizo, incidencias, fotos y quién estuvo presente.
- Gestión de recursos: mano de obra (equipos/cuadrillas), materiales (pedido, recepción, consumo, stock), maquinaria (disponibilidad, uso, mantenimiento básico).
- Documentación: planos, especificaciones, contratos, órdenes de cambio, actas, informes y checklists.
- Comunicación: comentarios por actividad, notificaciones en tiempo real, fechas límite visibles.
- Control básico de costos y tiempos: progreso vs. planificación e incidencias que afecten plazos/costos.

## 2. Funcionalidades clave
### MVP (versión inicial)
1) **Gestión de proyectos**
   - Crear/editar proyectos con nombre, cliente, ubicación, fechas clave y responsable.
2) **Gestión de tareas / hitos**
   - Crear tareas por proyecto, asignar responsable, fechas inicio/fin, estado (pendiente, en progreso, finalizado) y prioridad (alta/media/baja).
3) **Registro de avance en obra**
   - Parte diario con descripción de lo realizado, personal presente, incidencias, fotos y porcentaje de avance por tarea.
4) **Gestión de documentos**
   - Subir/visualizar planos, PDFs e imágenes; asociar documentos a proyecto o tarea.
5) **Comunicación básica**
   - Comentarios dentro de proyectos/tareas y notificaciones push al asignar tareas, comentar o cambiar estado relevante.
6) **Vista general / dashboard**
   - Lista de proyectos, indicador de progreso general y tareas atrasadas o próximas a vencer.

### Funcionalidades futuras (v2+)
- Control de costos y presupuestos por capítulos/partidas.
- Integración con ERP o planificación (MS Project/Primavera).
- Geolocalización (ubicación de obras, registro de presencia).
- Firma digital de actas/documentos.
- Reportes avanzados (PDF automático para cliente).
- Gestión de subcontratistas con accesos limitados.
- Modo offline robusto con sincronización diferida.
- Checklists de calidad y seguridad (HSE).

## 3. Flujo lógico para jefe de obra (MVP)
1) **Inicio de sesión / acceso**: abre la app y ve la lista de proyectos donde participa.
2) **Seleccionar proyecto**: dashboard con progreso general, tareas en curso/atrasadas y últimos partes diarios.
3) **Gestión de tareas**: filtra por estado, crea tarea (nombre, descripción, responsable, fechas, prioridad) o actualiza estado/agrega fotos, comentarios y avance.
4) **Parte diario**: botón “Registrar día” → fecha (hoy por defecto), descripción de lo realizado, mano de obra presente, incidencias y fotos; al guardar envía notificación al director.
5) **Documentos**: pestaña de documentos para subir o consultar y asociar a tareas.
6) **Notificaciones**: alertas por nuevas tareas, comentarios, cambios de estado y tareas vencidas.

## 4. Arquitectura y tecnologías iOS recomendadas
- **Lenguaje/UI**: Swift con SwiftUI.
- **Gestión de estado**: `@State`, `@ObservedObject`, `@EnvironmentObject`, Combine o Swift Concurrency (async/await).
- **Persistencia local**: Core Data o Realm.
- **Sincronización**: CloudKit (ecosistema Apple) o backend propio (API REST/GraphQL).
- **Autenticación**: Sign in with Apple, email/contraseña (backend) u OAuth2 corporativo.
- **Notificaciones push**: APNs + servicio backend.
- **Arquitectura**: MVVM con capas de datos (repositorios remotos/locales), dominio (casos de uso como CreateTask, UpdateProgress, GetDailyReport) y presentación (ViewModels + vistas SwiftUI).

## 5. Modelos de dominio sugeridos (MVP)
- **Proyecto**: id, nombre, cliente, ubicación, fechas clave, responsable, progreso.
- **Tarea**: id, proyectoId, nombre, descripción, responsable, fechaInicio/fin, estado, prioridad, avance%, adjuntos, comentarios.
- **ParteDiario**: id, proyectoId, fecha, descripción, manoDeObra, incidencias, fotos, tareasActualizadas.
- **Documento**: id, proyectoId (y opcional tareaId), tipo, nombre, url/localPath, fechaSubida, subidoPor.
- **Usuario**: id, nombre, rol (director, jefe de obra, supervisor, contratista, cliente), notificacionesOptIn.

## 6. Consideraciones de UX y entrega
- Simplificar formularios con valores por defecto (fecha de hoy, responsable actual) y plantillas de parte diario.
- Permitir carga de fotos y uso sin conexión con sincronización posterior.
- Roles/visibilidad: subcontratistas con permisos limitados; clientes con vista sólo lectura de progreso/documentos clave.
- Dashboard con tarjetas de progreso y alertas de tareas vencidas.
