# Use Node.js LTS version
FROM node:18.19-bullseye

WORKDIR /app

# Install build essentials
RUN apt-get update && apt-get install -y \
    build-essential \
    python3 \
    && rm -rf /var/lib/apt/lists/*

# First copy both package files
COPY package*.json ./

# Install dependencies with production flag
RUN npm install --production=false --legacy-peer-deps

# Copy TypeScript config
COPY tsconfig.json ./

# Then copy the rest of the code
COPY . .

# Build TypeScript
RUN npm run build

EXPOSE 3000

CMD ["npm", "start"] 