# Crear interfaz de red para la VM
resource "azurerm_network_interface" "vm_nic" {
  name                = "${var.vm_name}-nic"
  location            = var.location
  resource_group_name = var.resource_group_name

  ip_configuration {
    name                          = "internal"
    subnet_id                     = var.subnet_id
    private_ip_address_allocation = "Dynamic"
    public_ip_address_id          = var.enable_public_ip ? azurerm_public_ip.vm_public_ip[0].id : null
  }
}

# Crear IP pública (si está habilitado)
resource "azurerm_public_ip" "vm_public_ip" {
  count               = var.enable_public_ip ? 1 : 0
  name                = "${var.vm_name}-public-ip"
  location            = var.location
  resource_group_name = var.resource_group_name
  allocation_method   = "Dynamic"
  sku                 = "Basic"
  tags                = var.tags
}

# Crear NSG para la VM (Windows: RDP, Linux: SSH)
resource "azurerm_network_security_group" "vm_nsg" {
  count               = var.enable_public_ip ? 1 : 0
  name                = "${var.vm_name}-nsg"
  location            = var.location
  resource_group_name = var.resource_group_name

  dynamic "security_rule" {
    for_each = var.os_type == "Windows" ? [1] : []
    content {
      name                       = "AllowRDP"
      priority                   = 100
      direction                  = "Inbound"
      access                     = "Allow"
      protocol                   = "Tcp"
      source_port_range          = "*"
      destination_port_range     = "3389"
      source_address_prefix      = "*"
      destination_address_prefix = "*"
    }
  }

  dynamic "security_rule" {
    for_each = var.os_type == "Linux" ? [1] : []
    content {
      name                       = "AllowSSH"
      priority                   = 100
      direction                  = "Inbound"
      access                     = "Allow"
      protocol                   = "Tcp"
      source_port_range          = "*"
      destination_port_range     = "22"
      source_address_prefix      = "*"
      destination_address_prefix = "*"
    }
  }

  tags = var.tags
}

# Asociar NSG con la interfaz de red
resource "azurerm_network_interface_security_group_association" "vm_nic_nsg" {
  count                 = var.enable_public_ip ? 1 : 0
  network_interface_id  = azurerm_network_interface.vm_nic.id
  network_security_group_id = azurerm_network_security_group.vm_nsg[0].id
}

# Crear máquina virtual
resource "azurerm_virtual_machine" "vm" {
  name                  = var.vm_name
  location              = var.location
  resource_group_name   = var.resource_group_name
  network_interface_ids = [azurerm_network_interface.vm_nic.id]
  vm_size               = var.vm_size

  # Configuración del sistema operativo
  os_profile {
    computer_name  = var.vm_name
    admin_username = var.admin_username
    admin_password = var.admin_password
  }

  dynamic "os_profile_linux_config" {
    for_each = var.os_type == "Linux" ? [1] : []
    content {
      disable_password_authentication = false
    }
  }

  dynamic "os_profile_windows_config" {
    for_each = var.os_type == "Windows" ? [1] : []
    content {}
  }

  # Configuración de la imagen de VM
  storage_image_reference {
    publisher = var.image_publisher
    offer     = var.image_offer
    sku       = var.image_sku
    version   = "latest"
  }

  # Configuración del disco OS
  storage_os_disk {
    name              = "${var.vm_name}-osdisk"
    caching           = "ReadWrite"
    create_option     = "FromImage"
    managed_disk_type = var.disk_type
  }

  tags = var.tags
}
