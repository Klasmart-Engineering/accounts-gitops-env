variable "tools_cluster_tfc_sa_token" {
  description = "Token to access the Tools cluster for ArgoCD"
  type        = string
}

variable "ghcr_credentials" {
  description = "Registry credentials for k8s to pull application images"
  type        = string
}

variable "tfe_access_token" {
  description = "Terraform Cloud access token for the Kubernetes operator"
  type        = string
}

variable "tfe_deploy_ssh_key_id" {
  description = "Name of the SSH key to authenticate with for Git-SSH based service module imports"
  type        = string
  default     = "TFC GitHub"
}