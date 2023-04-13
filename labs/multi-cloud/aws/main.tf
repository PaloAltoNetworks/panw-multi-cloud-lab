
locals {
  vpcs = {
    "${module.ftp-svr-vpc.vpc_details.name}"  : module.ftp-svr-vpc.vpc_details,
    "${module.ftp-client-vpc.vpc_details.name}"  : module.ftp-client-vpc.vpc_details,
    "${module.security-vpc.vpc_details.name}"  : module.security-vpc.vpc_details
  }
}

module "ftp-svr-vpc" {
  source          = "../../../modules/aws/vpc"
  vpc             = var.ftp-svr-vpc
  prefix-name-tag = var.prefix-name-tag
  subnets         = var.ftp-svr-vpc-subnets
  route-tables    = var.ftp-svr-vpc-route-tables
  security-groups = var.ftp-svr-vpc-security-groups
  ec2-instances   = var.ftp-svr-vpc-instances
  global-tags     = var.global-tags
}

module "ftp-client-vpc" {
  source          = "../../../modules/aws/vpc"
  vpc             = var.ftp-client-vpc
  prefix-name-tag = var.prefix-name-tag
  subnets         = var.ftp-client-vpc-subnets
  route-tables    = var.ftp-client-vpc-route-tables
  security-groups = var.ftp-client-vpc-security-groups
  ec2-instances   = var.ftp-client-vpc-instances
  global-tags     = var.global-tags
}

module "security-vpc" {
  source          = "../../../modules/aws/vpc"
  vpc             = var.security-vpc
  prefix-name-tag = var.prefix-name-tag
  subnets         = var.security-vpc-subnets
  route-tables    = var.security-vpc-route-tables
  security-groups = var.security-vpc-security-groups
  global-tags     = var.global-tags
}

module "vm-series" {
  source            = "../../../modules/aws/vmseries"
  fw_product_code   = var.fw_product_code
  fw_version        = var.fw_version
  firewalls         = var.firewalls
  fw_interfaces     = var.firewall-interfaces
  ssh_key_name      = module.security-vpc.ssh_key_name
  prefix-name-tag   = var.prefix-name-tag
  vpc_name          = module.security-vpc.vpc_name
  subnet_ids        = module.security-vpc.subnet_ids
  security_groups   = module.security-vpc.security_groups
  bootstrap_options = var.firewall-bootstrap-options
  global_tags       = var.global-tags
}

module "gwlb" {
  source                = "../../../modules/aws/gwlb"
  gateway_load_balancer = var.gateway_load_balancer
  gateway_load_balancer_endpoints = var.gateway_load_balancer_endpoints
  firewall              = module.vm-series.firewall
  subnets_map           = module.security-vpc.subnet_ids
  sec_vpc_id            = module.security-vpc.vpc_id
  vpcs                  = local.vpcs
  prefix_name_tag       = var.prefix-name-tag
  global_tags           = var.global-tags
}

module "transit-gateway" {
  source          = "../../../modules/aws/transit-gateway"
  transit-gateway = var.transit-gateway
  prefix-name-tag = var.prefix-name-tag
  global_tags     = var.global-tags
  vpcs            = local.vpcs
  transit-gateway-associations = var.transit-gateway-associations
  transit-gateway-routes       = var.transit-gateway-routes
}


# VPN configuration
module "vpn" {
  source                      = "../../../modules/aws/vpn"
  customer-gateway            = var.customer-gateway
  vpn-static-ip               = var.vpn-static-ip
  transit-gateway-id          = module.transit-gateway.tgw-ids["${var.prefix-name-tag}tgw"]
  transit-gateway-vpn-routes  = var.transit-gateway-vpn-routes
  tgw-attach-ids              = module.transit-gateway.tgw-attach-ids
  tgw-rt-ids                  = module.transit-gateway.tgw-rt-ids
  prefix-name-tag             = var.prefix-name-tag
}


module "vpc-routes" {
  source          = "../../../modules/aws/vpc_routes"
  vpc-routes      = merge(var.ftp-svr-vpc-routes, var.security-vpc-routes, var.ftp-client-vpc-routes)
  vpcs            = local.vpcs
  tgw-ids         = module.transit-gateway.tgw-ids
  eni_ids         = module.vm-series.vmseries-eni-ids
  gwlbe_ids       = module.gwlb.gwlbe_ids
  prefix-name-tag = var.prefix-name-tag
}