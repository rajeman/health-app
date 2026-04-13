locals {
  runtime_environment_variables = merge(
    var.runtime_environment_variables,
    {
      OPENAI_API_KEY   = var.openai_api_key
      CLERK_SECRET_KEY = var.clerk_secret_key
      CLERK_JWKS_URL   = var.clerk_jwks_url
    },
  )
}
