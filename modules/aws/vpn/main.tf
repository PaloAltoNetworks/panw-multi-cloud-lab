
locals {
  tunnel_details = {
    tunnel1_address       = aws_vpn_connection.this.tunnel1_address
    tunnel1_preshared_key = aws_vpn_connection.this.tunnel1_preshared_key
    tunnel2_address       = aws_vpn_connection.this.tunnel2_address
    tunnel2_preshared_key = aws_vpn_connection.this.tunnel2_preshared_key
  }

  tgw-attach-ids = merge(var.tgw-attach-ids, {
    "${var.prefix-name-tag}vpn" = aws_vpn_connection.this.transit_gateway_attachment_id
  })

  tgw-rt-ids = merge(var.tgw-rt-ids, {
    "${var.prefix-name-tag}vpn" = data.aws_ec2_transit_gateway_route_table.vpn.id
  })
}

data "aws_ec2_transit_gateway_route_table" "vpn" {
  filter {
    name = "transit-gateway-id"
    values = [ var.transit-gateway-id ]
  }

  filter {
    name   = "default-association-route-table"
    values = ["true"]
  }

  depends_on = [
    aws_vpn_connection.this
  ]
}

resource "aws_customer_gateway" "this" {
  device_name = "${var.prefix-name-tag}${var.customer-gateway.name}"
  bgp_asn     = var.customer-gateway.bgp_asn
  ip_address  = var.vpn-static-ip
  type        = var.customer-gateway.type
  tags        = merge({ Name = "${var.prefix-name-tag}${var.customer-gateway.name}" }, var.global-tags)
}

resource "aws_vpn_connection" "this" {
  customer_gateway_id   = aws_customer_gateway.this.id
  transit_gateway_id    = var.transit-gateway-id
  type                  = var.customer-gateway.type
  static_routes_only    = true
}

resource "aws_ec2_transit_gateway_route" "this" {
  for_each = { for key, value in var.transit-gateway-vpn-routes: key => value }

  destination_cidr_block          = each.value.cidr_block
  transit_gateway_attachment_id   = local.tgw-attach-ids["${var.prefix-name-tag}${each.value.vpc_name}"]
  transit_gateway_route_table_id  = local.tgw-rt-ids["${var.prefix-name-tag}${each.value.route_table}"]

  depends_on = [
    data.aws_ec2_transit_gateway_route_table.vpn
  ]
}