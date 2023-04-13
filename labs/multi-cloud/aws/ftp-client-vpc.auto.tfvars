## PANORAMA
ftp-client-vpc = {
  name                 = "ftp-client-vpc"
  cidr_block           = "10.2.0.0/16"
  instance_tenancy     = "default"
  enable_dns_support   = true
  enable_dns_hostnames = true
  internet_gateway     = true
}

ftp-client-vpc-route-tables = [
  { name = "rt", "subnet" = "ftp-client-subnet" }
]

ftp-client-vpc-subnets = [
  { name = "ftp-client-subnet", cidr = "10.2.1.0/24", az = "a" },
  { name = "tgw-subnet", cidr = "10.2.2.0/24", az = "a" }
]

ftp-client-vpc-routes = {
  mgmt-out = {
    name          = "mgmt-out"
    vpc_name      = "ftp-client-vpc"
    route_table   = "rt"
    prefix        = "0.0.0.0/0"
    next_hop_type = "internet_gateway"
    next_hop_name = "igw"
  },
  mgmt-tgw = {
    name          = "mgmt-tgw"
    vpc_name      = "ftp-client-vpc"
    route_table   = "rt"
    prefix        = "10.1.0.0/16"
    next_hop_type = "transit_gateway"
    next_hop_name = "tgw"
  }
}

ftp-client-vpc-security-groups = [
  {
    name = "ftp-client-sg"
    rules = [
      {
        description = "Permit All traffic outbound"
        type        = "egress", from_port = "0", to_port = "0", protocol = "-1"
        cidr_blocks = ["0.0.0.0/0"]
      },
      {
        description = "Permit All HTTPS inbound traffic"
        type        = "ingress", from_port = "443", to_port = "443", protocol = "tcp"
        cidr_blocks = ["0.0.0.0/0"]
      },
      {
        description = "Permit All SSH inbound traffic"
        type        = "ingress", from_port = "22", to_port = "22", protocol = "tcp"
        cidr_blocks = ["0.0.0.0/0"]
      },
      {
        description = "Permit All ICMP traffic"
        type        = "ingress", from_port = "-1", to_port = "-1", protocol = "icmp"
        cidr_blocks = ["0.0.0.0/0"]
      }
    ]
  }
]

ftp-client-vpc-instances = [
  {
    name            = "ftp-client"
    instance_type   = "t2.micro"
    subnet          = "ftp-client-subnet"
    setup-file      = "ec2-startup-scripts/ftp-client.sh"
    private_ips     = ["10.2.1.100"]
    security_group  = "ftp-client-sg"
    ami_id          = "ami-0154cb224865a98b0"   # Custom Kali Linux AMI
  }
]