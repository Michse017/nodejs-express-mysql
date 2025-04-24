resource "azurerm_resource_group" "app" {
  name     = "rg-nodejs-app"
  location = "East US"
}

resource "azurerm_service_plan" "appserviceplan" {
  name                = "asp-nodejs"
  location            = azurerm_resource_group.app.location
  resource_group_name = azurerm_resource_group.app.name
  sku_name            = "F1"
  os_type             = "Linux"
}

resource "azurerm_linux_web_app" "appservice" {
  name                = "nodejs-express-mysql-app"
  location            = azurerm_resource_group.app.location
  resource_group_name = azurerm_resource_group.app.name
  service_plan_id     = azurerm_service_plan.appserviceplan.id

  site_config {
    application_stack {
      node_version = "18-lts"
    }
  }

  app_settings = {
    "MYSQL_HOST"     = "172.173.152.88"
    "MYSQL_USER"     = "appuser"
    "MYSQL_PASSWORD" = "app_password"
    "MYSQL_DATABASE" = "appdb"
  }
}