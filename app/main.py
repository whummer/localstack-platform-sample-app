from fastapi import FastAPI

from app.routers import assistant, invoices, payments

app = FastAPI(title="LocalStack Platform Sample App")

app.include_router(payments.router)
app.include_router(invoices.router)
app.include_router(assistant.router)


@app.get("/health")
def health():
    return {"status": "ok"}
