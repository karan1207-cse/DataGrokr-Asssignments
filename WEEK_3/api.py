import requests

API_URL = "https://jsonplaceholder.typicode.com/todos"

def fetch_data():
    response = requests.get(API_URL, timeout=10)
    response.raise_for_status()
    return response.json()
