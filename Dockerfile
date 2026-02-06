FROM mwader/static-ffmpeg:latest AS ffmpeg-bin
FROM n8nio/n8n:latest

USER root
COPY --from=ffmpeg-bin /ffmpeg /usr/local/bin/
COPY --from=ffmpeg-bin /ffprobe /usr/local/bin/

# Install the node to /usr/local/lib instead of /home/node/.n8n
# This prevents Railway Volumes from "hiding" the installation
RUN mkdir -p /usr/local/lib/n8n-nodes && \
    cd /usr/local/lib/n8n-nodes && \
    npm init -y && \
    npm install n8n-nodes-ffmpeg && \
    chown -R node:node /usr/local/lib/n8n-nodes

USER node