"""Parameters of the synthetic data. Change them here and run the notebooks again."""

from pathlib import Path

# --------------------------------------------------------------------------
# Paths
# --------------------------------------------------------------------------
ROOT_DIR = Path(__file__).resolve().parents[1]
GENERATED_DIR = ROOT_DIR / "data" / "generated"
OUTPUTS_DIR = ROOT_DIR / "outputs"
SQL_DIR = ROOT_DIR / "sql"

# CSV files exported by the project "postal-admin-reference-pt-es" (notebook 07).
# By default, both repositories are expected to be in the same parent folder.
REFERENCE_CSV_DIR = ROOT_DIR.parent / "postal-admin-reference-pt-es" / "outputs" / "csv"

# --------------------------------------------------------------------------
# Fictitious company
# --------------------------------------------------------------------------
BRAND = "Cume & Costa"          # invented brand name ("summit & coast")

# --------------------------------------------------------------------------
# Period and size
# --------------------------------------------------------------------------
START_DATE = "2021-01-01"
END_DATE = "2025-12-31"

N_STORES_PT = 40                # Portugal (the chain starts here)
N_STORES_ES = 12                # Spain (expansion from 2022)
N_MOUNTAIN_STORES = {"PT": 3, "ES": 2}   # stores placed in mountain regions (snow products)

SEED = 42                       # same seed -> exactly the same data every time

# --------------------------------------------------------------------------
# Eurostat territorial typologies (NUTS 3)
# Check the codes with notebook 01 (value counts) before generating the data.
# --------------------------------------------------------------------------
MOUNTAIN_CODES = [1, 2, 3]      # 1, 2, 3 = mountain regions; 4 = non-mountain
COASTAL_CODES = [1, 2]          # 1, 2 = coastal regions; 3 = non-coastal

# Degree of urbanisation of the postal code (DGURBA): 1 = cities, 2 = towns and suburbs, 3 = rural areas
