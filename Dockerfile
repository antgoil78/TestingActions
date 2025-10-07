# Use official Python 3.11 image
FROM python:3.11-bullseye

# Set working directory
WORKDIR /app

# Upgrade pip
RUN python -m pip install --upgrade pip setuptools wheel

# Install Prefect 3 and Snowflake connector
RUN pip install --no-cache-dir \
    prefect==3.4.22 \
    snowflake-connector-python

# Copy entrypoint script
COPY entrypoint.sh /app/entrypoint.sh
RUN chmod +x /app/entrypoint.sh

# Expose Prefect server UI port (optional, for local dev/testing)
EXPOSE 4200

# Entrypoint
ENTRYPOINT ["/app/entrypoint.sh"]
