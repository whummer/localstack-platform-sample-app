from fastapi import APIRouter
from pydantic import BaseModel

from app.clients.xero_client import create_invoice

router = APIRouter(prefix="/invoices", tags=["invoices"])


class CreateInvoiceRequest(BaseModel):
    contact_name: str
    description: str
    quantity: float = 1
    unit_amount: float


@router.post("")
def create_invoice_endpoint(request: CreateInvoiceRequest):
    result = create_invoice(
        contact_name=request.contact_name,
        description=request.description,
        quantity=request.quantity,
        unit_amount=request.unit_amount,
    )
    return {"invoices": [invoice.invoice_id for invoice in result.invoices]}
