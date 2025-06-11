terraform init -reconfigure -backend-config="../secrets.tfvars"

terraform $* -var-file "../secrets.tfvars" -var-file "../ENV/dev.tfvars" -lock=false