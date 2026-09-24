import sys
from pathlib import Path

sys.path.insert(0, str(Path(__file__).resolve().parents[1]))


from api import fetch_data
from etl import transform_data, save_data

def main():
    data = fetch_data()
    df = transform_data(data)
    save_data(df)
    print(f"ETL completed successfully. {len(df)} records saved to data/output.csv")

if __name__ == "__main__":
    main()
