provider "google" {
    credentials =  jsonencode(data.vault_generic_secret.gcp_owner_prod.data)
    project     = var.project_id.prod 
    alias = "prod"
}

provider "google" {
    credentials =  jsonencode(data.vault_generic_secret.gcp_owner_nprod.data)
    project     = var.project_id.nprod 
    alias = "nprod"
}


provider "vault" {
   address   = var.vault.vault_address
  namespace = var.vault.vault_namespace
  dynamic auth_login {
    for_each = (var.vault.vault_role_id  != "" && var.vault.vault_secret_id != "") ? [1] : []
    content {
      namespace  = var.vault.vault_namespace
      path       = "auth/approle/login"
      parameters = {
        role_id   = var.vault.vault_role_id
        secret_id = var.vault.vault_secret_id
      }
    }
  }
} 


############################### DATA READ #######################################

data "vault_generic_secret" "gcp_owner_prod" {
  path = var.path_vault_gcp_token.prod

}

data "vault_generic_secret" "gcp_owner_nprod" {
  path = var.path_vault_gcp_token.nprod

}

############################### RESOURCE PROD ########################################


resource "google_storage_bucket" "test_bucket_prod" {
    
    provider = google.prod
    for_each = var.bucketname

 name          = "${each.value["name"]}_prod"
 location      = "EU"
 storage_class = "STANDARD"

 uniform_bucket_level_access = each.value["acces_level"]
}

############################### RESOURCE NPROD ########################################


resource "google_storage_bucket" "test_bucket_nprod_dev" {
    
    provider = google.nprod
    for_each = var.bucketname

 name          = "${each.value["name"]}_nprod_dev"
 location      = "EU"
 storage_class = "STANDARD"

 uniform_bucket_level_access = each.value["acces_level"]
}

resource "google_storage_bucket" "test_bucket_nprod_prep" {
    
    provider = google.nprod
    for_each = var.bucketname

 name          = "${each.value["name"]}_nprod_prep"
 location      = "EU"
 storage_class = "STANDARD"

 uniform_bucket_level_access = each.value["acces_level"]
}