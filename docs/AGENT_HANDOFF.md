# Memoria y Guía de Transferencia (Agent Handoff Guide)

> [!IMPORTANT]
> **Aviso para Inteligencias Artificiales y Agentes:** 
> Si estás leyendo esto como tu primer paso de análisis en el directorio `ALihas-v2`, este documento es tu **Punto de Restauración Cognitiva**. Contiene el mapeo exacto de la arquitectura del proyecto y las últimas modificaciones operativas para que puedas continuar el desarrollo sin requerir que el usuario te repita el contexto.

---

## 1. Estado Actual y Memoria Reciente
**Objetivo de la última sesión (Marzo 2026):**
Se migró la arquitectura inicial hacia un ecosistema asegurado por *NemoClaw (strict policy)* y se ajustó para ser compatible tanto con servidores de producción (Dokploy) como con entornos en la nube efímeros (GitHub Codespace).

**Logros Técnicos Establecidos:**
- **Pila de Motores:** Configurada para funcionar mediante `NVIDIA NIM Free`. El rol operativo primario lo cubre `kimi-k2-thinking` (contexto 256K, especializado en razonamiento agéntico entrelazado). El firewall ético lo cubre `nemotron-safety-guard`. Los agentes adicionales (auditor, marketing) se derivan hacia `OpenRouter` bajo demanda.
- **Gestión Avanzada de Ciclos de Vida (MCPs):** Optimización severa de agentes donde el flujo de herramientas de servidor (MCPs) se habilita y deshabilita dinámicamente según un marco de necesidad estricta para evitar la penalización de carga semántica innecesaria en la inferencia.
- **Autosetup UI/Code:** Se crearon los archivos Docker-in-Docker para GitHub Codespaces (`.devcontainer`) asegurando que cualquier ingeniero o IA que clone el proyecto pueda levantar Compose sin pelear con problemas de redes externas.

---

## 2. Mapa Estructural de Directorios (Tree)

La raíz del proyecto está organizada modularmente para separar la infraestructura base de la identidad de la IA. No debes modificar los archivos `policies/`, `identity/` ni el bloque del volumen de base de datos (`joseias-data`) del `docker-compose.yml` sin la autorización explícita del Arquitecto CEO (Arismendy).

```text
ALihas-v2/
├── .agents/                 # Scripts/metadatos para ejecución de herramientas y subagentes de fondo.
├── .claude/                 # Configuración de los asistentes locales. Contiene el claude.json dictando el comportamiento base.
├── .devcontainer/           # Archivos vitales para GitHub Codespace. 
│   ├── devcontainer.json    # Habilita Docker-in-Docker.
│   └── post-create.sh       # Script bash que crea las redes (dokploy-network, core-agentes-net), auto-copia .env.example y levanta los recursos interactivos.
├── docs/                    # (ESTA CARPETA) Memoria institucional y retrospectivas de ALihas.
│   ├── ROADMAP.md           # Hitos y evolución del desarrollo.
│   ├── PROJECT_ANALYSIS.md  # Lecciones, moralejas del Protocolo Open Box y filosofía "Zero Trust".
│   ├── AGENT.md             # Ficha técnica del agente principal ALihas/Joseias.
│   └── AGENT_HANDOFF.md     # <- Estás aquí leyendo.
├── identity/                # **Carpeta Sensible**: Define la psicología y configuración del agente.
│   ├── system-prompt.md     # Misión, modales y origen corporativo del robot.
│   ├── agent-config.json    # Declaración de APIs, estructura NVIDIA NIM, contexto y reglas.
│   └── safety-rules.md      # Extracto dictatorial sobre lo que NO puede hacer.
├── policies/                # **La Jaula Egress**: Nivel hipervisor de red.
│   └── openclaw-sandbox.yaml # Firewall estricto. (Sufre crash en Docker si el host intenta comunicarse con algo no listado aquí).
├── .env.example             # Plantilla dummy engañosa (apunta a OpenAI, pero el plan real es usar NIM). Las variables reales van en el `.env` (oculto en .gitignore).
├── docker-compose.yml       # Orquestador del núcleo (Nemoclaw/OpenClaw base, browser subagent activo).
└── README.md                # Entrada para clientes humanos sobre cómo usar este repo.
```

---

## 3. Guía de Ejecución Rápida
Si estás comisionado para depurar la aplicación o continuar trabajos:
1. **No ejecutes `npm run` ni `python`**. El núcleo de esto es puro Docker Compose (`docker compose up -d`). Toda la magia sucede en la inferencia LLM y las inyecciones de las políticas.
2. Si el contenedor crashea inmediatamente bajo el estado **"Disconnected from Gateway"**, revisa que estés inyectando `OPENCLAW_GATEWAY_TOKEN` correctamente desde el `.env`.
3. Para expandir las capacidades de la IA o de un sub-agente, consulta los archivos ubicados en `identity/`.
4. Si requieres acceso a un nuevo proveedor web (ej. `api.mi-nuevo-servicio.com`), **debes agregarlo primero** a `policies/openclaw-sandbox.yaml`, de lo contrario, el sandbox asfixiará la petición en silencio.