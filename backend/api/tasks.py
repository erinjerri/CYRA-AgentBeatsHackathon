from fastapi import APIRouter
from backend.storage.storage import load_all_tasks  # Import your existing function

router = APIRouter(prefix="/tasks", tags=["tasks"])

@router.get("")
def list_tasks():
    tasks = load_all_tasks()
    return {"tasks": tasks}