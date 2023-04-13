
output "CUSTOMER_GATEWAY_IP_ADDRESS" {
  value = module.vpn.CUSTOMER_GATEWAY_IP_ADDRESS
  sensitive = true
}

output "AWS_VPN_DETAILS" {
  value = module.vpn.VPN_TUNNEL_DETAILS
  sensitive = true
}