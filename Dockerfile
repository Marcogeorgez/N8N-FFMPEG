# Stage 1: Get the ffmpeg binary
FROM mwader/static-ffmpeg:latest AS ffmpeg-bin

# Stage 2: Build the n8n image
FROM n8nio/n8n:latest

USER root

# Copy ffmpeg from the first stage to the n8n image
COPY --from=ffmpeg-bin /ffmpeg /usr/local/bin/
COPY --from=ffmpeg-bin /ffprobe /usr/local/bin/

# Ensure permissions for the community nodes directory
RUN mkdir -p /home/node/.n8n/nodes && \
    chown -R node:node /home/node/.n8n

USER node

# Install the community node
RUN cd /home/node/.n8n/nodes && \
    npm install n8n-nodes-ffmpeg