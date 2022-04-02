#resource "random_password" "web_password" { # Moved this to the VMSS module, for some reason it raised an error
#  length           = 16                     # Wasn't being created before the VMSS.
#  special          = false
#}
resource "random_password" "postgres_password" {
  length           = 16
  special          = false
}
resource "random_password" "ansible_password" {
  length           = 16
  special          = false
}