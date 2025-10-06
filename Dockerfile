# Base image
FROM python:3.11-bullseye

# Set working directory
WORKDIR /app

# Install build essentials
RUN apt-get update && apt-get install -y build-essential && rm -rf /var/lib/apt/lists/*

# Upgrade pip, setuptools, wheel
RUN python -m pip install --upgrade pip setuptools wheel

# Install Prefect first
RUN pip install --no-cache-dir prefect==2.14.21

# Then explicitly install griffe after Prefect
RUN pip install --no-cache-dir griffe==1.13.0

# Install Snowflake connector
RUN pip install --no-cache-dir snowflake-connector-python

# Copy entrypoint
COPY entrypoint.sh /app/entrypoint.sh
RUN chmod +x /app/entrypoint.sh

# Expose the Prefect Orion UI port
EXPOSE 4200

# Entrypoint for the container
ENTRYPOINT ["/app/entrypoint.sh"]
