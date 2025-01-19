FROM node:16-alpine

WORKDIR /app

# Install build dependencies
RUN apk add --no-cache python3 make g++

# Copy package files
COPY package*.json ./
COPY tsconfig.json ./

# Install dependencies
RUN npm install --legacy-peer-deps

# Copy source code
COPY . .

# Create dist directory
RUN mkdir -p dist

# Build TypeScript
RUN npx tsc

EXPOSE 3000

CMD ["npm", "start"] 