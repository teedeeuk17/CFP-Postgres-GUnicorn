resource "azurerm_private_endpoint" "p-endpoint" {
  name                             = var.az_private_endpoint_name
  location                         = var.az_region
  resource_group_name              = var.az_resource_group_name
  subnet_id                        = var.az_subnet_id
 
  private_service_connection {
    name                           = var.az_private_service_connection_name #"example-privateserviceconnection"
    is_manual_connection           = "false"
    private_connection_resource_id = var.az_resource_id
    subresource_names              = var.az_subresource_names
  }
}