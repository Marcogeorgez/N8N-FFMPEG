FROM n8nio/n8n:latest

USER root

# Install ffmpeg binary 
RUN apk update && apk add --no-cache ffmpeg

# Install n8n-nodes-ffmpeg as a community node
RUN mkdir -p /home/node/.n8n/nodes && \
    cd /home/node/.n8n/nodes && \
    npm install n8n-nodes-ffmpeg && \
    chown -R node:node /home/node/.n8n

USER node