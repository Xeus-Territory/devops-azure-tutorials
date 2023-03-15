
# Create public IP for Load Balancer
resource "azurerm_public_ip" "main_alb" {
  name                = "${var.environment}-publicIPforBalancer"
  resource_group_name = var.resource_group_name
  location            = var.resource_group_location
  allocation_method   = "Static"
  sku = "Standard"
  tags = var.tags
}

# Create Azure Load balancer 
resource "azurerm_lb" "main" {
  name                = "${var.environment}-loadbalancer"
  location            = var.resource_group_location
  resource_group_name = var.resource_group_name
  sku = "Standard"
  sku_tier = "Regional"
  frontend_ip_configuration {
    name                 = "${var.environment}-loadBalancer-ip"
    public_ip_address_id = azurerm_public_ip.main_alb.id
  }
  tags = var.tags

}

# Create Load Balancer Backend Pool
resource "azurerm_lb_backend_address_pool" "main" {
  name                = "${var.environment}-lbBackendPool"
  loadbalancer_id     = azurerm_lb.main.id
}

# Create Load Balancer Probe to check healthy port 443 of VM
resource "azurerm_lb_probe" "main_https" {
  loadbalancer_id     = azurerm_lb.main.id
  name                = "${var.environment}-probe443"
  port                = 443
  protocol            =  "Tcp"
}

# Create Load Balancer Probe to check healthy port 80 of VM 
resource "azurerm_lb_probe" "main_http" {
  loadbalancer_id     = azurerm_lb.main.id
  name                = "${var.environment}-probe80"
  port                = 80
  protocol            =  "Tcp"
}

# Create Load Balancer Rule to Accept port 443 from VM to go in LB
resource "azurerm_lb_rule" "main_https" {
  loadbalancer_id     = azurerm_lb.main.id
  name                           = "RuleHTTPs"
  protocol                       = "Tcp"
  frontend_port                  = 443
  backend_port                   = 443
  frontend_ip_configuration_name = "${var.environment}-loadBalancer-ip"
  backend_address_pool_ids = [ azurerm_lb_backend_address_pool.main.id ]
  disable_outbound_snat = true
  probe_id = azurerm_lb_probe.main_https.id
}

# Create Load Balancer Rule to Accept port 80 from VM to go in LB
resource "azurerm_lb_rule" "main_http" {
  loadbalancer_id     = azurerm_lb.main.id
  name                           = "RuleHTTP"
  protocol                       = "Tcp"
  frontend_port                  = 80
  backend_port                   = 80
  frontend_ip_configuration_name = "${var.environment}-loadBalancer-ip"
  backend_address_pool_ids = [ azurerm_lb_backend_address_pool.main.id ]
  disable_outbound_snat = true
  probe_id = azurerm_lb_probe.main_http.id
}

# Create Load Balancer Outbound Rule to Accept TCP go out LB
resource "azurerm_lb_outbound_rule" "main" {
  name                    = "OutboundRule"
  loadbalancer_id         = azurerm_lb.main.id
  protocol                = "Tcp"
  backend_address_pool_id = azurerm_lb_backend_address_pool.main.id

  frontend_ip_configuration {
    name = "${var.environment}-loadBalancer-ip"
  }
}
