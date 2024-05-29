resource "azurerm_kubernetes_cluster" "aks" {
  name                = var.aks_name 
  location            = var.region 
  resource_group_name = var.resource_group_name 
  dns_prefix          = var.dns_prefix 
  private_cluster_enabled   = true

  default_node_pool {
    name       = "default"
    node_count = 2
    vm_size    = "Standard_B2s"
  }

  identity {
    type = "SystemAssigned"
  }
}

resource "azurerm_container_registry" "acr" {
  name                = var.acr_name 
  location            = var.region 
  resource_group_name = var.resource_group_name 
  public_network_access_enabled = false
  sku                 = "Premium"
  admin_enabled       = true
depends_on          = [azurerm_kubernetes_cluster.aks]

}
