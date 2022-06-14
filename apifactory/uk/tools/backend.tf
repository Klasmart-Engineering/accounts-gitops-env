terraform {
  cloud {
    organization = "kidsloop-infrastructure"
    workspaces {
      name = "accounts-apifactory-uk"
    }
  }
}
