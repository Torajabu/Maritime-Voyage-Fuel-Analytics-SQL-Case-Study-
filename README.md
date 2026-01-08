# Maritime Voyage Fuel Analytics (SQL Case Study)

## Overview

This project is a **relational SQL analytics case study** focused on analyzing ship voyages and fuel consumption to evaluate operational efficiency across fleets, routes, and time periods.

The objective is to demonstrate:

* Relational schema design
* CSV data ingestion using MySQL
* Analytical SQL querying (joins, aggregations, window functions, subqueries)
* Translating operational data into measurable insights

The project is implemented using **MySQL 8.0**.

---

## Problem Statement

Shipping operations generate large volumes of structured data related to:

* Ships and their characteristics
* Routes between ports
* Voyages undertaken over time
* Fuel consumption and emissions

From an analytics perspective, key business questions include:

* Which ship types consume more fuel?
* How does ship age affect efficiency?
* Which routes contribute most to emissions?
* How do voyage volumes change over time?

This project models these questions using a normalized relational schema and SQL-based analysis.

---

## Data Model

The database consists of **three core entities**:

* **Ships** – static information about vessels
* **Routes** – port-to-port route definitions
* **Voyages** – operational records linking ships and routes over time

### Entity Relationship Design

**(ER diagram – original version, before later refinements)**

* One ship can have many voyages
* One route can be used by many voyages
* Each voyage references exactly one ship and one route

This design avoids redundancy and supports scalable analytical queries.

---

## Schema Definition

### `ships`

| Column        | Type         | Description                |
| ------------- | ------------ | -------------------------- |
| ship_id       | INT (PK)     | Unique ship identifier     |
| ship_name     | VARCHAR(100) | Ship name                  |
| ship_type     | VARCHAR(50)  | Type (e.g., Tanker, Cargo) |
| build_year    | INT          | Year built                 |
| capacity_tons | INT          | Cargo capacity in tons     |

---

### `routes`

| Column           | Type         | Description                |
| ---------------- | ------------ | -------------------------- |
| route_id         | INT (PK)     | Unique route identifier    |
| origin_port      | VARCHAR(100) | Origin port                |
| destination_port | VARCHAR(100) | Destination port           |
| distance_nm      | INT          | Distance in nautical miles |

---

### `voyages`

| Column        | Type          | Description                   |
| ------------- | ------------- | ----------------------------- |
| voyage_id     | INT (PK)      | Unique voyage identifier      |
| ship_id       | INT (FK)      | References `ships(ship_id)`   |
| route_id      | INT (FK)      | References `routes(route_id)` |
| voyage_date   | DATE          | Date of voyage                |
| fuel_consumed | DECIMAL(10,2) | Fuel consumed                 |
| co2_emissions | DECIMAL(12,2) | CO₂ emissions                 |

---

## Data Ingestion

Data is loaded from CSV files using **`LOAD DATA LOCAL INFILE`**, which is efficient for bulk ingestion.

Files:

* `ships.csv`
* `routes.csv`
* `voyages.csv`

The ingestion process:

* Skips header rows
* Explicitly maps CSV columns to table columns
* Assumes `local_infile` is enabled in MySQL

This approach mirrors real-world ETL ingestion patterns for structured operational data.

---

## Analytical Queries

The project includes **23 read-only analytical SQL queries**, covering:

### Basic Analysis

* Filtering ships by build year
* Sorting by capacity
* Pattern matching on ship names

### Aggregations

* Average fuel consumption
* Total voyages per ship
* Monthly and yearly voyage counts

### Multi-Table Joins

* Voyage details enriched with ship and route metadata
* Emissions analysis by ship type

### Advanced SQL

* Window functions (`ROW_NUMBER`, `RANK`)
* Correlated subqueries
* Conditional logic using `CASE`
* Time-based analysis using `YEAR()` and `MONTH()`

All queries are designed to be **non-destructive** and suitable for analytics use cases.

---

## Sample Business Questions Answered

* Which ship types contribute the most to CO₂ emissions?
* How many voyages does each ship complete?
* Which routes are the longest by distance?
* Are certain ships consistently less fuel-efficient than their peers?
* How does voyage volume vary by year and month?

---

## Key Observations (Data-Driven)

* Fuel consumption varies significantly across ship types.
* A subset of long-distance routes accounts for a disproportionate share of total emissions.
* Older ships generally show higher fuel usage per voyage.
* Voyage activity exhibits clear time-based patterns when grouped by year and month.

*(All observations are derived directly from SQL query outputs.)*

---

## Tools & Technologies

* **Database:** MySQL 8.0
* **Language:** SQL
* **Modeling:** Relational schema with foreign keys
* **Data Source:** CSV files
* **Techniques:** Joins, aggregations, window functions, subqueries, date-based analytics

---

## Project Structure

```
maritime-voyage-fuel-analytics/
│
├── data/
│   ├── ships.csv
│   ├── routes.csv
│   └── voyages.csv
│
├── sql/
│   ├── table_creation.sql
│   ├── load_data.sql
│   └── analysis_queries.sql
│
└── README.md
```

---

## Limitations

* Data represents a modeled dataset rather than live operational feeds.
* Emissions values are treated as given inputs and not derived from physical fuel formulas.
* The project focuses on SQL analytics and does not include visualization layers.

---

## Possible Extensions

* Add indexes for performance optimization analysis
* Introduce voyage duration and speed metrics
* Integrate BI tools (Power BI / Tableau) for visualization
* Extend schema to include ports or fuel pricing data

---

## Author

**Rajabudeen Ahamed M**
SQL & Data Analytics Project
MySQL 8.0

---
