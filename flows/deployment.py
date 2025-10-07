from flows.dbt_sdl_mcc_ref_flow import dbt_sdl_mcc_ref_flow

# Deploy programmatically (register with Prefect server)
dbt_sdl_mcc_ref_flow.deploy(
    name="SDL_MCC_REF Deployment",
    work_queue_name="snowflake"
)
