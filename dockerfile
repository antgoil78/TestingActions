FROM python:3.11-slim

# Install system deps (dbt needs gcc, libpq, etc.)
RUN apt-get update && apt-get install -y \
    build-essential \
    git \
    libpq-dev \
    && rm -rf /var/lib/apt/lists/*

# Install Prefect & dbt
RUN pip install --no-cache-dir prefect==2.13.0 dbt-snowflake==1.8.0

# Default command (can be overridden)
CMD ["prefect", "version"]
