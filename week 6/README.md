# Week 6 Mini Project: Retail Sales Analytics Pipeline

## Overview
This is an independently written PostgreSQL practice project. It models a small retail
business and demonstrates an ETL-style flow from CSV files into staging tables, dimension
tables, and a partitioned sales fact table.

## Pipeline
1. Create staging, dimension, and fact tables.
2. Load CSV data into staging with `psql \copy`.
3. Upsert customers and products into dimensions.
4. Insert sales into a range-partitioned fact table.
5. Compare query plans with `EXPLAIN ANALYZE`.
6. Apply a second-day customer update.

## Requirements
- PostgreSQL 14 or later
- `psql`

## Run from the project root
Create a database first, for example:
```bash
createdb retail_lab
```
Then execute:
```bash
psql -d retail_lab -f sql/01_create_tables.sql
psql -d retail_lab -f sql/02_stage_csv.sql
psql -d retail_lab -f sql/03_upsert_dimensions.sql
psql -d retail_lab -f sql/04_insert_sales.sql
psql -d retail_lab -f sql/05_indexes_and_stats.sql
psql -d retail_lab -f sql/06_analytics_and_explain.sql
psql -d retail_lab -f sql/07_incremental_customers.sql
```

`\\copy` is a `psql` command and reads files from your local machine. Run these scripts
from the project root so the relative `data/` paths resolve. In pgAdmin, use its Import
feature to load the CSVs instead.

## Concepts demonstrated
- Star-schema basics
- Staging tables and CSV ingestion
- Type 1 dimension upsert
- Range partitioning by transaction date
- Composite indexes and `EXPLAIN ANALYZE`
- Incremental ingestion and basic data-quality checks

## Scope
This is a compact educational example. It implements Type 1 customer updates, not full
SCD Type 2 history. For a production pipeline, add transaction orchestration, logging,
deduplication rules, constraints tailored to source data, and automated integration tests.
