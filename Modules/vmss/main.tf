resource "random_password" "web_password" {
  length           = 16
  special          = false
  lower            = true
  upper            = true
  number           = true
}

resource "azurerm_linux_virtual_machine_scale_set" "deployment" {
  name                            = "${var.tag}-vmss"
  resource_group_name             = var.RG.name
  location                        = var.RG.location
  sku                             = "Standard_B2s"
  instances                       = var.instance_count # number of instances
  overprovision                   = false
  single_placement_group          = false
  admin_username                  = "ubuntu"
  admin_password                  = random_password.web_password.result
  disable_password_authentication = false
#  user_data                       = filebase64(var.user_data_file)
  depends_on = [random_password.web_password]

  source_image_reference {
    publisher = "canonical"
    offer     = "0001-com-ubuntu-server-focal"
    sku       = "20_04-lts"
    version   = "latest"
  }

  os_disk {
    storage_account_type = "Standard_LRS"
    caching              = "ReadWrite"
  }

  network_interface {
    name    = "${var.tag}-vmss-nic"
    primary = true

    ip_configuration {
      load_balancer_backend_address_pool_ids = [var.lb_backend.id]
      name      = "${var.tag}-vmss-ip-config"
      primary   = true
#      public_ip_address {          >> Removes
#        name = "${var.tag}vmss_ip" >> Public IP
#      }                            >> Association and creation
      subnet_id = var.subnet.id
    }
  }

  boot_diagnostics {
    storage_account_uri = null
  }
}
resource "azurerm_monitor_autoscale_setting" "vmss_scale_policy" {
  name                = "myAutoscaleSetting"
  resource_group_name = var.RG.name
  location            = var.RG.location
  target_resource_id  = azurerm_linux_virtual_machine_scale_set.deployment.id

  profile {
    name = "defaultProfile"

    capacity {
      default = var.instance_count
      minimum = var.instance_count
      maximum = 10
    }

    rule {
      metric_trigger {
        metric_name        = "Percentage CPU"
        metric_resource_id = azurerm_linux_virtual_machine_scale_set.deployment.id
        time_grain         = "PT1M"
        statistic          = "Average"
        time_window        = "PT5M"
        time_aggregation   = "Average"
        operator           = "GreaterThan"
        threshold          = 75
        metric_namespace   = "microsoft.compute/virtualmachinescalesets"
        dimensions {
          name     = "AppName"
          operator = "Equals"
          values   = ["App1"]
        }
      }

      scale_action {
        direction = "Increase"
        type      = "ChangeCount"
        value     = "1"
        cooldown  = "PT1M"
      }
    }

    rule {
      metric_trigger {
        metric_name        = "Percentage CPU"
        metric_resource_id = azurerm_linux_virtual_machine_scale_set.deployment.id
        time_grain         = "PT1M"
        statistic          = "Average"
        time_window        = "PT5M"
        time_aggregation   = "Average"
        operator           = "LessThan"
        threshold          = 25
      }

      scale_action {
        direction = "Decrease"
        type      = "ChangeCount"
        value     = "1"
        cooldown  = "PT1M"
      }
    }
  }
}