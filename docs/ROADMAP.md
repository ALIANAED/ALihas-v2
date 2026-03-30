# Roadmap del Proyecto ALihas

Este documento traza la evolución cronológica del proyecto ALihas, desde sus orígenes experimentales hasta su arquitectura actual de grado de producción (Sandbox NVIDIA NemoClaw), marcando también el camino a futuro.

---

## Fase 1: Orígenes y Exploración del Ecosistema
*Inicio: Despliegue de los primeros laboratorios y entornos experimentales.*

- **TonyStart Lab:** Despliegue original del repositorio `tonystart_lab` en GitHub Codespaces para entender las bases de los agentes y la configuración inicial de Nemoclaw.
- **Exploración de Modelos Base:**
  - Configuración inicial de *Claude Code* para usar el proveedor local e integrar la API de *MiniMax-M2.7*.
  - Adaptación de variables de entorno (`ANTHROPIC_BASE_URL` a endpoints de MiniMax) para estabilizar la operación del agente antes de integraciones mayores.
- **Hito logrado:** Dominio del despliegue en Codespaces y redirección de APIs para usar LLMs costo-efectivos sin perder potencias analíticas.

---

## Fase 2: Arquitectura y Capa de Seguridad (El Caso NemoClaw)
*Punto de Inflexión: Transformación de un proyecto ágil a una infraestructura blindada.*

- **Análisis de Brecha (Gap Analysis):** Separación y estudio de las diferencias estructurales entre la versión local y simplificada de *ALihas*, y el robusto *repositorio NemoClaw de NVIDIA*.
- **Integración de Políticas (Sandboxing):**
  - Implementación del archivo `openclaw-sandbox.yaml` y un Egress Firewall en modo `strict`.
  - Decisión fundamental: Confinar al agente y evitar que el LLM hable con cualquier endpoint no listado en la *whitelist*.
- **Hito logrado:** Transformación de un entorno de desarrollo a un entorno "Zero Trust" (Confianza Cero), asegurando que los datos de la corporación AlianeD no puedan fugarse de las redes internas o del Codespace.

---

## Fase 3: Productivización y Protocolos de Eficiencia (Estado Actual)
*El Presente: Entorno híbrido, Motor Dual y Control de Herramientas.*

- **Compatibilidad Híbrida (Dokploy + Codespaces):**
  - Orquestación del `docker-compose.yml` para soportar despliegues de producción (mediante `dokploy-network` externo) y despliegues de desarrollo en Codespaces (vía `.devcontainer`).
- **El Protocolo Open Box (MCP Management):**
  - Formalización de una de las normativas operativas más fuertes de AlianeD: *Las cajas de herramientas permanecen cerradas por defecto.*
  - Los agentes se limitan a `search` y `list` inicialmente, activando herramientas completas (como Github o Snyk) solo de forma granular cuando la acción en curso lo demanda, reduciendo la ventana de contexto y alucinaciones.
- **Gestión de Secretos (Misdirection):**
  - Implementación del patrón `.env.example` vs `.env`.
  - El archivo público `.env.example` actúa como plantilla y señuelo (apuntando a configuraciones de OpenAI), mientras que el `.env` real, excluido por Git, contiene las claves corporativas críticas de NVIDIA NIM y el `OPENCLAW_GATEWAY_TOKEN`. Todo bajo el radar.
- **Implementación del Motor Dual NVIDIA (Identity Injection):**
  - **Operativo (`moonshotai/kimi-k2-thinking`):** Uso de LLMs agénticos de alto contexto (256K) y razonamiento entrelazado.
  - **Seguridad (`nemotron-safety-guard`):** Capa de filtrado y aprobación por encima de la inferencia operativa.
- **Hito logrado:** Un workflow desplegado y operativo donde ALihas tiene documentos de identidad formales (`system-prompt`, `safety-rules`, `agent-config`) y un uso de recursos extremadamente calibrado.

### ↳ Resultado Arquitectónico de la Fase 3 (Estructura Actual)
El mapa del repositorio refleja las decisiones anteriores, separando la infraestructura de la inteligencia:
* **`.devcontainer/`**: Habilita la flexibilidad de Codespaces.
* **`identity/`**: Contiene la psique, miedos y capacidades de "Joseias".
* **`policies/`**: Guarda bajo llave el cortafuegos `openclaw-sandbox.yaml`.
* **`.env`** (oculto): Maneja los tokens y el enrutamiento NIM Free.
* **`docs/`**: Preserva esta misma memoria institucional y la guía de traspaso para nuevas IAs.

---

## Fase 4: Despliegue Definitivo y Sub-Agentes (Futuro Inmediato)
*Próximos Pasos: Validar y expandir la corporación.*

- **[ ] Validación final en Codespace:** Confirmar la conectividad, salud del Dashboard y telemetría de todas las variables inyectadas.
- **[ ] Migración a Producción:** Traspasar el estado y repositorio actual validado a la cuenta principal para el despliegue final supervisado por Dokploy.
- **[ ] Ampliación Lateral en OpenRouter:** Construir y desplegar agentes especializados específicos de la clínica y la compañía (Agente Auditor, Agente Creador de Contenido, Agente Analista Clínico) limitados bajo la misma jaula de seguridad pero operados vía saldo de OpenRouter.
- **[ ] Dashboard Múltiple:** Interfaz unificada en Operaciones AlianeD para gestionar a todos los sub-agentes corporativos interactuando entre sí bajo el marco base de ALihas.