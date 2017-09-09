# Config for Azure RM
provider "azurerm" {
  subscription_id = "${var.subscription_id}"
  client_id = "${var.client_id}"
  client_secret = "${var.client_secret}"
  tenant_id = "${var.tenant_id}"
}

# Get datasource module
data "azurerm_public_ip" "datasourceip" {
  name = "${var.pip_name}"
  resource_group_name = "${azurerm_resource_group.test-vm.name}"
}

#create resource group
resource "azurerm_resource_group" "test-vm" {
  name = "${var.resource_group_name}"
  location = "${var.location}"
}

# create virtual network and network interface
resource "azurerm_virtual_network" "vnet-test" {
  name = "${var.vnet_name}"
  resource_group_name = "${azurerm_resource_group.test-vm.name}"
  location = "${azurerm_resource_group.test-vm.location}"
  address_space = ["${var.address_space}"]
}

resource "azurerm_subnet" "subnet-test" {
  name = "${var.subnet_name}"
  resource_group_name = "${azurerm_resource_group.test-vm.name}"
  virtual_network_name = "${azurerm_virtual_network.vnet-test.name}"
  address_prefix = "${var.subnet_prefix}"
}

resource "azurerm_public_ip" "pip-test" {
  name = "${var.pip_name}"
  resource_group_name = "${azurerm_resource_group.test-vm.name}"
  location = "${azurerm_resource_group.test-vm.location}"
  public_ip_address_allocation = "${var.pip_allocation}"  
}

resource "azurerm_network_interface" "nic-test" {
  name = "${var.nic_name}"
  resource_group_name = "${azurerm_resource_group.test-vm.name}"
  location = "${azurerm_resource_group.test-vm.location}"

  ip_configuration {
    name = "${var.ip_config_name}"
    subnet_id = "${azurerm_subnet.subnet-test.id}"
    private_ip_address_allocation = "${var.ip_allocation}"
    private_ip_address = "${var.private_ip_address01}"
    public_ip_address_id = "${data.azurerm_public_ip.datasourceip.id}"
  }
}

# config nsg
resource "azurerm_network_security_group" "nsg-test" {
  name = "${var.nsg_name}"
  resource_group_name = "${azurerm_resource_group.test-vm.name}"
  location = "${azurerm_resource_group.test-vm.location}"

  # to do: automate priority 
  security_rule {
    name = "${var.rule_name}"
    priority = 100
    direction = "${var.nsg_direciton}"
    access = "${var.nsg_access_type}"
    protocol = "${var.nsg_protocol}"
    source_port_range = "${var.nsg_source_port_range}"
    destination_port_range = "${var.nsg_destination_port_range}"
    source_address_prefix = "${var.nsg_source_address}"
    destination_address_prefix = "${var.nsg_destination_address}"
  }
}

# create storage account and storage container
resource "azurerm_storage_account" "storage-test" {
  name = "${var.storage_account_name}"
  resource_group_name = "${azurerm_resource_group.test-vm.name}"
  location = "${azurerm_resource_group.test-vm.location}"
  account_type = "${var.storage_account_type}"
}

resource "azurerm_storage_container" "container-test" {
  name = "${var.container_name}"
  resource_group_name = "${azurerm_resource_group.test-vm.name}"
  storage_account_name = "${azurerm_storage_account.storage-test.name}"
  container_access_type = "${var.container_access_type}"
}

# create vm
resource "azurerm_virtual_machine" "simple-vm" {
  name = "${var.vm_name}"
  location = "${azurerm_resource_group.test-vm.location}"
  resource_group_name = "${azurerm_resource_group.test-vm.name}"
  network_interface_ids = ["${azurerm_network_interface.nic-test.id}"]
  vm_size = "${var.vm_size}"

  # delete os & data on termination option (default = false)
  delete_os_disk_on_termination = true
  delete_data_disks_on_termination = true

  # config what os image you want to use
  storage_image_reference {
    publisher = "${var.image_publisher}"
    offer = "${var.image_offer}"
    sku = "${var.image_sku}"
    version = "${var.image_verison}"
  }

  storage_os_disk {
    name = "${var.os_disk_name}"
    vhd_uri = "${azurerm_storage_account.storage-test.primary_blob_endpoint}${azurerm_storage_container.container-test.name}/${var.os_disk_name}.vhd"
    caching = "${var.os_caching}"
    create_option = "${var.os_create_option}"
  }

  # create data disk
  storage_data_disk {
    name = "${var.data_disk_name}"
    vhd_uri = "${azurerm_storage_account.storage-test.primary_blob_endpoint}${azurerm_storage_container.container-test.name}/${var.data_disk_name}.vhd"
    disk_size_gb = "${var.data_disk_size}"
    create_option = "${var.data_create_option}"
    lun = 0
  }

  # config vm admin user
  os_profile {
    computer_name = "${var.computer_name}"
    admin_username = "${var.vm_admin}"
    admin_password = "${var.vm_password}"
  }

  # authentication type (default = true; ssh)
  os_profile_linux_config {
    disable_password_authentication = false
  }
}