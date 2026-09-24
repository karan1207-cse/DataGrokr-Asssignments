import pandas as pd
from etl import transform_data

def test_transform_data_columns():
    data = [
        {"id": 1, "userId": 10, "title": "Task one", "completed": True}
    ]
    df = transform_data(data)
    assert list(df.columns) == ["id", "userId", "title", "status"]

def test_status_transformation():
    data = [
        {"id": 1, "userId": 10, "title": "Done task", "completed": True},
        {"id": 2, "userId": 10, "title": "Pending task", "completed": False}
    ]
    df = transform_data(data)
    assert df["status"].tolist() == ["Completed", "Pending"]

def test_missing_values_are_removed():
    data = [
        {"id": 1, "userId": 10, "title": "Valid task", "completed": True},
        {"id": 2, "userId": 10, "title": None, "completed": False}
    ]
    df = transform_data(data)
    assert len(df) == 1
