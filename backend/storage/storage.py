import json
from pathlib import Path

BASE_DIR = Path(__file__).resolve().parent
TASKS_DIR = BASE_DIR / "tasks"

def load_all_tasks():
    tasks = []
    for file in TASKS_DIR.glob("*.json"):
        with open(file, "r") as f:
            tasks.append(json.load(f))
    return tasks