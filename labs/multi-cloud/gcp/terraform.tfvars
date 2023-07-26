# Required values to be updated
project_id              = "__project_id__"
public_key_path         = "~/.ssh/gcp-demo.pub"
prefix                  = "multicloud-lab"

# Panorama configuration
vm-auth-key             = "320657398936352"
dgname                  = "GCP-VM-DG"
tplname                 = "GCP-VM-Tempstack"

mgmt_allow_ips          = ["0.0.0.0/0"]
vmseries_image_name     = "vmseries-flex-bundle2-1022h2"
region                  = "us-central1"
cidr_mgmt               = "192.168.0.0/28"
cidr_untrust            = "192.168.1.0/28"
cidr_trust              = "192.168.2.0/28"
cidr_spoke1             = "192.168.3.0/28"
cidr_spoke2             = "192.168.4.0/28"
create_spoke_networks   = true