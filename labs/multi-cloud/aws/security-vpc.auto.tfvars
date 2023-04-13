
security-vpc = {
    name                 = "sec-vpc"
    cidr_block           = "10.3.0.0/16"
    instance_tenancy     = "default"
    enable_dns_support   = true
    enable_dns_hostnames = true
    internet_gateway     = true
}

security-vpc-route-tables = [
  { name = "ngfw-mgmt-rt", subnet = "ngfw-mgmt-subnet" },
  { name = "ngfw-data-rt", subnet = "ngfw-data-subnet" },
  { name = "gwlbe-rt", subnet = "gwlbe-subnet" },
  { name = "tgw-rt", subnet = "tgw-subnet" }
]

security-vpc-routes = {
  sec-tgw-gwlbe-out = {
    name          = "tgw-gwlbe-out"
    vpc_name      = "sec-vpc"
    route_table   = "tgw-rt"
    prefix        = "0.0.0.0/0"
    next_hop_type = "gateway_load_balancer_endpoint"
    next_hop_name = "gwlbe"
  },
  sec-gwlbe-tgw = {
    name          = "gwlbe-tgw"
    vpc_name      = "sec-vpc"
    route_table   = "gwlbe-rt"
    prefix        = "0.0.0.0/0"
    next_hop_type = "transit_gateway"
    next_hop_name = "tgw"
  },
  sec-ngfw-tgw-1 = {
    name          = "ngfw-tgw-1"
    vpc_name      = "sec-vpc"
    route_table   = "ngfw-mgmt-rt"
    prefix        = "10.2.0.0/16"
    next_hop_type = "transit_gateway"
    next_hop_name = "tgw"
  },
  sec-ngfw-igw-1 = {
    name          = "ngfw-igw-1"
    vpc_name      = "sec-vpc"
    route_table   = "ngfw-mgmt-rt"
    prefix        = "0.0.0.0/0"
    next_hop_type = "internet_gateway"
    next_hop_name = "igw"
  }
}

security-vpc-subnets = [
  { name = "ngfw-data-subnet", cidr = "10.3.1.0/24", az = "a" },
  { name = "ngfw-mgmt-subnet", cidr = "10.3.2.0/24", az = "a" },
  { name = "gwlbe-subnet", cidr = "10.3.4.0/24", az = "a" },
  { name = "tgw-subnet", cidr = "10.3.0.0/24", az = "a" }
]

security-vpc-security-groups = [
  {
    name = "ngfw-data-sg"
    rules = [
      {
        description = "Permit All traffic outbound"
        type        = "egress", from_port = "0", to_port = "0", protocol = "-1"
        cidr_blocks = ["0.0.0.0/0"]
      },
      {
        description = "Permit All Internal traffic"
        type        = "ingress", from_port = "0", to_port = "0", protocol = "-1"
        cidr_blocks = ["0.0.0.0/0"]
      }
    ]
  },
  {
    name = "ngfw-mgmt-sg"
    rules = [
      {
        description = "Permit All traffic outbound"
        type        = "egress", from_port = "0", to_port = "0", protocol = "-1"
        cidr_blocks = ["0.0.0.0/0"]
      },
      {
        description = "Permit All inbound traffic"
        type        = "ingress", from_port = "0", to_port = "0", protocol = "-1"
        cidr_blocks = ["0.0.0.0/0"]
      }
    ]
  }
]

transit-gateway = {
  name     = "tgw"
  asn      = "64512"
  route_tables = {
    security = { name = "from-sec-vpc"}
    spoke    = { name = "from-ftp-svr-vpcs"}
  }
}

transit-gateway-associations = {
  "sec-vpc" = "from-sec-vpc",
  "ftp-svr-vpc" = "from-ftp-svr-vpcs"
  "ftp-client-vpc" = "from-ftp-svr-vpcs"
}

transit-gateway-routes = {
  "sec-vpc-to-ftp-svr-vpc-route" = {
    route_table = "from-sec-vpc"
    vpc_name    = "ftp-svr-vpc"
    cidr_block  = "10.1.0.0/16"
  },
  "sec-vpc-to-ftp-client-vpc-route" = {
    route_table = "from-sec-vpc"
    vpc_name    = "ftp-client-vpc"
    cidr_block  = "10.2.0.0/16"
  },
  "ftp-svr-vpcs-to-sec-vpc-route" = {
    route_table = "from-ftp-svr-vpcs"
    vpc_name    = "sec-vpc"
    cidr_block  = "0.0.0.0/0"
  }
}

fw_version = "10.2.1"
fw_product_code = ["hd44w1chf26uv4p52cdynb2o"]

firewalls = [
  {
    name              = "vmseries01"
    instance_type     = "m5.xlarge"
    bootstrap_options = { "hostname" = "multicloud-lab-vmseries01" }
    interfaces = [
      { name = "vmseries01-data", index = "0" },
      { name = "vmseries01-mgmt", index = "1" },
    ]
  }
]

firewall-bootstrap-options = {
  "mgmt-interface-swap" = "enable"
  "plugin-op-commands"  = "aws-gwlb-inspect:enable"
  "type"                = "dhcp-client"
  "tplname"             = "AWS-VM-tempstack"
  "dgname"              = "AWS-VM-DG"
  "vm-auth-key"         = "014268505534875"
  "panorama-server"     = "__panorama_ip__"
  "type"                        = "dhcp-client"
  "dhcp-accept-server-hostname" = "yes"
  "dns-primary"                 = "169.254.169.254"
  "dns-secondary"               = "8.8.8.8"
}

firewall-interfaces = [
  {
    name              = "vmseries01-data"
    source_dest_check = false
    subnet_name       = "ngfw-data-subnet"
    security_group    = "ngfw-data-sg"
  },
  {
    name              = "vmseries01-mgmt"
    source_dest_check = true
    subnet_name       = "ngfw-mgmt-subnet"
    security_group    = "ngfw-mgmt-sg"
    create_public_ip  = true
  }
]

gateway_load_balancer = {
  name           = "security-gwlb"
  subnet_names   = ["ngfw-data-subnet"]
  firewall_names = ["vmseries01"]
  vpc            = "sec-vpc"
}

gateway_load_balancer_endpoints = {
  sec-vpc-gwlbe = {
    name                  = "sec-vpc-gwlbe"
    gateway_load_balancer = "security-gwlb"
    subnet_names          = ["gwlbe-subnet"]
    vpc                   = "sec-vpc"
  },
  ftp-svr-vpc-gwlbe = {
    name                  = "ftp-svr-vpc-gwlbe"
    gateway_load_balancer = "security-gwlb"
    subnet_names          = ["gwlbe-subnet"]
    vpc                   = "ftp-svr-vpc"
  }
}

# VPN configuration
customer-gateway = {
  name    = "aws-customer-gw"
  type    = "ipsec.1"
  bgp_asn = 65000
}

# The Remote Peer IP to be configured on the AWS Customer Gateway
vpn-static-ip           = "__customer_gateway_ip__"

# Transit Gateway Routes to configured for VPN
transit-gateway-vpn-routes = {
  "vpn-to-sec-vpc-route" = {
    route_table = "vpn"
    vpc_name    = "sec-vpc"
    cidr_block  = "0.0.0.0/0"
  },
  "sec-vpc-to-gcp-route-1" = {
    route_table = "from-sec-vpc"
    vpc_name    = "vpn"
    cidr_block  = "192.168.3.0/28"
  },
  "sec-vpc-to-gcp-route-2" = {
    route_table = "from-sec-vpc"
    vpc_name    = "vpn"
    cidr_block  = "192.168.4.0/28"
  }
}