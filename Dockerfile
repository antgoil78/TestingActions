# Base image
FROM python:3.11-bullseye

# Set working directory
WORKDIR /app

# Upgrade pip, setuptools, wheel
RUN python -m pip install --upgrade pip setuptools wheel

# Install Prefect
RUN pip install --no-cache-dir \
    "pydantic==1.10.13" \
    "prefect==2.14.21" \
    "griffe==0.49.0" \

# Copy your entrypoint script
COPY entrypoint.sh /app/entrypoint.sh
RUN chmod +x /app/entrypoint.sh

# Expose the Prefect Orion UI port
EXPOSE 4200

# Entrypoint for the container
ENTRYPOINT ["/app/entrypoint.sh"]
