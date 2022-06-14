locals {
  # TFC inputs
  terraform_organization = "kidsloop-infrastructure"

  # Imported dependencies (mark as non-sensitive)
  dep_meta    = nonsensitive(data.tfe_outputs.meta.values)
  dep_account = nonsensitive(data.tfe_outputs.account.values)
  dep_cluster = nonsensitive(data.tfe_outputs.cluster.values)
  dep_tools   = nonsensitive(data.tfe_outputs.cluster-infra-tools.values)
  dep_product = nonsensitive(data.tfe_outputs.common-infrastructure.values)

  # Global EKS Variables
  cluster_endpoint                      = local.dep_cluster.cluster_endpoint
  cluster_id                            = local.dep_cluster.cluster_id
  kubeconfig_certificate_authority_data = local.dep_cluster.kubeconfig_certificate_authority_data

  # Infra tools EKS variables (for ArgoCD / Teleport)
  tools_region                                = "eu-west-2"
  tools_cluster_endpoint                      = local.dep_tools.cluster_endpoint
  tools_cluster_id                            = local.dep_tools.cluster_id
  tools_kubeconfig_certificate_authority_data = local.dep_tools.kubeconfig_certificate_authority_data

  # ArgoCD Project
  argocd_project_name = local.dep_product.argocd_project_name
  argocd_namespace    = "argocd"
  product_namespace   = local.dep_product.product_namespace

  container_registry_credentials = jsonencode({
    auths = {
      "ghcr.io" = {
        "auth" = base64encode(var.ghcr_credentials)
      }
    }
  })
}
