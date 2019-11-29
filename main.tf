provider "azurerm" {
  version         = "=1.27"
  subscription_id = var.subscription_id
}

resource "azurerm_resource_group" "main" {
  name     = "sitecorepocfull"
  location = var.location
}

# This creates the plan that the service use
resource "azurerm_app_service_plan" "main" {
  name                = var.prefix-asp"
  location            = "${azurerm_resource_group.main.location}"
  resource_group_name = "sitecorepocfull"
  kind                = "Linux"
  reserved            = true

  sku {
    tier = "Standard"
    size = "S1"
  }
}

# This creates the service definition
resource "azurerm_app_service" "main" {
  name                = var.prefix-appservice
  location            = azurerm_resource_group.main.location
  resource_group_name = "sitecorepocfull"
  app_service_plan_id = azurerm_app_service_plan.main.id
  }
