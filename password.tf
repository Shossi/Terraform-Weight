resource "random_password" "web_password" {
  length           = 16
  special          = false
}
resource "random_password" "postgres_password" {
  length           = 16
  special          = false
}
resource "random_password" "ansible_password" {
  length           = 16
  special          = false
}