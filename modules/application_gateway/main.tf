resource "azurerm_public_ip" "gateway_public_ip" {
  count               = var.enable_public_ip ? 1 : 0
  name                = "${var.application_gateway_name}-pip"
  location            = var.location
  resource_group_name = var.resource_group_name
  allocation_method   = "Static"
  sku                 = "Standard"

  tags = var.tags
}

resource "azurerm_application_gateway" "application_gateway" {
  name                = var.application_gateway_name
  location            = var.location
  resource_group_name = var.resource_group_name

  sku {
    name     = var.sku_name
    tier     = var.sku_tier
    capacity = var.sku_capacity
  }

  gateway_ip_configuration {
    name      = "appGatewayIpConfig"
    subnet_id = var.subnet_id
  }

  frontend_ip_configuration {
    name                 = "appGatewayFrontendIP"
    public_ip_address_id = var.enable_public_ip && length(azurerm_public_ip.gateway_public_ip) > 0 ? azurerm_public_ip.gateway_public_ip[0].id : null
  }

  frontend_port {
    name = "httpPort"
    port = 80
  }

  dynamic "frontend_port" {
    for_each = var.enable_https ? [1] : []
    content {
      name = "httpsPort"
      port = 443
    }
  }

  backend_address_pool {
    name = "appGatewayBackendPool"
  }

  http_listener {
    name                           = "appGatewayListener"
    frontend_ip_configuration_name = "appGatewayFrontendIP"
    frontend_port_name             = "httpPort"
    protocol                       = "Http"
  }

  dynamic "http_listener" {
    for_each = var.enable_https ? [1] : []
    content {
      name                           = "appGatewayListenerHttps"
      frontend_ip_configuration_name = "appGatewayFrontendIP"
      frontend_port_name             = "httpsPort"
      protocol                       = "Https"
      ssl_certificate_name           = "appGatewayCert"
    }
  }

  request_routing_rule {
    name                       = "defaultRule"
    rule_type                  = "Basic"
    http_listener_name         = "appGatewayListener"
    backend_address_pool_name  = "appGatewayBackendPool"
    backend_http_settings_name = "defaultBackendHttpSettings"
    priority                   = 100
  }

  dynamic "request_routing_rule" {
    for_each = var.enable_https ? [1] : []
    content {
      name                       = "defaultHttpsRule"
      rule_type                  = "Basic"
      http_listener_name         = "appGatewayListenerHttps"
      backend_address_pool_name  = "appGatewayBackendPool"
      backend_http_settings_name = "defaultBackendHttpSettings"
      priority                   = 200
    }
  }

  backend_http_settings {
    name                  = "defaultBackendHttpSettings"
    cookie_based_affinity = "Disabled"
    port                  = 80
    protocol              = "Http"
    request_timeout       = 20
  }

  dynamic "ssl_certificate" {
    for_each = var.enable_https ? [1] : []
    content {
      name     = "appGatewayCert"
      data     = base64decode(var.ssl_certificate_data)
      password = var.ssl_certificate_password
    }
  }

  tags = var.tags
}
