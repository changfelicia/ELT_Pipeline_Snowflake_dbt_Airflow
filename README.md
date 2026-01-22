# ELT Pipeline: Snowflake, dbt, and Airflow

## Project Overview
This project demonstrates a production-grade ELT (Extract, Load, Transform) pipeline leveraging Snowflake as the data warehouse, dbt (data build tool) for transformation logic, and Apache Airflow (via Astronomer) for orchestration.

## Tech Stack
Data Warehouse: Snowflake

Transformation: dbt Core (v1.11+)

Orchestration: Apache Airflow (Astro CLI)

Data Models: SQL (Jinja-templated)

## Architecture & Data Modeling
The project follows a multi-layered Medallion Architecture to ensure data integrity and reusability:

Staging Layer (stg_): Initial cleanup of raw TPC-H Snowflake sample source data. Renamed columns for readability and cast data types.

Intermediate Layer (int_): Performed complex joins (e.g., joining orders and line items) and applied business logic using dbt macros for DRY (Don't Repeat Yourself) code.

Mart Layer (fct_): Final fact tables optimized for BI tools, aggregating key metrics like gross sales and discount amounts.

## Key Features
Custom Macros: Developed a reusable pricing macro to handle complex decimal calculations across different models.

Data Quality Testing:

- Generic Tests: Implemented unique, not_null, relationships, and accepted_values tests in YAML.

- Singular Tests: Created custom SQL tests to validate business logic, such as ensuring discount amounts are never negative.

Containerized Orchestration: Wrapped the dbt project in a Virtual Environment within a Dockerized Airflow instance using Astronomer Cosmos for seamless task execution.

## Snowflake Setup
Create an account in Snowflake and enable appropriate permission. Use the provided SQL scripts in /setup to configure the warehouse, database, and role.

## dbt (Core) Setup
To initialize the transformation layer, the following environment setup was performed:

python3 -m pip install dbt-snowflake: Installs the Snowflake Adapter. This is the specialized "translator" that allows dbt to communicate with Snowflake's specific SQL dialect and architecture. Using the python3 -m prefix ensures the package is mapped to the correct local Python interpreter.

pip3 install dbt-core: Installs the primary dbt Engine. This handles the core logic of the framework, including dependency resolution, macro parsing, and the ref() function mapping.

## AirFlow Setup (Deployment)

After development is completed, a pipeline also requires Deployment to enable automated data delivery.

I utilized Apache Airflow as the orchestrator to manage the end-to-end lifecycle of the ELT process. With Airflow, we can achieve automated scheduling, dependency management, and helps to handle retries.

Astro CLI:

Bash

astro dev start
dbt Connectivity: Ensure your Snowflake Connection is configured in the Airflow UI (snowflake_conn).

## Acknowledgments
This project was built as a guided implementation based on a technical reference architecture provided by Jayzern (an industry-leading Analytics Engineering resource).