# Use the official Node.js 20 image
FROM node:20 AS base

# Set working directory
WORKDIR /usr/src/app

# Copy the rest of the application code
COPY . .

# Install pnpm, ts-node and mintlify globally
RUN npm i -g pnpm ts-node mintlify

EXPOSE 3003

WORKDIR /usr/src/app/docs

# Upgrade mint.json to docs.json (required for newer mintlify versions)
RUN mintlify upgrade || true

ENTRYPOINT ["mintlify", "dev", "--port", "3003"]
