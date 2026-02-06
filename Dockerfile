FROM n8nio/n8n:latest

USER root

# Install ffmpeg - try multiple package managers
RUN if command -v apk >/dev/null 2>&1; then \
        apk update && apk add --no-cache ffmpeg; \
    elif command -v apt-get >/dev/null 2>&1; then \
        apt-get update && apt-get install -y ffmpeg && rm -rf /var/lib/apt/lists/*; \
    else \
        echo "No package manager found"; exit 1; \
    fi

# Install n8n-nodes-ffmpeg as a community node
RUN mkdir -p /home/node/.n8n/nodes && \
    cd /home/node/.n8n/nodes && \
    npm install n8n-nodes-ffmpeg && \
    chown -R node:node /home/node/.n8n

USER node