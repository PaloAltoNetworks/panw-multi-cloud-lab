output "vpc_details" {
  value = {
    "id"              : aws_vpc.this.id
    "name"            : aws_vpc.this.tags["Name"]
    "internet_gateway": local.igw-id
    "subnet_ids"      : local.subnet_ids
    "vpc_route_tables": local.vpc_route_table_ids
    "security-groups" : local.sg-ids
    "instance"        : local.ec2-ids
  }
}

output "ssh_key_name" {
  value = data.aws_key_pair.key_name.key_name
}

output "vpc_id" {
  value = aws_vpc.this.id
}

output "vpc_name" {
  value = aws_vpc.this.tags["Name"]
}

output "igw_id" {
  value = local.igw-id
}

output "subnet_ids" {
  value = local.subnet_ids
}

output "vpc_route_tables" {
  value = local.vpc_route_table_ids
}

output "security_groups" {
  value = local.sg-ids
}

output "instance_ids" {
  value = local.ec2-ids
}

output "natgw_ids" {
  value = local.natgw_ids
}

output "instance_ips" {
  value = local.ec2-ips
}