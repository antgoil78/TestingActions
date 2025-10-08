# Use official Python 3.11 image
FROM python:3.11-bullseye

WORKDIR /app

RUN python -m pip install --upgrade pip setuptools wheel

RUN pip install --no-cache-dir \
    prefect==3.4.22 \
    snowflake-connector-python

# --- Accept build-time args ---
ARG SNOWFLAKE_USER
ARG SNOWFLAKE_PASSWORD

# --- Set them as environment variables in the container ---
ENV SNOWFLAKE_USER=$SNOWFLAKE_USER
ENV SNOWFLAKE_PASSWORD=$SNOWFLAKE_PASSWORD

COPY entrypoint.sh /app/entrypoint.sh
RUN chmod +x /app/entrypoint.sh

# Copy flows folder into container
COPY flows/ /app/flows/

ENTRYPOINT ["/app/entrypoint.sh"]
