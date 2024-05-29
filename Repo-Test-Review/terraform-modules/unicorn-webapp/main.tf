locals {
 ip_address_list = [            {     
                  ip_add : var.ip_1_allow,
                  prior : "140",
                  name = "ib-allow-mgmnt"
            },
           {     
                  ip_add : var.ip_2_allow,
                  prior : "141",
                  name = "ib-allow-onprem"
            }
 ]

 ip_address_list2 = [            {     
                  ip_add : var.ip_1_deny,
                  prior : "142",
                  name = "ib-deny-internet"
            },
           {     
                  ip_add : var.ip_2_deny,
                  prior : "143",
                  name = "ib-deny-internet"
            }
 ]
}

resource "azurerm_linux_web_app" "appservice" {
  name                         = var.az_app_service_name
  location                     = var.az_primary_region
  resource_group_name          = var.az_resourcegroup_name
  service_plan_id              = var.az_app_service_plan_id 

site_config {
    application_stack {
    python = "3.11"
    "DOCKER_REGISTRY_SERVER_PASSWORD"           = "value"
    "DOCKER_REGISTRY_SERVER_URL"                = "value"
    "DOCKER_REGISTRY_SERVER_USERNAME"           = "value"
  }


dynamic "ip_restriction"{
    for_each=local.ip_address_list
    content{
    ip_address  = ip_restriction.value["ip_add"]
    action                    = "Allow"
    priority                  = ip_restriction.value["prior"]
    name = ip_restriction.value["name"]
      }
    }
dynamic "ip_restriction"  {
    for_each=local.ip_address_list2
    content{
    ip_address  = ip_restriction.value["ip_add"]
    action                    = "Deny"
    priority                  = ip_restriction.value["prior"]
    name = ip_restriction.value["name"]
  }
}
    always_on                                         = "true"
    ftps_state                                        = "FtpsOnly"
    default_documents = [
                    "Default.htm",
                    "Default.html",
                    "Default.asp",
                    "index.htm",
                    "index.html",
                    "iisstart.htm",
                    "default.aspx",
                    "index.php",
                    "hostingstart.html"
                ]
 }
  app_settings = {
    "functions_extension_version"                     = "~4"
    "AzureWebJobsStorage"                             = ""
    "WEBSITE_VNET_ROUTE_ALL"                          = "1"
    "WEBSITE_RUN_FROM_PACKAGE"                        = "1"
    "MSDEPLOY_RENAME_LOCKED_FILES"                    = "1"
    "WEBSITE_HEALTHCHECK_MAXPINGFAILURES"             = "10"
    "WEBSITE_DNS_SERVER"                              = "168.63.129.16"
    "APPINSIGHTS_INSTRUMENTATIONKEY"                  = var.az_appinsights_inst_key
    "APPLICATIONINSIGHTS_CONNECTION_STRING"           = var.az_appinsights_connection_string
    "APPINSIGHTS_PROFILERFEATURE_VERSION"             = "1.0.0"
    "APPINSIGHTS_SNAPSHOTFEATURE_VERSION"             = "1.0.0"
    "ApplicationInsightsAgent_EXTENSION_VERSION"      = "~3" # "2" windows
    "XDT_MicrosoftApplicationInsights_PreemptSdk"     = "1"
    "WEBSITE_WEBDEPLOY_USE_SCM"                       = true
    "https_only"                                      = true
  }

  connection_string {
    name  = "Database"
    type  = "SQLServer"
    value = ""#data.azurerm_key_vault_secret.sqlpassworduksfront.value
 }
}









