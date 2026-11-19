-- =====================================================================
-- 01 | Star schema of the synthetic sales data (schema "sales")
--
-- Created in the same database as the reference project (geo_reference),
-- so the stores can be linked to the real postal codes.
-- =====================================================================

CREATE EXTENSION IF NOT EXISTS postgis;

DROP SCHEMA IF EXISTS sales CASCADE;
CREATE SCHEMA sales;

-- ---------------------------------------------------------------------
-- Dimensions
-- ---------------------------------------------------------------------
CREATE TABLE sales.dim_store (
    store_id          VARCHAR(4),
    store_name        TEXT,
    country           CHAR(2),
    postal_code       VARCHAR(10),
    locality_id       VARCHAR(20),
    store_type        TEXT,
    size_m2           INTEGER,
    opening_date      DATE,
    closing_date      DATE,
    location_profile  TEXT,
    urban_level       TEXT,
    population_tier   SMALLINT,
    lon               DOUBLE PRECISION,
    lat               DOUBLE PRECISION,
    geometry          GEOMETRY(Point, 4326)
);

CREATE TABLE sales.dim_product (
    product_id         VARCHAR(4),
    product_name       TEXT,
    category           TEXT,
    base_price         NUMERIC(10, 2),
    unit_cost          NUMERIC(10, 2),
    base_daily_units   DOUBLE PRECISION,
    launch_date        DATE,
    discontinued_date  DATE
);

CREATE TABLE sales.dim_date (
    date            DATE,
    year            SMALLINT,
    quarter         SMALLINT,
    month           SMALLINT,
    month_name      TEXT,
    iso_week        SMALLINT,
    weekday         SMALLINT,
    weekday_name    TEXT,
    is_weekend      BOOLEAN,
    season          TEXT,
    holiday_pt      TEXT,
    holiday_es      TEXT,
    is_holiday_pt   BOOLEAN,
    is_holiday_es   BOOLEAN
);

CREATE TABLE sales.dim_promotion (
    promotion_id    VARCHAR(5),
    promotion_name  TEXT,
    start_date      DATE,
    end_date        DATE,
    discount_pct    NUMERIC(4, 2),
    categories      TEXT
);

-- ---------------------------------------------------------------------
-- Fact table: one row per day, store and product with sales
-- ---------------------------------------------------------------------
CREATE TABLE sales.fact_sales (
    date          DATE,
    store_id      VARCHAR(4),
    product_id    VARCHAR(4),
    quantity      INTEGER,
    promotion_id  VARCHAR(5),
    discount_pct  NUMERIC(4, 2),
    unit_price    NUMERIC(10, 2),
    revenue       NUMERIC(12, 2),
    cost          NUMERIC(12, 2)
);
