terraform init -reconfigure -backend-config=secrets.tfvars

echo "" > ./.ssh/vm

terraform $* -var-file "./secrets.tfvars" -var-file "./env/dev.tfvars" -lock=false