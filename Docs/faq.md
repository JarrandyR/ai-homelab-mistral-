#  Frequently Asked Questions (FAQ)

This section answers common questions and helps troubleshoot issues with the AI Homelab Assistant project.

---

## 🔧 I ran `bash scripts/deploy.sh` but got `docker: command not found`

This means Docker isn’t installed or isn’t available in your system path.

### ✅ Fix:
- **Ubuntu/Debian-based**:
  ```bash
  sudo apt update
  sudo apt install docker.io
  sudo systemctl enable docker
  sudo systemctl start docker
Windows:

Install Docker Desktop

Ensure “WSL 2 backend” is enabled during setup

🌐 I can't access the AI assistant from my main computer (only from inside the VM)
Make sure your VM is set to Bridged Adapter in VirtualBox. This gives it an IP address on your local network.

✅ Fix:
Shutdown the VM

Go to Settings > Network > Adapter 1

Set:

Attached to: Bridged Adapter

Name: Your Wi-Fi/Ethernet card

Boot the VM and run:

ip a | grep inet
Look for something like: 192.168.1.x and access it via that IP in your browser.

🔒 Can I add password protection to the Web UI?
Out of the box, Open WebUI doesn't ship with authentication. You can secure access by placing it behind:

A reverse proxy like NGINX or Caddy with basic auth

Authelia, OAuth2-Proxy, or Traefik Forward Auth for SSO

This is optional but recommended for shared environments.

💾 Where is the data stored?
The container creates a Docker volume named open-webui, which persists all chat history, settings, and uploads even if you stop/restart the container.

To view:

docker volume ls
🧹 How do I reset everything?
If you want to completely reset the setup (including history):

docker rm -f open-webui
docker volume rm open-webui
Then rerun:

bash scripts/deploy.sh
How do I change the model being used?
If you're using Ollama locally, modify the OLLAMA_BASE_URL environment variable in the deploy.sh script:

-e OLLAMA_BASE_URL=http://127.0.0.1:11434
Then restart the container.

 How do I update to the latest version?
Pull the latest image from GitHub Container Registry:

docker pull ghcr.io/open-webui/open-webui:main
Then redeploy using the script.

⚙️ Can I modify the web interface?
Yes! Once deployed, Open WebUI’s frontend is accessible inside the container. To enter the container:

docker exec -it open-webui bash
From there, you can explore /app and customize as needed.

📢 Something’s broken and I’m stuck
Don’t worry — open an issue on the GitHub repo and include:

Terminal output or error message

OS + version

Docker version

Or just email me at jarrandyr11@gmail.com if it's critical.
