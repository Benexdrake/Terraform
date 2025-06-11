terraform init

terraform $* -var-file "../secrets.tfvars" -var-file "../ENV/dev.tfvars" -lock=false -var="administrator_login=irgendwer" -var="administrator_login_password=1irgend@wa5" # <= Not a real Password