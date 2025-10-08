import os
import snowflake.connector
from prefect import task

@task(retries=2, retry_delay_seconds=60)
def run_dbt_models(models: list[str]):
    conn = snowflake.connector.connect(
        user=os.getenv("SNOWFLAKE_USER"),
        password=os.getenv("SNOWFLAKE_PASSWORD"),
        account=os.getenv("SNOWFLAKE_ACCOUNT"),
        warehouse=os.getenv("SNOWFLAKE_WAREHOUSE"),
        database=os.getenv("SNOWFLAKE_DATABASE"),
        schema=os.getenv("SNOWFLAKE_SCHEMA"),
    )

    with conn.cursor() as cs:
        model_args = " ".join(models)
        cs.execute(
            f'EXECUTE DBT PROJECT "KUMO_DEV"."DBT"."DBT_KUMO_DEV" '
            f"args='run --models {model_args} --target dev';"
        )
    print(f"✅ Successfully ran dbt models: {models}")
