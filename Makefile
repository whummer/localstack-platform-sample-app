PROJECT_ID ?= my-prj-123

.PHONY: build local-up local-down deploy-local deploy-aws test clean

build:
	./scripts/build_lambda.sh

# Starts LocalStack + the LocalStack Extensions needed by this project
# (mock Stripe/Xero/Anthropic endpoints) using the project's lstk config.
# No manual extension install required.
local-up:
	lstk project start $(PROJECT_ID)

local-down:
	lstk project stop $(PROJECT_ID)

# lstk writes infra/local.auto.tfvars with the local endpoint URLs and demo
# credentials, which tflocal automatically picks up.
deploy-local: build local-up
	cd infra && tflocal init -input=false && tflocal apply -auto-approve -input=false

deploy-aws: build
	cd infra && terraform init -input=false && terraform apply -input=false

test:
	pytest tests/

clean:
	rm -rf build
