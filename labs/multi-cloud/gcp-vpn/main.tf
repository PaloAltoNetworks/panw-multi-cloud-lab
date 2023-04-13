
locals {
  prefix = var.prefix != null && var.prefix != "" ? "${var.prefix}-" : ""

  raw_data                = jsondecode(file("~/outputs.json"))
  vpn_tunnel_details      = local.raw_data.AWS_VPN_DETAILS.value
  aws_customer_gateway_ip = local.raw_data.CUSTOMER_GATEWAY_IP_ADDRESS.value
}


data "google_compute_network" "spoke2-vpc" {
  name = "${local.prefix}spoke2-vpc"
}


// Provisions a VPN Gateway
resource "google_compute_vpn_gateway" "target_gateway" {
  name    = "vpn-network"
  network = data.google_compute_network.spoke2-vpc.id
}


# Tunnel creation requires the following rules to approve
// Creating Forwarding Rules
resource "google_compute_forwarding_rule" "fr_esp" {
  name        = "fr-esp"
  ip_protocol = "ESP"
  ip_address  = local.aws_customer_gateway_ip
  target      = google_compute_vpn_gateway.target_gateway.id
}


resource "google_compute_forwarding_rule" "fr_udp500" {
  name        = "fr-udp500"
  ip_protocol = "UDP"
  port_range  = "500"
  ip_address  = local.aws_customer_gateway_ip
  target      = google_compute_vpn_gateway.target_gateway.id
}


resource "google_compute_forwarding_rule" "fr_udp4500" {
  name        = "fr-udp4500"
  ip_protocol = "UDP"
  port_range  = "4500"
  ip_address  = local.aws_customer_gateway_ip
  target      = google_compute_vpn_gateway.target_gateway.id
}


// Provision VPN Tunnel # 1
resource "google_compute_vpn_tunnel" "vpn-1" {
  name                    = "vpn-1"
  peer_ip                 = local.vpn_tunnel_details.tunnel1_address
  shared_secret           = local.vpn_tunnel_details.tunnel1_preshared_key
  remote_traffic_selector = [var.aws_vpc_cidr_block]
  local_traffic_selector  = ["0.0.0.0/0"]
  ike_version             = 1

  target_vpn_gateway = google_compute_vpn_gateway.target_gateway.id

  depends_on = [
    google_compute_forwarding_rule.fr_esp,
    google_compute_forwarding_rule.fr_udp500,
    google_compute_forwarding_rule.fr_udp4500,
  ]
}


// Provision VPN Tunnel # 2
resource "google_compute_vpn_tunnel" "vpn-2" {
  name                    = "vpn-2"
  peer_ip                 = local.vpn_tunnel_details.tunnel2_address
  shared_secret           = local.vpn_tunnel_details.tunnel2_preshared_key
  remote_traffic_selector = [var.aws_vpc_cidr_block]
  local_traffic_selector  = ["0.0.0.0/0"]
  ike_version             = 1

  target_vpn_gateway = google_compute_vpn_gateway.target_gateway.id

  depends_on = [
    google_compute_forwarding_rule.fr_esp,
    google_compute_forwarding_rule.fr_udp500,
    google_compute_forwarding_rule.fr_udp4500,
  ]
}


// Provision a GCP Route - Tunnel1
resource "google_compute_route" "route1" {
  name       = "aws-route-tunnel1"
  network    = data.google_compute_network.spoke2-vpc.name
  dest_range = var.aws_vpc_cidr_block
  priority   = 1000

  next_hop_vpn_tunnel = google_compute_vpn_tunnel.vpn-1.id
}


// Provision a GCP Route - Tunnel2
resource "google_compute_route" "route2" {
  name       = "aws-route-tunnel2"
  network    = data.google_compute_network.spoke2-vpc.name
  dest_range = var.aws_vpc_cidr_block
  priority   = 1000

  next_hop_vpn_tunnel = google_compute_vpn_tunnel.vpn-2.id
}
