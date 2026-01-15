from fastapi import APIRouter, HTTPException
from pydantic import BaseModel
from typing import List, Optional

router = APIRouter(prefix="/tasks", tags=["tasks"])

@router.get("")
def list_tasks():
    """
    Return all stored task JSON files from backend/storage/tasks/
    """
    tasks = storage.load_all_tasks()
    return {"tasks": tasks}