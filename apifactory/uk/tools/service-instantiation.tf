module "service_instance" {
  # Module import info here
  source  = "git@github.com:KL-Engineering/accounts-terraform-svc.git?ref=v0.4.0"

  # Passthrough inputs
  region              = local.dep_meta.region
  project_environment = local.dep_meta.project_environment
  project_region      = local.dep_meta.project_region
  service_owner       = local.dep_meta.service_owner
  tags                = local.dep_meta.tags

  eks_oidc_provider_arn = local.dep_cluster.eks_oidc_provider_arn
  eks_oidc_provider_id  = local.dep_cluster.eks_oidc_provider_id

  logs_bucket_id = local.dep_account.logs_bucket_id

  # Terraform operator workspaces
  aws_target_role_arn    = local.dep_meta.aws_target_role_arn
  aws_session_name       = local.dep_meta.aws_session_name
  aws_target_external_id = local.dep_meta.aws_target_external_id

  # Terraform helm chart applications
  terraform_argocd_apps = ["workspace"]

  # Kubernetes
  kubernetes_server_url          = local.cluster_endpoint
  product_namespace              = local.product_namespace
  container_registry_credentials = local.container_registry_credentials

  # ArgoCD
  argocd_namespace = local.argocd_namespace
  argocd_project   = local.argocd_project_name

  # Helm
  helm_chart_url                   = "git@github.com:KL-Engineering/accounts-gitops-env.git"
  microgateway_helm_chart_revision = "HEAD"
  istio_helm_chart_revision        = "HEAD"

  domain = local.domain

  tfe_operator_access_token = var.tfe_access_token

  # tfe_ssh_key_id = data.tfe_ssh_key.deploy.id
  tfe_ssh_key_id = var.tfe_deploy_ssh_key_id

  providers = {
    kubernetes = kubernetes
    argocd     = argocd
  }
}
