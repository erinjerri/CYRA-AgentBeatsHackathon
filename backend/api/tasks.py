from fastapi import APIRouter
from pydantic import BaseModel
from typing import List
from backend.storage.storage import load_all_tasks  # Import your existing function

router = APIRouter(prefix="/tasks", tags=["tasks"])

class TaskOut(BaseModel):
    id: str
    title: str
    priority: int
    status: str

@router.get("", response_model=List[TaskOut])
def list_tasks():
    tasks = load_all_tasks()
    out: List[TaskOut] = []
    for t in tasks:
        # Normalize older task files that might not have these keys yet.
        task_id = str(t.get("id") or t.get("received_at") or "0")
        title = str(
            t.get("title")
            or t.get("user_utterance")
            or t.get("transcribed_text")
            or t.get("task")
            or "Untitled task"
        )
        priority = int(t.get("priority") or 0)
        status = str(t.get("status") or "pending")
        out.append(TaskOut(id=task_id, title=title, priority=priority, status=status))

    return out