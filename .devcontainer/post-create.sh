#!/bin/bash
# ════════════════════════════════════════════════════════════════════
# ALihas-v2 — Codespace Bootstrap Script
# ════════════════════════════════════════════════════════════════════
set -e
echo "🔧 ALihas-v2: Iniciando configuración del entorno..."

echo "📡 Verificando redes Docker..."
for NET in dokploy-network core-agentes-net mayordomia-net vector-net humandata-net gateway-net observability-net; do
  docker network inspect $NET >/dev/null 2>&1 || \
    docker network create $NET && echo "  ✅ $NET lista"
done

if [ ! -f .env ]; then
  echo "📋 Creando .env desde .env.example..."
  cp .env.example .env
  echo "  ⚠️  IMPORTANTE: Edita .env con tus claves API reales"
else
  echo "  ✅ .env ya existe"
fi

echo "🚀 Levantando contenedores ALihas-v2..."
docker compose up -d

echo ""
echo "════════════════════════════════════════════════════"
echo "  ✅ ALihas-v2 desplegado exitosamente"
echo "  🌐 Dashboard: http://localhost:8082"
echo "  🔑 Login: admin / (ver .env AUTH_PASSWORD)"
echo "  🛡️  Modo: NemoClaw Strict Policy"
echo "════════════════════════════════════════════════════"
