#!/bin/bash

# Exit immediately if a command exits with a non-zero status.
set -e

# Install dependencies using pnpm
pnpm install

# Build the application
pnpm run build

# Start the Node.js server produced by SvelteKit's adapter-node
# The server will respect the PORT environment variable set by the deployment environment.
node build/index.js
