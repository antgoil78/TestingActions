FROM python:3.11-bullseye

WORKDIR /app

# Upgrade pip, setuptools, wheel
RUN pip install --upgrade pip setuptools wheel

# Install Prefect, Snowflake connector, and griffe explicitly
RUN pip install --no-cache-dir \
    prefect==2.14.21 \
    griffe>=1.13.0 \
    snowflake-connector-python

# Copy entrypoint and flows
COPY entrypoint.sh /app/entrypoint.sh
RUN chmod +x /app/entrypoint.sh

EXPOSE 4200
ENTRYPOINT ["/app/entrypoint.sh"]
