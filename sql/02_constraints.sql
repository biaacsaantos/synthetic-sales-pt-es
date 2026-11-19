-- =====================================================================
-- 02 | Keys, checks and indexes of the star schema
-- =====================================================================

-- Primary keys
ALTER TABLE sales.dim_store     ADD CONSTRAINT pk_dim_store     PRIMARY KEY (store_id);
ALTER TABLE sales.dim_product   ADD CONSTRAINT pk_dim_product   PRIMARY KEY (product_id);
ALTER TABLE sales.dim_date      ADD CONSTRAINT pk_dim_date      PRIMARY KEY (date);
ALTER TABLE sales.dim_promotion ADD CONSTRAINT pk_dim_promotion PRIMARY KEY (promotion_id);
ALTER TABLE sales.fact_sales    ADD CONSTRAINT pk_fact_sales    PRIMARY KEY (date, store_id, product_id);

-- Foreign keys (fact table -> dimensions)
ALTER TABLE sales.fact_sales
    ADD CONSTRAINT fk_sales_date      FOREIGN KEY (date)         REFERENCES sales.dim_date (date),
    ADD CONSTRAINT fk_sales_store     FOREIGN KEY (store_id)     REFERENCES sales.dim_store (store_id),
    ADD CONSTRAINT fk_sales_product   FOREIGN KEY (product_id)   REFERENCES sales.dim_product (product_id),
    ADD CONSTRAINT fk_sales_promotion FOREIGN KEY (promotion_id) REFERENCES sales.dim_promotion (promotion_id);

-- Business rules
ALTER TABLE sales.fact_sales
    ADD CONSTRAINT chk_quantity_positive CHECK (quantity > 0),
    ADD CONSTRAINT chk_discount_range    CHECK (discount_pct >= 0 AND discount_pct < 1);

ALTER TABLE sales.dim_store
    ADD CONSTRAINT chk_store_dates CHECK (closing_date IS NULL OR closing_date > opening_date);

-- Indexes for the joins with the dimensions (the date is already the first column of the primary key)
CREATE INDEX idx_sales_store     ON sales.fact_sales (store_id);
CREATE INDEX idx_sales_product   ON sales.fact_sales (product_id);
CREATE INDEX idx_sales_promotion ON sales.fact_sales (promotion_id);

-- Spatial index on the store locations
CREATE INDEX gix_dim_store_geometry ON sales.dim_store USING GIST (geometry);

ANALYZE;
