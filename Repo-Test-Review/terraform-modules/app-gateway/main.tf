resource "azurerm_application_gateway" "application_gateway" {
  name                = var.ag_gateway_name
  resource_group_name = azurerm_resource_group.key_rotate.name
  location            = azurerm_resource_group.key_rotate.location

  sku {
    name     = "Standard_v2"
    tier     = "Standard_v2"
    capacity = 2
  }

  gateway_ip_configuration {
    name      = "gateway-ip-configuration"
    subnet_id = azurerm_subnet.aksfrontend.id
  }

  frontend_port {
    name = "gateway-frontend-port"
    port = 80
  }

  frontend_ip_configuration {
    name                 = "gateway-frontend-ip"
    public_ip_address_id = azurerm_public_ip.akspublicip.id
  }

  backend_address_pool {
    name = "gateway-backend-pool"
  }

  backend_http_settings {
    name                  = "gateway-backend-http-settings"
    cookie_based_affinity = "Disabled"
    path                  = "/"
    port                  = 80
    protocol              = "Http"
    request_timeout       = 1
  }

  http_listener {
    name                           = "gateway-http-listener"
    frontend_ip_configuration_name = "gateway-frontend-ip"
    frontend_port_name             = "gateway-frontend-port"
    protocol                       = "Http"
  }

  request_routing_rule {
    name                       = "gateway-request-routing-rule"
    rule_type                  = "Basic"
    http_listener_name         = "gateway-http-listener"
    backend_address_pool_name  = "gateway-backend-pool"
    backend_http_settings_name = "gateway-backend-http-settings"
  }
}