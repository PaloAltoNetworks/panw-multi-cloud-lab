
variable "customer-gateway"             { default = {} }
variable "vpn-static-ip"                { default = "" }
variable "transit-gateway-id"           { default = "" }
variable "tgw-attach-ids"               { default = {} }
variable "tgw-rt-ids"                   { default = {} }
variable "prefix-name-tag"              { default = "" }
variable "global-tags"                  { default = {} }
variable "transit-gateway-vpn-routes"   { default = {} }