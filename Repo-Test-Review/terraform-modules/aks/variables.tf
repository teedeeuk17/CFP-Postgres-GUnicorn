variable "aks_name" {
  type        = string
  description = "The Name of the AKS Cluster"
}

variable "region" {
  type        = string
  description = "The Azure region to deploy resources to"
}

variable "resource_group_name" {
  type        = string
  description = "The Azure Resource Group Name"
}

variable "dns_prefix" {
  type        = string
  description = "The DNS Prefix for AKS Cluster"
}

variable "acr_name" {
  type        = string
  description = "The Azure Container Registry Name"
}
 