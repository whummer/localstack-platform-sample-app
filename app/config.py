import os
from dataclasses import dataclass


@dataclass(frozen=True)
class Settings:
    stripe_api_key: str = os.getenv("STRIPE_API_KEY", "")
    stripe_api_base: str = os.getenv("STRIPE_API_BASE", "https://api.stripe.com")

    xero_client_id: str = os.getenv("XERO_CLIENT_ID", "")
    xero_client_secret: str = os.getenv("XERO_CLIENT_SECRET", "")
    xero_access_token: str = os.getenv("XERO_ACCESS_TOKEN", "")
    xero_tenant_id: str = os.getenv("XERO_TENANT_ID", "")
    xero_api_base: str = os.getenv("XERO_API_BASE", "https://api.xero.com")

    anthropic_api_key: str = os.getenv("ANTHROPIC_API_KEY", "")
    anthropic_api_base: str = os.getenv("ANTHROPIC_API_BASE", "https://api.anthropic.com")


settings = Settings()
