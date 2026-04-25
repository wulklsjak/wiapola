# Use the official Node.js environment
FROM node:20-slim

# Set the working directory inside the container
WORKDIR /app

# Copy package.json and install dependencies (if you have them)
COPY package*.json ./
RUN if [ -f package.json ]; then npm install; fi

# Copy your script and config files into the container
COPY . .

# Tell Zyte what command to execute when the container starts
CMD ["node", "./cli.cjs", "--config", "./config.json"]
