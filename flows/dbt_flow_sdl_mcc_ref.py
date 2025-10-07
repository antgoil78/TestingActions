from prefect import flow, task
import snowflake.connector

# ---------------------------
# Task to run dbt model in Snowflake
# ---------------------------
@task
def run_dbt_model():
    conn = snowflake.connector.connect(
        user="YOUR_USER",
        password="YOUR_PASSWORD",
        account="YOUR_ACCOUNT",
        warehouse="YOUR_WAREHOUSE",
        database="KUMO_DEV",
        schema="DBT"
    )
    
    cs = conn.cursor()
    try:
        # Run only SDL_MCC_REF model in the Snowflake dbt project
        cs.execute(
            'EXECUTE DBT PROJECT "KUMO_DEV"."DBT"."DBT_KUMO_DEV" '
            'args=\'run --models SDL_MCC_REF --target dev\';'
        )
        print("SDL_MCC_REF model executed successfully")
    finally:
        cs.close()
        conn.close()


# ---------------------------
# Prefect Flow
# ---------------------------
@flow(name="DBT SDL_MCC_REF Flow")
def dbt_sdl_mcc_ref_flow():
    run_dbt_model()


# For local testing
if __name__ == "__main__":
    dbt_sdl_mcc_ref_flow()
