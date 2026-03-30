# Protocolo Neurogestor v2.0
**Fecha:** 2026-03-28 (Migrado a v2: 2026-03-30)
**Propósito:** Documentar la estructura, flujo de trabajo y responsabilidades de la capa de orquestación centralizada (Neurogestor) entre Joseias (Nivel 0) y el Motor NVIDIA NIM (Nivel 1+).

---

El **Neurogestor** es el marco conceptual y operativo que rige la interacción entre la interfaz humana (Joseias/Nivel 0) y el motor de planificación y ejecución agéntica (NVIDIA NIM/Nivel 1+). Su objetivo es garantizar que las tareas complejas se descompongan, se asignen al agente más apropiado y que el resultado sea traducido de vuelta al lenguaje natural del usuario sin contaminación del contexto interno.

---

### A. NVIDIA NIM — Interfaz Humana (Nivel 0)
- **Rol:** Recibe toda entrada (voz, imagen, texto, archivo), maneja la conversación cotidiana, personal y contextual.
- **Interacción con Neurogestor:**
    - **Lectura:** Lee el Neurogestor para obtener contexto sobre tareas ejecutadas previamente.
    - **Escritura:** Escribe SOLO datos de Nivel 0 relevantes (ej. preferencias personales).
    - **Delegación:** Notifica al motor cuando la tarea es de Nivel 1 o superior, empaquetando la intención.
    - **Entrega:** Recibe el resultado traducido y lo entrega al usuario.

### B. Motor NVIDIA NIM — Planner / Orquestador / Escribano Agéntico (Nivel 1+)
- **Rol:** Recepción de tareas complejas, planificación, asignación de agentes, supervisión de ejecución y reporte estructurado.
- **Interacción con Neurogestor:**
    - **Planificación:** Analiza la tarea, elige agente, arma el plan.
    - **Ejecución:** Asigna y supervisa al agente elegido.
    - **Escritura:** Escribe el reporte estructurado (Taxonomía AMP) en el Neurogestor.
    - **Notificación:** Notifica con el resultado final para su traducción.

---

## 3. API Endpoints (Interacción Conceptual)
| Punto de Interacción | Actor Iniciador | Destinatario | Formato |
| :--- | :--- | :--- | :--- |
| TaskRequest | Nivel 0 | Nivel 1+ | JSON estructurado con task, context, requested_level |
| AgentDispatch | Motor | Agente Técnico | Llamada a herramienta (tool_call) o API externa |
| ExecutionReport | Agente Técnico | Motor | JSON con resultados y logs internos |
| NeuroWrite | Motor | Neurogestor (Archivo) | Estructura AMP completa |
| ResultNotify | Motor | Nivel 0 | Texto resumen + JSON estructurado del resultado |

---

## 4. Taxonomía AMP (Análisis de Metadatos de Proyecto)
Todo registro o reporte de Nivel 1+ en el Neurogestor debe seguir esta estructura:

```json
{
  "project": "string (ej. AlianeD_OS)",
  "scope": "string (ej. backend_setup)",
  "agent_id": "string (ID único de la ejecución)",
  "metadata": {
    "task_level": "integer (0, 1, 2, 3, 4)",
    "host_id": "string (ej. ALIHA_CODESPACE, ALIHA_DOKPLOY)",
    "executor_agent": "string (nombre del agente que ejecutó)",
    "executor_model": "string (modelo usado para la ejecución)",
    "executor_api": "string (nvidia-nim | openrouter | gemini)",
    "timestamp": "ISO 8601",
    "outcome": "string (success|fail|timeout)"
  }
}
```

---

