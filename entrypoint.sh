#!/bin/bash
set -e

echo "Starting Prefect 3 Server..."
prefect server start --host 127.0.0.1 --port 4200
