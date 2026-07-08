variable "project_name" {
  description = "Name prefix for all resources"
  type        = string
  default     = "localstack-platform-sample-app"
}

variable "aws_region" {
  description = "AWS region to deploy into"
  type        = string
  default     = "us-east-1"
}

variable "stripe_api_key" {
  description = "Stripe secret API key"
  type        = string
  sensitive   = true
  default     = ""
}

variable "stripe_api_base" {
  description = "Base URL the Stripe SDK sends requests to. Point this at a LocalStack Extension endpoint for local testing."
  type        = string
  default     = "https://api.stripe.com"
}

variable "xero_client_id" {
  description = "Xero OAuth2 app client ID"
  type        = string
  sensitive   = true
  default     = ""
}

variable "xero_client_secret" {
  description = "Xero OAuth2 app client secret"
  type        = string
  sensitive   = true
  default     = ""
}

variable "xero_access_token" {
  description = "Pre-issued Xero OAuth2 access token (demo app skips the interactive login flow)"
  type        = string
  sensitive   = true
  default     = ""
}

variable "xero_tenant_id" {
  description = "Xero tenant (organisation) ID"
  type        = string
  default     = ""
}

variable "xero_api_base" {
  description = "Base URL the Xero SDK sends requests to. Point this at a LocalStack Extension endpoint for local testing."
  type        = string
  default     = "https://api.xero.com"
}

variable "anthropic_api_key" {
  description = "Anthropic API key"
  type        = string
  sensitive   = true
  default     = ""
}

variable "anthropic_api_base" {
  description = "Base URL the Anthropic SDK sends requests to. Point this at a LocalStack Extension endpoint for local testing."
  type        = string
  default     = "https://api.anthropic.com"
}
