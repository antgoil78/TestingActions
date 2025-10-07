from prefect.deployments import Deployment
from dbt_sdl_mcc_ref_flow import dbt_sdl_mcc_ref_flow

# Build a deployment so the flow shows in the UI
Deployment.build_from_flow(
    flow=dbt_sdl_mcc_ref_flow,
    name="SDL_MCC_REF Deployment",
    work_queue_name="snowflake"
)
