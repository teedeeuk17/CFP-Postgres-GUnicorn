variable "az_kv_name" {
  type        = string
  description = "key vault name"
}
variable "az_region" {
  type        = string
  description = "azure region"

}
variable "az_resource_group_name" {
  type        = string
  description = "resource group name"
}

variable "az_tenant_id" {
  type        = string
  description = "tenant id"
  default     = ""
}
variable "az_soft_delete_retention_days" {
  type        = string
  description = "soft delete retention days"
  default     = "7"
}
variable "az_object_id" {
  type        = string

}

variable "az_subnet_id" {
  description = "subnet resource id"
}
variable "sku_name" {
  description = "sku name"
}

variable "az_key_identifier" {
  type        = string
  description = "keyvault key identifier"
}  
  
variable "az_keyvault_id" {
  type        = string
  description = "keyvault key id"
}