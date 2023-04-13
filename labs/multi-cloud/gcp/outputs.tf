output "PANORAMA_IP" {
  description = "External load balancer's frontend address that distributes internet traffic to VM-Series untrust interfaces."
  value       = module.panorama.PANORAMA_IP
}

output "PANORAMA_URL" {
  description = "The public IP address of the Panorama instance deployed on GCP."
  value       = "https://${module.panorama.PANORAMA_IP}"
}

output "VPN_STATIC_IP" {
  description = "The IP address to be used for the customer gateway configuration on AWS side."
  value       = google_compute_address.vpn_static_ip.address
}