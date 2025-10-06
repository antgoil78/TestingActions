FROM python:3.11-bullseye
WORKDIR /app

RUN python -m pip install --upgrade pip setuptools wheel

# Prefect 2.14.21 will pull griffe 1.14 automatically
RUN pip install --no-cache-dir \
    prefect==2.14.21 \
    snowflake-connector-python==3.17.4

COPY entrypoint.sh /app/entrypoint.sh
RUN chmod +x /app/entrypoint.sh

EXPOSE 4200

ENTRYPOINT ["/app/entrypoint.sh"]
