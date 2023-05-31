terraform {
  required_providers {
    tfe = {
      source  = "hashicorp/tfe"
      version = "0.45.0"
    }
  }
}

provider "tfe" {
  # Configuration options
}

locals {
  # Get a list of subdirectories in the base directory
  sub_dirs = fileset(path.module, "*/*/")
}

#output "txt_files" {
# ## value = fileset(path.module, "*/*/")
#  value = {
#    for_each = {for dir in local.sub_dirs: dirname(dir) => dir...}
#  }
#}

resource "tfe_organization" "org" {
  name  = "tfc-monorepos"
  email = "zain.hasan@hashicorp.com"
}

resource "tfe_workspace" "this" {
  #  for_each = {for dir in local.sub_dirs: basename(dir) => dir}
  for_each          = {for dir in local.sub_dirs : dirname(dir) => dir...}
  name              = "ws-${each.key}"
  description       = "workspace for ${each.key}"
  working_directory = "${path.root}/${each.key}"
  organization      = tfe_organization.org.name
  vcs_repo {
    identifier     = "zainq11/tfc-monorepo-1000"
    # oauth_token_id = var.oauth_token
    github_app_installation_id = var.github_app_installation_id
  }
  queue_all_runs = false
  auto_apply = true
}
