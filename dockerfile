FROM python:3.11-slim

WORKDIR /app

# Install compatible Prefect + griffe
RUN pip install --no-cache-dir \
    "prefect==2.14.21" \
    "griffe>=1.13.0" \
    snowflake-connector-python

COPY entrypoint.sh /app/entrypoint.sh
RUN chmod +x /app/entrypoint.sh

EXPOSE 4200
ENTRYPOINT ["/app/entrypoint.sh"]
