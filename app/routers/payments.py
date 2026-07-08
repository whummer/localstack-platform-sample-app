from fastapi import APIRouter
from pydantic import BaseModel

from app.clients.stripe_client import create_payment_intent

router = APIRouter(prefix="/payments", tags=["payments"])


class CreatePaymentRequest(BaseModel):
    amount: int
    currency: str = "usd"


@router.post("")
def create_payment(request: CreatePaymentRequest):
    intent = create_payment_intent(amount=request.amount, currency=request.currency)
    return {"id": intent["id"], "status": intent["status"], "client_secret": intent["client_secret"]}
