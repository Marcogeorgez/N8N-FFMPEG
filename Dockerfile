FROM node:22-alpine AS builder
RUN apk add --no-cache python3 make g++ && \
    mkdir -p /out && cd /out && \
    npm init -y && \
    npm install n8n-nodes-ffmpeg

FROM mwader/static-ffmpeg:latest AS ffmpeg-bin
FROM n8nio/n8n:latest

USER root
COPY --from=ffmpeg-bin /ffmpeg /usr/local/bin/
COPY --from=ffmpeg-bin /ffprobe /usr/local/bin/
COPY --from=builder /out /usr/local/lib/n8n-nodes
RUN chown -R node:node /usr/local/lib/n8n-nodes

ENV N8N_CUSTOM_EXTENSIONS=/usr/local/lib/n8n-nodes/node_modules/n8n-nodes-ffmpeg

USER node
