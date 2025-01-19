# Use Node.js LTS version
FROM node:18.19-bullseye

WORKDIR /app

# Install build essentials
RUN apt-get update && apt-get install -y \
    build-essential \
    python3 \
    && rm -rf /var/lib/apt/lists/*

# First copy and install dependencies
COPY package.json ./
RUN npm install

# Then copy the rest of the code
COPY . .

# Build TypeScript
RUN npm run build

EXPOSE 3000

CMD ["npm", "start"] 