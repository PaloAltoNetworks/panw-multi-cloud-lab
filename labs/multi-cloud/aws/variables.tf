
variable "access-key"               { default = "" }
variable "secret-key"               { default = "" }
variable "region"                   { default = "" }
variable "ssh-key-name"             { default = "" }

variable "ftp-svr-vpc"                  { default = {} }
variable "ftp-svr-vpc-subnets"          { default = [] }
variable "ftp-svr-vpc-route-tables"     { default = [] }
variable "ftp-svr-vpc-security-groups"  { default = [] }
variable "ftp-svr-vpc-instances"        { default = [] }
variable "ftp-svr-vpc-routes"           { default = [] }

variable "security-vpc"                 { default = {} }
variable "security-vpc-subnets"         { default = [] }
variable "security-vpc-route-tables"    { default = [] }
variable "security-vpc-security-groups" { default = [] }
variable "security-vpc-routes"          { default = [] }

variable "fw_version"               { default = "" }
variable "fw_product_code"          { default = [] }

variable "firewalls"                    { default = [] }
variable "firewall-interfaces"          { default = [] }
variable "firewall-bootstrap-options"   { default = {} }

variable "ftp-client-vpc"                 { default = {} }
variable "ftp-client-vpc-subnets"         { default = [] }
variable "ftp-client-vpc-route-tables"    { default = [] }
variable "ftp-client-vpc-security-groups" { default = [] }
variable "ftp-client-vpc-instances"       { default = [] }
variable "ftp-client-vpc-routes"          { default = [] }
variable "panorama"                 { default = {} }

variable "nat-gateways"                     { default = {} }
variable "gateway_load_balancer"            { default = {} }
variable "gateway_load_balancer_endpoints"  { default = {} }

variable "transit-gateway"                  { default = {} }
variable "transit-gateway-associations"     { default = {} }
variable "transit-gateway-routes"           { default = {} }

variable "customer-gateway"                 { default = {} }
variable "vpn-static-ip"                    { default = "" }
variable "gcp-private-cidr-block"           { default = "" }
variable "transit-gateway-vpn-routes"       { default = {} }

variable "prefix-name-tag"          { default = "" }
variable "global-tags"              { default = {} }