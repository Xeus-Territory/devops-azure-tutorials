# Set the monitoring for for vmss
resource "azurerm_monitor_autoscale_setting" "main" {
  name = "${local.environment}-AutoscaleSetting"
  resource_group_name = data.azurerm_resource_group.main.name
  location = data.azurerm_resource_group.main.location
  target_resource_id = azurerm_linux_virtual_machine_scale_set.main.id

  profile {
    name = "${local.environment}-defaultProfile"

    capacity {
      default = 1
      minimum = 1
      maximum = 2
    }

    rule {
      metric_trigger {
        metric_name = "Percentage CPU"
        metric_resource_id = azurerm_linux_virtual_machine_scale_set.main.id
        time_grain = "PT1M"
        statistic = "Average"
        time_window = "PT5M"
        time_aggregation = "Average"
        operator = "GreaterThan"
        threshold = 75
        metric_namespace = "microsoft.compute/virtualmachinescalesets"
      }

      scale_action {
        direction = "Increase"
        type = "ChangeCount"
        value = 1
        cooldown = "PT1M"
      }
    }

    rule {
      metric_trigger {
        metric_name = "Percentage CPU"
        metric_resource_id = azurerm_linux_virtual_machine_scale_set.main.id
        time_grain = "PT1M"
        statistic = "Average"
        time_window = "PT5M"
        time_aggregation = "Average"
        operator = "LessThan"
        threshold = "25"
      }

      scale_action {
        direction = "Decrease"
        type = "ChangeCount"
        value = "1"
        cooldown = "PT1M"
      }
    }
  }

  notification {
    email {
      custom_emails = [ var.email_notification ]
    }
  }
}