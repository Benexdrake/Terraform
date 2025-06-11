terraform init -reconfigure -backend-config="../secrets.tfvars"

mkdir ../.ssh
echo "" > ../.ssh/vm

terraform $* -var-file "../secrets.tfvars" -var-file "../ENV/dev.tfvars" -lock=false