#!/bin/bash

echo "Running with node $(node --version) and npm $(npm --version)"

cd /app/node

echo "Installing node dependencies"
npm install
echo "Executing Apollo server in the background"
npm start &

echo "Returning execution to Nginx"
exec "$@"