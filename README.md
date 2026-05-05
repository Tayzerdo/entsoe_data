⚡ ENTSO-E Power Statistics ETL

A modern data engineering project building a robust ETL pipeline to extract, transform, and model European power system data.



🏗️ Project Architecture

This project implements a modular data stack:

Extraction: Python scripts fetching data from the [ENTSO-E Power Statistics](https://www.entsoe.eu/data/power-stats/) portal.

Storage: DuckDB as a high-performance, local analytical database (OLAP).

Transformation: dbt (data build tool) for modeling, testing, and documenting the data lifecycle.



📊 Data Catalog

The pipeline processes five core datasets to provide a 360-degree view of the European grid:

1. Actual Generation & Consumption
- Monthly Domestic Values: Tracks actual energy production output across fuel types (Wind, Solar, Nuclear, etc.) per country.

- Physical Energy & Power Flows: Documents cross-border electricity exchanges (imports/exports) between interconnected countries.

2. Infrastructure & Capacity
- Net Generating Capacity: Represents the maximum theoretical output (MW) energy assets can deliver to the grid.

- Inventory of Generation: A detailed yearly breakdown of physical generation units and capacities aggregated by country.

- Inventory of Transmission: Catalogs the physical grid assets, including circuit and route lengths across different voltage levels.