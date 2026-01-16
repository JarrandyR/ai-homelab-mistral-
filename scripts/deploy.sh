# -------------------------------------------
# AI Homelab Mistral + Open WebUI Deployment
# Infrastructure-as-Code Auto-Deploy Script
# -------------------------------------------


# Exit on error
set -e


# --------- Configurable Variables ---------
IMAGE_NAME="ghcr.io/open-webui/open-webui:main"
CONTAINER_NAME="open-webui"
OLLAMA_PORT=11434
WEBUI_PORT=8080
OLLAMA_BASE_URL="http://127.0.0.1:$OLLAMA_PORT"
DATA_DIR="$HOME/ai-homelab-mistral/data"


# --------- Create Persistent Volume ---------
echo "[+] Creating persistent data volume..."
mkdir -p "$DATA_DIR"


# --------- Pull and Run Container ---------
echo "[+] Deploying container..."
docker run -d \
--name "$CONTAINER_NAME" \
--restart always \
--network host \
-v "$DATA_DIR":/app/backend/data \
-e OLLAMA_BASE_URL="$OLLAMA_BASE_URL" \
"$IMAGE_NAME"


echo "[✔] Open WebUI is now running."
echo "[✔] Access the WebUI: http://localhost:$WEBUI_PORT"
echo "[✔] Connected to Ollama endpoint: $OLLAMA_BASE_URL"
```
