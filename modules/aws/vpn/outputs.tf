
output "VPN_TUNNEL_DETAILS" {
  value = local.tunnel_details
}

output "CUSTOMER_GATEWAY_IP_ADDRESS" {
  value = aws_customer_gateway.this.ip_address
}

output "VPN_TGW_ROUTE_TABLE" {
  value = data.aws_ec2_transit_gateway_route_table.vpn
}

output "TGW_ATTACH_IDS" {
  value = local.tgw-attach-ids
}

output "TGW_RT_IDS" {
  value = local.tgw-rt-ids
}