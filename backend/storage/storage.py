import json
from pathlib import Path
from typing import Any, Dict, List

BASE_DIR = Path(__file__).resolve().parent
TASKS_DIR = BASE_DIR / "tasks"

def load_all_tasks():
    """
    Load tasks from JSON files in backend/storage/tasks/.

    Supports either:
    - one task per file (JSON object), or
    - a file containing a JSON array of task objects (e.g. tasks.json).
    """
    tasks: List[Dict[str, Any]] = []

    for file in TASKS_DIR.glob("*.json"):
        try:
            with open(file, "r") as f:
                data: Any = json.load(f)
        except Exception:
            # Ignore unreadable/invalid JSON files rather than breaking /tasks.
            continue

        if isinstance(data, dict):
            tasks.append(data)
        elif isinstance(data, list):
            for item in data:
                if isinstance(item, dict):
                    tasks.append(item)

    return tasks