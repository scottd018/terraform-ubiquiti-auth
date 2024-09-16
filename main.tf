locals {
  login_data = jsonencode(
    {
      username = var.usg_username,
      password = var.usg_password,
    }
  )
}

#
# login action
#
resource "terraform_data" "login" {
  count = var.action == "login" ? 1 : 0

  triggers_replace = timestamp()
  input            = "headers.txt"

  provisioner "local-exec" {
    command = <<EOF
    curl ${var.usg_api_url}/api/auth/login \
      --silent \
      --insecure \
      --request POST \
      --header 'Content-Type: application/json' \
      --data ${jsonencode(local.login_data)} \
      --dump-header ./headers.txt
    EOF
  }
}

data "local_file" "auth_response_headers" {
  count = var.action == "login" ? 1 : 0

  filename = terraform_data.login[0].input
}

#
# logout action
#   TODO
#

output "auth_token" {
  sensitive   = true
  description = "Authentication token that may be used to authenticate the user against the Ubiquiti API."
  value       = var.action == "login" ? regex("TOKEN=([^;]+)", data.local_file.auth_response_headers[0].content) : null
}
