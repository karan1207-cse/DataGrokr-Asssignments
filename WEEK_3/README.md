# Week 3 - ETL Pipeline + Tests

A Python ETL pipeline that fetches data from a REST API, transforms it using pandas, saves the processed data to CSV, and validates the transformation using pytest unit tests.

## Project Flow

REST API → JSON → pandas DataFrame → Transform → CSV

## Features

- Fetches data from a REST API using `requests`
- Converts JSON data into a pandas DataFrame
- Selects required columns
- Removes missing values
- Converts the `completed` field into a readable status
- Saves processed data to CSV
- Includes pytest unit tests for the ETL transformation

## Project Structure

```text
week_3/
├── api.py
├── etl.py
├── main.py
├── data/
│   └── output.csv
├── tests/
│   └── test_etl.py
├── requirements.txt
└── README.md
```

## Technologies Used

- Python
- pandas
- Requests
- REST API
- CSV
- pytest

## ETL Stages

### 1. Extract
`api.py` sends a request to the REST API and receives JSON data.

### 2. Transform
`etl.py`:
- Converts JSON into a DataFrame
- Selects required fields
- Removes missing values
- Converts `completed` into `Completed` or `Pending`

### 3. Load
The transformed DataFrame is saved as:

```text
data/output.csv
```

## Testing

The project uses **pytest** to check:

- Correct output columns
- Correct status transformation
- Removal of records containing missing values

Run the tests with:

```bash
pytest
```

Expected result:

```text
3 passed
```

## How to Run

### 1. Install dependencies

```bash
pip install -r requirements.txt
```

### 2. Run the ETL pipeline

```bash
python main.py
```

### 3. Run unit tests

```bash
pytest
```

### 4. Check output

The processed data is stored in:

```text
data/output.csv
```
