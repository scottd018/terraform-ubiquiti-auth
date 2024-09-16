
variable "usg_username" {}
variable "usg_password" {}
variable "usg_api_url" {}

module "test" {
  source = "../"

  action       = "login"
  usg_username = var.usg_username
  usg_password = var.usg_password
  usg_api_url  = var.usg_api_url
}

output "out" {
  value     = module.test
  sensitive = true
}
