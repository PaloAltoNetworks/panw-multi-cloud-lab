############################################################
# Make sure to fill in the values for access-key, secret-key
# and region before running the terraform.
############################################################
access-key      = ""
secret-key      = ""
region          = "us-east-1"
ssh-key-name    = "qwikLABS-*"

# Pre-defined tags. You can choose to modify these if you want to.
prefix-name-tag = "multicloud-lab-"
global-tags         = {
  managedBy   = "Terraform"
  application = "Palo Alto Networks - MultiCloud Lab"
  owner       = "Palo Alto Networks - Software NGFW Products Team"
}