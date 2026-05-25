# Terraform Workspace Architecture

This repository now supports a single root Terraform stack using Terraform workspaces (`dev`, `stage`, `prod`) instead of running from separate `envs/*` folders.

## One-time initialization

```bash
terraform init -reconfigure -backend-config=backend.hcl
```

## Create/select workspace

```bash
terraform workspace new dev
terraform workspace new stage
terraform workspace new prod

# or switch to an existing one
terraform workspace select dev
```

## Plan/apply per workspace

Use the tfvars file that matches the current workspace:

```bash
# Example: dev
terraform workspace select dev
terraform plan  -var-file=workspaces/dev.tfvars
terraform apply -var-file=workspaces/dev.tfvars

# Example: stage
terraform workspace select stage
terraform plan  -var-file=workspaces/stage.tfvars
terraform apply -var-file=workspaces/stage.tfvars

# Example: prod
terraform workspace select prod
terraform plan  -var-file=workspaces/prod.tfvars
terraform apply -var-file=workspaces/prod.tfvars
```

## Notes

- Environment-specific networking and node sizing are defined in `main.tf` in `local.environment_configs`.
- If workspace is not one of `dev`, `stage`, or `prod`, Terraform fails with a validation check.
- Backend configuration is centralized in `backend.hcl`.
