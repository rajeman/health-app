variable "aws_region" {
  description = "AWS region for resources and for the App Runner service."
  type        = string
  default     = "eu-west-1"
}

variable "environment" {
  description = "Environment name (used for tags)."
  type        = string
  default     = "dev"
}

variable "ecr_repository_name" {
  description = "ECR repository name for the application image."
  type        = string
  default     = "health-app-ecr"
}

variable "apprunner_service_name" {
  description = "AWS App Runner service name."
  type        = string
  default     = "health-app"
}

variable "container_port" {
  description = "Port the container listens on (must match Dockerfile EXPOSE / uvicorn)."
  type        = string
  default     = "8000"
}

variable "image_tag" {
  description = "Image tag App Runner should deploy from ECR."
  type        = string
  default     = "latest"
}

variable "apprunner_cpu" {
  description = "App Runner CPU (valid values per AWS docs, e.g. 256, 512, 1024, 2048)."
  type        = string
  default     = "256"
}

variable "apprunner_memory" {
  description = "App Runner memory in MB (must pair validly with CPU)."
  type        = string
  default     = "512"
}

variable "openai_api_key" {
  description = "Value for OPENAI_API_KEY on App Runner. Pass via TF_VAR_openai_api_key or terraform.tfvars."
  type        = string
  sensitive   = true
}

variable "clerk_secret_key" {
  description = "Value for CLERK_SECRET_KEY on App Runner. Pass via TF_VAR_clerk_secret_key or terraform.tfvars."
  type        = string
  sensitive   = true
}

variable "clerk_jwks_url" {
  description = "Value for CLERK_JWKS_URL on App Runner. Pass via TF_VAR_clerk_jwks_url or terraform.tfvars."
  type        = string
  sensitive   = true
}

variable "runtime_environment_variables" {
  description = "Additional plain environment variables merged into the App Runner service (optional)."
  type        = map(string)
  default     = {}
}

variable "auto_deployments_enabled" {
  description = "When true, App Runner deploys on new image pushes to ECR."
  type        = bool
  default     = true
}
