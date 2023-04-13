
variable "project_id" {
  description = "Project ID"
  type        = string
}

variable "region" {
  description = "Region"
  type        = string
}

variable "public_key_path" {
  description = "Local path to public SSH key. To generate the key pair use `ssh-keygen -t rsa -C admin -N '' -f id_rsa`  If you do not have a public key, run `ssh-keygen -f ~/.ssh/demo-key -t rsa -C admin`"
  type        = string
}

variable "panorama_image_name" {
  description = "The Panorama image name including the project name where it exists"
  type        = string
}

variable "panorama_machine_type" {
  description = "Panorama Machine Type"
  type        = string
}

variable "prefix" {
  description = "The prefix to be used in the GCP Resources name"
  type        = string
}

variable "panorama_subnetwork" {
  description = "The subnetwork in which the panorama interface will be connected to"
  type        = string
}