"""Shared helpers for the synthetic sales project."""

import pandas as pd

from src.config import GENERATED_DIR


def save_table(df, name):
    """Save a table as Parquet in data/generated/."""
    GENERATED_DIR.mkdir(parents=True, exist_ok=True)
    df.to_parquet(GENERATED_DIR / f"{name}.parquet", index=False)
    print(f"Saved '{name}' ({len(df):,} rows)")


def load_table(name):
    """Read a table saved with save_table."""
    return pd.read_parquet(GENERATED_DIR / f"{name}.parquet")

