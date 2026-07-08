# LocalStack Platform Sample App

A small sample app that shows how to build a real integration-heavy service on AWS, and how to run and test the exact same stack locally with LocalStack and LocalStack Extensions.

The app is a FastAPI service running on Lambda behind API Gateway. It talks to three third-party APIs through their official SDKs:

- **Stripe** - create a payment intent
- **Xero** - create an invoice
- **Anthropic** - ask Claude a question

Each SDK's base URL is read from an environment variable rather than hardcoded, so the same Lambda code can point at the real APIs in AWS, or at LocalStack Extension endpoints when running locally. Nothing in the app code needs to change between environments.

## Project layout

```
app/                  FastAPI app + Lambda handler
  clients/            Thin wrappers around the Stripe, Xero, and Anthropic SDKs
  routers/            HTTP routes: /payments, /invoices, /assistant
infra/                Terraform (deploys to both real AWS and LocalStack via tflocal)
scripts/              Lambda packaging script
tests/                Basic test suite
```

## Configuration

All third-party endpoints and credentials are plain environment variables (see `.env.example`), passed through to the Lambda as Terraform variables:

| Variable | Purpose | Default |
|---|---|---|
| `STRIPE_API_KEY` / `STRIPE_API_BASE` | Stripe SDK auth + base URL | `https://api.stripe.com` |
| `XERO_CLIENT_ID` / `XERO_CLIENT_SECRET` / `XERO_ACCESS_TOKEN` / `XERO_TENANT_ID` / `XERO_API_BASE` | Xero SDK auth + base URL | `https://api.xero.com` |
| `ANTHROPIC_API_KEY` / `ANTHROPIC_API_BASE` | Anthropic SDK auth + base URL | `https://api.anthropic.com` |

For local runs, these `*_API_BASE` values get pointed at LocalStack Extension endpoints instead of the real APIs.

## Running locally against LocalStack

You don't need to install or configure any LocalStack Extensions by hand. The `lstk` CLI fetches this project's config and sets everything up for you (LocalStack itself, the required extensions, and the local endpoint URLs/credentials for Stripe, Xero, and Anthropic).

```bash
make deploy-local PROJECT_ID=my-prj-123
```

This runs `lstk project start my-prj-123` to bring up LocalStack with the right extensions configured, then deploys the app with `tflocal`. When you're done:

```bash
make local-down PROJECT_ID=my-prj-123
```

This is also exactly what CI does - see `.github/workflows/ci.yml`. The whole pipeline is just: install `lstk`, run `lstk project start my-prj-123`, deploy, test, tear down.

## Deploying to real AWS

```bash
cp infra/terraform.tfvars.example infra/terraform.tfvars
# fill in real API keys in infra/terraform.tfvars
make deploy-aws
```

## Running tests

```bash
pip install -r app/requirements.txt -r requirements-dev.txt
make test
```
