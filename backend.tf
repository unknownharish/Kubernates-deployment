terraform {
  backend "s3" {}
}

# Initialize backend with:
# terraform init -reconfigure -backend-config=backend.hcl
#
# Then select one of the supported workspaces:
# terraform workspace select dev   || terraform workspace new dev
# terraform workspace select stage || terraform workspace new stage
# terraform workspace select prod  || terraform workspace new prod
#
# S3 state paths are workspace-aware because backend.hcl sets workspace_key_prefix.
