#!/bin/bash
# Absoluter Pfad zum Projekt
PROJECT_DIR="/Users/dj1dbr/mein_python_projekt/new-trader"

# Alte Prozesse beenden (Backend + Frontend)
echo "Beende alte Instanzen..."
pkill -f "uvicorn server:app" 2>/dev/null
pkill -f "react-scripts start" 2>/dev/null
pkill -f "craco start" 2>/dev/null

# Backend starten
echo "Starte Backend..."
cd "$PROJECT_DIR/backend"
source "$PROJECT_DIR/venv/bin/activate"
uvicorn server:app --host 0.0.0.0 --port 8002 &
BACKEND_PID=$!

# Frontend starten
echo "Starte Frontend..."
cd "$PROJECT_DIR/frontend"
export NVM_DIR="$HOME/.nvm"
[ -s "$NVM_DIR/nvm.sh" ] && source "$NVM_DIR/nvm.sh"
yarn start

# Wenn Frontend beendet wird, Backend stoppen
echo "Beende Backend..."
kill $BACKEND_PID
