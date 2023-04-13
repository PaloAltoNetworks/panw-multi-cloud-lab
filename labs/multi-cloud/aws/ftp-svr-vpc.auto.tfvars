ftp-svr-vpc = {
  name                 = "ftp-svr-vpc"
  cidr_block           = "10.1.0.0/16"
  instance_tenancy     = "default"
  enable_dns_support   = true
  enable_dns_hostnames = true
  internet_gateway     = true
}

ftp-svr-vpc-route-tables = [
  { name = "app-rt", "subnet" = "ftp-server-subnet" },
  { name = "gwlbe-rt", "subnet" = "gwlbe-subnet" },
  { name = "igw-rt", "edge" = "igw" }
]

ftp-svr-vpc-subnets = [
  { name = "ftp-server-subnet", cidr = "10.1.1.0/24", az = "a" },
  { name = "gwlbe-subnet", cidr = "10.1.2.0/24", az = "a" },
  { name = "tgw-subnet", cidr = "10.1.3.0/24", az = "a" }
]

ftp-svr-vpc-instances = [
  {
    name            = "ftp-server"
    instance_type   = "t2.micro"
    subnet          = "ftp-server-subnet"
    setup-file      = "ec2-startup-scripts/ftp-svr.sh"
    private_ips     = ["10.1.1.100"]
    security_group  = "ftp-svr-vpc-sg"
    ami_id          = "ami-08bc06c2d6aaf837c"   # Custom FTP Server AMI
  }
]

ftp-svr-vpc-routes = {
  app-edge-gwlbe = {
    name          = "edge-gwlbe"
    vpc_name      = "ftp-svr-vpc"
    route_table   = "igw-rt"
    prefix        = "10.1.1.0/24"
    next_hop_type = "gateway_load_balancer_endpoint"
    next_hop_name = "gwlbe"
  },
  app-gwlbe-out = {
    name          = "gwlbe-out"
    vpc_name      = "ftp-svr-vpc"
    route_table   = "gwlbe-rt"
    prefix        = "0.0.0.0/0"
    next_hop_type = "internet_gateway"
    next_hop_name = "igw"
  },
  app-tgw-1 = {
    name          = "app-tgw-1"
    vpc_name      = "ftp-svr-vpc"
    route_table   = "app-rt"
    prefix        = "192.168.3.0/28"
    next_hop_type = "transit_gateway"
    next_hop_name = "tgw"
  },
  app-tgw-2 = {
    name          = "app-tgw-2"
    vpc_name      = "ftp-svr-vpc"
    route_table   = "app-rt"
    prefix        = "192.168.4.0/28"
    next_hop_type = "transit_gateway"
    next_hop_name = "tgw"
  },
  app-tgw-3 = {
    name          = "app-tgw-3"
    vpc_name      = "ftp-svr-vpc"
    route_table   = "app-rt"
    prefix        = "10.2.0.0/16"
    next_hop_type = "transit_gateway"
    next_hop_name = "tgw"
  },
  app-app-gwlbe = {
    name          = "app-app-gwlbe"
    vpc_name      = "ftp-svr-vpc"
    route_table   = "app-rt"
    prefix        = "0.0.0.0/0"
    next_hop_type = "gateway_load_balancer_endpoint"
    next_hop_name = "gwlbe"
  }
}

ftp-svr-vpc-security-groups = [
  {
    name = "ftp-svr-vpc-sg"
    rules = [
      {
        description = "Permit All traffic outbound"
        type        = "egress", from_port = "0", to_port = "0", protocol = "-1"
        cidr_blocks = ["0.0.0.0/0"]
      },
      {
        description = "Permit Port 22 Public"
        type        = "ingress", from_port = "22", to_port = "22", protocol = "tcp"
        cidr_blocks = ["0.0.0.0/0"]
      },
      {
        description = "Permit ICMP Public"
        type        = "ingress", from_port = "-1", to_port = "-1", protocol = "icmp"
        cidr_blocks = ["0.0.0.0/0"]
      },
      {
        description = "Permit FTP over VPN"
        type        = "ingress", from_port = "20", to_port = "21", protocol = "tcp"
        cidr_blocks = ["192.168.0.0/16", "10.2.0.0/16"]
      },
    ]
  }
]