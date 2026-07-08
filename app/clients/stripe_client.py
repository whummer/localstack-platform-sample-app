import stripe

from app.config import settings


def _client():
    stripe.api_key = settings.stripe_api_key
    stripe.api_base = settings.stripe_api_base
    return stripe


def create_payment_intent(amount: int, currency: str = "usd") -> stripe.PaymentIntent:
    client = _client()
    return client.PaymentIntent.create(amount=amount, currency=currency)
