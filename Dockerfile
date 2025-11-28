# Use the official Node.js 20 image
FROM node:20 AS base

# Set working directory
WORKDIR /usr/src/app

# Copy the rest of the application code
COPY . .

# Install curl for healthcheck
RUN apt-get update && apt-get install -y curl

# Install pnpm, ts-node and mintlify globally
RUN npm i -g pnpm ts-node mintlify

EXPOSE 3000

WORKDIR /usr/src/app/docs

# Upgrade mint.json to docs.json (required for newer mintlify versions)
RUN mintlify upgrade || true

HEALTHCHECK --interval=30s --timeout=10s --start-period=5s --retries=3 \
  CMD curl -f http://localhost:3000/ || exit 1

ENTRYPOINT ["mintlify", "dev", "--port", "3000", "--no-open"]
