output "network_config" {
  value = data.terraform_remote_state.network.config
}

output "network_defaults" {
  value = data.terraform_remote_state.network.defaults
}

output "network_outputs" {
  value = data.terraform_remote_state.network.outputs // .outputname for the output
}

output "network_workspace" {
  value = data.terraform_remote_state.network.workspace
}