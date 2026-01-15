from fastapi import APIRouter, HTTPException
from pydantic import BaseModel
from typing import List, Optional

router = APIRouter(prefix="/tasks", tags=["tasks"])

class Task(BaseModel):
    id: str
    title: str
    priority: int = 1
    status: str = "pending"

TASKS_DB: dict[str, Task] = {}

@router.post("", response_model=Task)
async def upsert_task(task: Task):
    TASKS_DB[task.id] = task
    return task

@router.get("", response_model=List[Task])
async def list_tasks():
    return list(TASKS_DB.values())

@router.get("/{task_id}", response_model=Task)
async def get_task(task_id: str):
    if task_id not in TASKS_DB:
        raise HTTPException(status_code=404, detail="Task not found")
    return TASKS_DB[task_id]

@router.delete("/{task_id}")
async def delete_task(task_id: str):
    if task_id in TASKS_DB:
        del TASKS_DB[task_id]
        return {"deleted": task_id}
    raise HTTPException(status_code=404, detail="Task not found")