## 5. Flujo de Orquestación Completo
1. **CALIBRO:** Motor evalúa la complejidad.
2. **ENTREGO:** Si Nivel 1+: empaqueta para el motor.
3. **PLAN:** Motor analiza, elige agente, verifica API.
4. **SUIT:** Motor notifica: [Traje: MODELO — nivel X — razón]
5. **ACT:** Agente ejecuta bajo supervisión del motor.
6. **REPORT:** Agente reporta resultado al motor.
7. **WRITE:** Motor escribe en el Neurogestor usando Taxonomía AMP.
8. **NOTIFY:** Motor notifica a Nivel 0 con el resultado procesado.
9. **DELIVER:** Nivel 0 traduce el resultado y lo entrega al usuario.
10. **RESET:** Motor notifica: [Traje removido — default restaurado]

---

## 6. Niveles de Calibración
| Nivel | Descripción | Actor Principal | Motor |
| :--- | :--- | :--- | :--- |
| 0 | Conversación, código simple, multimodal | NVIDIA NIM (Joseias) | NVIDIA NIM |
| 1 | Prototipo, script funcional | NVIDIA NIM | NVIDIA NIM |
| 2 | App completa, arquitectura | NVIDIA NIM + OpenRouter | NVIDIA NIM |
| 3 | Razonamiento puro, matemáticas | OpenRouter (especializado) | NVIDIA NIM |
| 4 | Contexto masivo (>200k tokens) | OpenRouter (contexto largo) | NVIDIA NIM |

---

## 7. Estructura del Workspace
- **SOUL.md**: Identidad del agente principal y protocolo de enrutamiento.
- **TOOLS.md**: Inventario y configuración de herramientas.
- **NEUROGESTOR_PROTOCOL.md**: Lógica de ejecución.
- **HEARTBEAT.md**: Checklist proactivo para Joseias.

---

## 8. Hoja de Ruta
1. Estabilizar ALihas v2: Motor NVIDIA NIM operativo en Codespace.
2. Validación del Neurogestor: Ejecutar múltiples tareas Nivel 1+ para validar trazabilidad AMP.
3. Agente Watchdog Local: Modelo ~5B params entrenado para seguridad lógica.
4. Migración a Producción: Desplegar en Dokploy con la misma configuración.

---

## 9. GridStack — Canvas de Orquestación Visual
GridStack.js es la librería para la interfaz de arrastre y composición de piezas de orquestación.

Resuelve:
1. Ver todas las piezas disponibles por categoría.
2. Arrastrar y soltar piezas sobre la tarjeta de un producto.
3. Reordenar, redimensionar y organizar el layout.
4. Guardar la configuración espacial de piezas asignadas por producto.

---

## 10. Matriz de Implementación IA (IHA)

### Eje X — Alcance Modular
Finanzas, Marketing, Agenda, Reservas, Ticket, RRHH, Archivos, Mensajería, Logística, Videovigilancia, Atención al Cliente, WorkStation Manager

### Eje Y — Niveles de Profundidad IA
| Nivel | Nombre | Ratio IHA |
|------|-------------------|-------------|
| 1 | Manual | 100% Humano |
| 2 | Asistido | 80% H / 20% IA |
| 3 | Copiloto | 50% H / 50% IA |
| 4 | Automatizado | 20% H / 80% IA |
| 5 | Autónomo | 5% H / 95% IA |

### Eje Z — Escala Operativa (WorkStations)
WorkStation = una sucursal, sede o punto de operación dentro del mismo Workspace Island.

---

## 11. Diccionario de Términos
| Término | Definición |
|---------|-----------|
| ALiaNeD OS | Framework Core de ALiaNeD |
| ALiaNeD | Agencia de IA para emprendedores de la diáspora |
| IHA | Inteligencia Humana Asistida |
| MayordomIA | Marca de servicios de agentes ALiaNeD |
| NemoClaw | Motor de seguridad NVIDIA |
| OpenClaw | Gateway de orquestación de agentes |
| NVIDIA NIM | Motor operativo gratuito de NVIDIA |
| Neurogestor | Banco de datos persistente del ecosistema |

---
*ALiaNeD OS — Protocolo Neurogestor v2.0*
*Producido por ALiaNeD Agency, 2026*
