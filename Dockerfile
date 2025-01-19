# Use Node.js LTS version
FROM node:18.19-bullseye

WORKDIR /app

# Install build essentials
RUN apt-get update && apt-get install -y \
    build-essential \
    python3 \
    && rm -rf /var/lib/apt/lists/*

# Copy package files
COPY package*.json ./
COPY tsconfig.json ./

# Install dependencies with clean install
RUN npm cache clean --force && \
    npm install

# Copy source code
COPY . .

# Build TypeScript
RUN npm run build

EXPOSE 3000

CMD ["npm", "start"] 