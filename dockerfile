FROM python:3.11-slim

WORKDIR /app
RUN pip install --no-cache-dir prefect==2.14.21 snowflake-connector-python

COPY entrypoint.sh /app/entrypoint.sh
RUN chmod +x /app/entrypoint.sh

EXPOSE 4200
ENTRYPOINT ["/app/entrypoint.sh"]

