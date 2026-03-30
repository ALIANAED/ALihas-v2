# TOOLS.md — Herramientas Operativas

## Docker (v2 — Codespace)
```bash
# Ver contenedores
docker ps

# Ver logs de OpenClaw
docker compose logs -f openclaw

# Reiniciar stack
docker compose restart
```

## OpenClaw Dashboard
* URL Codespace: (se genera automáticamente en puerto 8080)
* Puerto: 8080

## Telegram
* Bot: @Alianedbot

## Dokploy (Producción)
* Panel: https://mydokploy.alianed.com

## NVIDIA NIM
* Base URL: https://integrate.api.nvidia.com/v1
* Variable: NVIDIA_API_KEY

## Reglas
* No ejecutar comandos destructivos sin validación
* Preferir pruebas antes de cambios en producción
* Documentar cambios importantes
* NemoClaw Safety Guard siempre activo
