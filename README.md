# Sandbox

This repo contains sandbox environment for PoCs

```bash
terraform init \
    -backend-config="bucket=$BACKEND_BUCKET" \
    -backend-config="key=$BACKEND_KEY" \
    -backend-config="region=$AWS_REGION" \
    -backend-config="dynamodb_table=$BACKEND_DYNAMO_TABLE"
```

```cmd
terraform init -reconfigure ^
    -backend-config="bucket=sandbox-assets-dev-24022025" ^
    -backend-config="key=terraform/state.tfstate" ^
    -backend-config="region=ap-south-1" ^
    -backend-config="dynamodb_table=sandbox-assets-lock-dev-24022025"
```