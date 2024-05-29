
variable "az_private_endpoint_name" {
  type        = string
  description = "private endpoint name"
}
variable "az_region" {
  type        = string
  description = "azure region"
}
variable "az_private_service_connection_name" {
  type        = string
  description = "p endpoint service connection name"
}
variable "az_resource_id" {
  type        = string
  description = "p-endpoint resource id"
}
variable "az_subnet_id" {
  type        = string
  description = "p endpoint subnet id"
}
variable "az_resource_group_name" {
  type        = string
  description = "resource group name"
}

variable "az_subresource_names" {
  type = list(string)

 #["sqlServer"]
}
