#!/bin/sh
set -e
echo "🚀 Starting Sanadmin Backend..."

if [ ! -d "build" ]; then
  echo "❌ Error: build directory missing. Build command failed or did not run."
  exit 1
fi

HOST=0.0.0.0 node build/index.js
