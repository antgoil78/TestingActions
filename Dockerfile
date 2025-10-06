# Base image
FROM python:3.11-bullseye

# Set working directory
WORKDIR /app

# Upgrade pip, setuptools, wheel
RUN python -m pip install --upgrade pip setuptools wheel

# Install Prefect and Griffe
RUN pip install --no-cache-dir \
    prefect==2.16.7 \
    griffe==1.14.0 \
    snowflake-connector-python

# Copy your entrypoint script
COPY entrypoint.sh /app/entrypoint.sh
RUN chmod +x /app/entrypoint.sh

# Expose the Prefect Orion UI port
EXPOSE 4200

# Entrypoint for the container
ENTRYPOINT ["/app/entrypoint.sh"]
