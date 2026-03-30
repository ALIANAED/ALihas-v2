# ALihas-v2 (NemoClaw Architect Edition)

ALihas-v2 es la evolución del framework de agentes inteligentes de AlianeD OS. Esta versión unifica la agilidad de desarrollo en la nube con el núcleo de seguridad restrictivo **Zero Trust** de NVIDIA NemoClaw.

---

## 🏗️ Estado Actual y Arquitectura (Fase 3)

Actualmente, ALihas opera bajo un modelo híbrido comprobado: listo para desarrollarse en GitHub Codespaces y preparado para saltar a producción en Dokploy.

### 1. El Motor Dual (NVIDIA NIM Free)
Hemos implementado una estrategia de inferencia fraccionada para maximizar la seguridad y el razonamiento sin incurrir en costos de contexto excesivos:
*   🧠 **Motor Operativo:** `moonshotai/kimi-k2-thinking` (256K tokens, especializado en uso de herramientas y llamadas agénticas).
*   🛡️ **Motor Ético (Firewall):** `nvidia/llama-3.1-nemotron-safety-guard-8b-v3` (Evalúa y bloquea inputs/outputs de comportamiento riesgoso).

### 2. Identidad y Regulación (La Carpeta `identity/`)
El comportamiento de nuestra IA (alias *Joseias*) ya no depende de configuraciones triviales. La carpeta `identity/` almacena su **System Prompt corporativo**, su archivo de configuración primario (`agent-config.json`) y las **reglas inquebrantables de seguridad**.

### 3. Aislamiento de Red (La Carpeta `policies/`)
Implementamos el modo `NEMOCLAW_POLICY_MODE=strict`. El agente está confinado en `openclaw-sandbox.yaml`. Todas las llamadas externas no listadas en ese archivo mueren en la jaula, mitigando cualquier riesgo de fuga de datos.

---

## 📚 Documentación de Referencia

Para entender a fondo de dónde venimos, la topología exacta del proyecto y los protocolos internos (como el **Protocolo Open Box**), consulta la carpeta `docs/`, donde encontrarás:

*   📖 [`docs/ROADMAP.md`](docs/ROADMAP.md) - Línea del tiempo del proyecto (Qué se hizo y qué falta).
*   🧠 [`docs/PROJECT_ANALYSIS.md`](docs/PROJECT_ANALYSIS.md) - Lecciones aprendidas, justificaciones de la arquitectura actual y moralejas tecnológicas.
*   🤖 [`docs/AGENT.md`](docs/AGENT.md) - Ficha técnica de Joseias (Roles, capacidades y reglas).
*   🗺️ [`docs/AGENT_HANDOFF.md`](docs/AGENT_HANDOFF.md) - Guía mapa para nuevos ingenieros o inteligencias artificiales entrantes para que comprendan rápidamente el código base.

---

## 🚀 Despliegue Híbrido: Codespace y Dokploy

### Opción A: GitHub Codespace (Desarrollo Seguro)
1. Abre un **Codespace** desde este repositorio en la rama principal.
2. El entorno ejecutará automáticamente `.devcontainer/post-create.sh`, creando las redes Docker de simulación y encendiendo el stack.
3. Copia `.env.example` a un nuevo archivo `.env` e inyecta tus **API Keys reales** de NVIDIA.
4. El Dashboard estará disponible automáticamente en el puerto `8080`.

### Opción B: Dokploy (Producción)
1. Añade este repositorio a tu panel de Dokploy seleccionando la opción **Compose**.
2. Vincula el **Git Repository** a la URL de GitHub.
3. Dokploy creará automáticamente las redes necesarias (ej. `dokploy-network`).
4. Ve a la pestaña de **Environment** en Dokploy e inyecta las variables de entorno reales.
5. Haz clic en **Deploy**. El motor NemoClaw levantará las reglas del sandbox desde los volúmenes configurados.

---

## 🔮 Lo que falta por construir (Fase 4)
Nuestro próximo gran salto expandirá el marco actual para incluir **Sub-Agentes Especializados** (Auditor, Marketing, Analista de Datos). Estos vivirán dentro de este mismo ecosistema seguro, pero utilizarán **OpenRouter (Pay-per-use)** para aprovechar modelos variados y delegarse tareas bajo la supervisión de Joseias. (Ver [ROADMAP](docs/ROADMAP.md) para más detalles).