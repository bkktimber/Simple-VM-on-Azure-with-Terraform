# Variable List
# Suscription
variable "subscription_id" {}
variable "client_id" {}
variable "client_secret" {}
variable "tenant_id" {}

# Resource Group
variable "resource_group_name" {
  type = "string"
}
variable "location" {
  default = "southeast asia"
}

# Virtual Network
variable "vnet_name" {
  # type = "string"
}
variable "address_space" {
}

# Subnet
variable "subnet_name" {
  type = "string"
}
variable "subnet_prefix" {
  type = "string"
}

# Public IP
variable "pip_name" {
  type = "string"
}
variable "pip_allocation" {
  type = "string"
  default = "dynamic"
}

# Network Interface
variable "nic_name" {
  type = "string"
}
variable "ip_config_name" {
  type = "string"
}
variable "ip_allocation" {
  type = "string"
  default = "static"
}
variable "private_ip_address01"{
  type = "string"
}

# NSG
variable "nsg_name" {
  type = "string"
}

# NSG Rule#0
variable "rule_name" {
  type = "string"
}
variable "nsg_direciton" {
  type = "string"
}
variable "nsg_access_type" {
  type = "string"
  default = "deny"
}
variable "nsg_protocol" {
  type = "string"
  default = "tcp"
}
variable "nsg_source_port_range" {
  type = "string"
  default = "*"
}
variable "nsg_destination_port_range" {
  type = "string"
  default = "*"
}
variable "nsg_source_address" {
  type = "string"
  default = "*"
}
variable "nsg_destination_address" {
  type = "string"
  default = "*"
}

# Storage Account
variable "storage_account_name" {
  type = "string"
}
variable "storage_account_type" {
  type = "string"
  default = "Standard_LRS"
}
variable "container_name" {
  type = "string"
}
variable "container_access_type" {
  type = "string"
  default = "private"
}

# VM
variable "vm_name" {
  type = "string"
}
variable "vm_size" {
  type = "string"
}

# OS
variable "image_publisher" {}
variable "image_offer" {}
variable "image_sku" {}
variable "image_verison" {
  type = "string"
  default = "lastest"
}
variable "os_disk_name" {}
variable "os_caching" {}
variable "os_create_option" {}

# Data Disk
variable "data_disk_name" {}
variable "data_disk_size" {}
variable "data_create_option" {}

# Admin
variable "computer_name" {}
variable "vm_admin" {}
variable "vm_password" {}