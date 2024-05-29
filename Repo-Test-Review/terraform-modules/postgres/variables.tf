
variable "resource_group_name" {
  type        = string
  description = "The Resource Group Name"
}

variable "region" {
  type        = string
  description = "The Azure Region to deploy resources"
}
variable "postgres_server_name" {
  type        = string
  description = "The Name of the Psotgres Sql Server"
}

variable "admin_username" {
  type        = string
  description = "The Name of the admin user"
}

variable "admin_password" {
  type        = string
  description = "The Name of the admin password"
}
variable "postgre_db_name" {
  type        = string
  description = "The Name of the postgres database"
}

variable "az_kv_name" {
  type        = string
  description = "key vault name"
}