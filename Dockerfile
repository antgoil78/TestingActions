# Base image
FROM python:3.11-bullseye

# Set working directory
WORKDIR /app

# Upgrade pip, setuptools, wheel
RUN python -m pip install --upgrade pip setuptools wheel

# Install Prefect
RUN pip install --no-cache-dir \
    prefect==3.0.0rc10 \
    snowflake-connector-python

# Copy your entrypoint script
COPY entrypoint.sh /app/entrypoint.sh
RUN chmod +x /app/entrypoint.sh

# Expose the Prefect Orion UI port
EXPOSE 4200

# Entrypoint for the container
ENTRYPOINT ["/app/entrypoint.sh"]
