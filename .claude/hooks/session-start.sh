#!/bin/bash
# SkinSensor Project — Claude Code Session Start Hook
# Runs on Claude Code web sessions to set up the Python environment

set -euo pipefail

# Only run in remote (web) sessions
if [ "${CLAUDE_CODE_REMOTE:-}" != "true" ]; then
  exit 0
fi

echo "=== SkinSensor: Setting up Python environment ==="

# Install core data science & sensor analysis packages
pip install --quiet --break-system-packages \
  numpy \
  pandas \
  matplotlib \
  scipy \
  scikit-learn \
  streamlit \
  pyserial \
  jupyter \
  ipykernel \
  requests \
  python-dotenv

# Set PYTHONPATH so project modules resolve correctly
echo 'export PYTHONPATH="${CLAUDE_PROJECT_DIR}:${PYTHONPATH:-}"' >> "$CLAUDE_ENV_FILE"

echo "=== SkinSensor: Environment ready ==="
