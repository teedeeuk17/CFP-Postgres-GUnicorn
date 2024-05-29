resource "azurerm_resource_group" "key_rotate" {
  name     = var.resource_group_name
  location = var.region
}

resource "azurerm_postgresql_server" "postgres_main" {
  name                = var.postgres_server_name
  location            = var.region
  resource_group_name = var.resource_group_name
  sku_name = "B_Gen5_2"

  storage_profile {
    storage_mb            = 5120
    backup_retention_days = 7
    geo_redundant_backup  = "Disabled"
    auto_grow             = "Enabled"
  }

  administrator_login          = var.admin_username #"psqladminun"
  administrator_login_password = var.admin_password #"MyB@dP2$$wd"
  version                      = "9.6"
  ssl_enforcement              = "Enabled"
}

resource "azurerm_postgresql_database" "postgre_db" {
  name                = var.postgre_db_name
  resource_group_name = var.resource_group_name
  server_name         = var.postgres_server_name
  charset             = "UTF8"
  collation           = "English_United States.1252"
  depends_on = [azurerm_postgresql_server.postgres_main]
}

resource "azurerm_postgresql_firewall_rule" "postgre_main_firewall_allazure" {
  name                = "allazure"
  resource_group_name = var.resource_group_name
  server_name         = var.postgres_server_name
  start_ip_address    = "10.11.4.8"
  end_ip_address      = "10.11.4.8"
  depends_on = [azurerm_postgresql_server.postgre_main]
}

provider "postgresql" {
  alias    = "postgre_main"
  host     = azurerm_postgresql_server.postgre_main.fqdn
  sslmode = "require"
  username = "${azurerm_postgresql_server.postgre_main.administrator_login}@${azurerm_postgresql_server.postgre_main.fqdn}"
  password = azurerm_postgresql_server.postgre_main.administrator_login_password
  expected_version = "9.6"
  superuser = false
  connect_timeout = 15
}

resource "random_password" "password" {
  length = 64
  special = true
  override_special = "_%@"
}
