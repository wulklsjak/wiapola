# Use the official Node.js environment
FROM node:20-slim

# Set the working directory inside the container
WORKDIR /app

# Copy package.json and install dependencies
COPY package*.json ./
RUN if [ -f package.json ]; then npm install; fi

# Copy your script and config files into the container
COPY . .

# --- ZYTE WORKAROUND ---
# Create a dummy list-spiders command that outputs "custom_script" 
# This prevents Zyte from crashing during the final deployment check.
RUN echo '#!/bin/sh\necho "custom_script"' > /usr/local/bin/list-spiders && \
    chmod +x /usr/local/bin/list-spiders
# -----------------------

# Tell Zyte what command to execute when the container starts
CMD ["node", "./cli.cjs", "--config", "./config.json"]
