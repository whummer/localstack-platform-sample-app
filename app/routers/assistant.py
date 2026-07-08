from fastapi import APIRouter
from pydantic import BaseModel

from app.clients.anthropic_client import ask_claude

router = APIRouter(prefix="/assistant", tags=["assistant"])


class AskRequest(BaseModel):
    prompt: str


@router.post("/ask")
def ask(request: AskRequest):
    return {"answer": ask_claude(request.prompt)}
