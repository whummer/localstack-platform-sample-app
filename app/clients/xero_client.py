from xero_python.accounting import AccountingApi, Contact, Invoice, Invoices, LineItem
from xero_python.api_client import ApiClient, Configuration
from xero_python.api_client.oauth2 import OAuth2Token

from app.config import settings


def _accounting_api() -> AccountingApi:
    configuration = Configuration(
        oauth2_token=OAuth2Token(
            client_id=settings.xero_client_id, client_secret=settings.xero_client_secret
        ),
    )
    api_client = ApiClient(configuration)
    # Demo app skips the full OAuth2 login flow and uses a pre-issued token instead.
    api_client.set_oauth2_token({"access_token": settings.xero_access_token, "token_type": "Bearer"})
    return AccountingApi(api_client, base_url=settings.xero_api_base)


def create_invoice(contact_name: str, description: str, quantity: float, unit_amount: float):
    line_item = LineItem(
        description=description,
        quantity=quantity,
        unit_amount=unit_amount,
        account_code="200",
    )
    invoice = Invoice(type="ACCREC", contact=Contact(name=contact_name), line_items=[line_item])
    return _accounting_api().create_invoices(settings.xero_tenant_id, invoices=Invoices(invoices=[invoice]))
