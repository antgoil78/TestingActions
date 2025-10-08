from prefect import flow
from flows.utils.dbt_tasks import run_dbt_models

@flow(name="DBT Cust Flow")
def dbt_cust_flow():
    sdl_cust001 = run_dbt_models.submit(["SDL_CUST001", "raw_cust"])
    sdl_cust002 = run_dbt_models.submit(["SDL_CUST002"], wait_for=[sdl_cust001])
    sdl_cust024 = run_dbt_models.submit(["SDL_CUST024"], wait_for=[sdl_cust002])

if __name__ == "__main__":
    dbt_cust_flow()
