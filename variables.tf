variable "bucketname" {
  type = map(object({
    name = string
    acces_level = bool
  }))
  default = {

  }
  
}

variable "vault" {
  type = object({
    vault_namespace = string
    vault_role_id   = string
    vault_secret_id = string
    vault_address   = string
  })

}

variable "project_id" {
  type = string
  
}
variable "path_vault_gcp_token" { 
  type = string
}