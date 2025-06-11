terraform init

terraform $* -var-file "./secrets.tfvars" -var-file "./ENV/dev.tfvars" -lock=false 