FROM n8nio/n8n:latest

USER root

# Install ffmpeg binary
RUN apt-get update && apt-get install -y ffmpeg && rm -rf /var/lib/apt/lists/*

# Install n8n-nodes-ffmpeg as a community node
RUN mkdir -p /home/node/.n8n/nodes && \
    cd /home/node/.n8n/nodes && \
    npm install n8n-nodes-ffmpeg && \
    chown -R node:node /home/node/.n8n

USER node