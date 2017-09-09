vnet_name = "simplevnet01"
address_space = "10.0.0.0/16"

subnet_name = "simplesubnet01"
subnet_prefix = "10.0.0.0/24"

nic_name = "simplenic"
ip_config_name = "simpleipconfig01"
ip_allocation = "dynamic"
private_ip_address01 = "10.0.2.5"

pip_name = "simplepip"
pip_allocation = "dynamic"

nsg_name = "superstrongnsg01"

rule_name = "superstrongnsgrule01"
nsg_direciton = "inbound"
nsg_access_type = "allow"
nsg_protocal = "tcp"
nsg_source_port_range = "22"
nsg_destination_port_range = "22"
nsg_source_address = "*"
nsg_destination_address = "*"