import pandas as pd

def transform_data(data):
    df = pd.DataFrame(data)
    df = df[["id", "userId", "title", "completed"]]
    df = df.dropna()
    df["status"] = df["completed"].map({True: "Completed", False: "Pending"})
    return df.drop(columns=["completed"])

def save_data(df, filename="data/output.csv"):
    df.to_csv(filename, index=False)
