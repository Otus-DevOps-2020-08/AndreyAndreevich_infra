variable cloud_id {
  description = "Cloud"
}
variable folder_id {
  description = "Folder"
}
variable zone {
  description = "Zone"
  default     = "ru-central1-c"
}
variable app_zone {
  description = "App Zone"
  default     = "ru-central1-c"
}
variable image_id {
  description = "Disk image"
}
variable subnet_id {
  description = "Subnet"
}
variable service_account_key_file {
  description = "key.json"
}
variable public_key_path {
  description = "Path to the public key used for ssh access"
}
variable private_key_path {
  description = "Path to the private key"
}
variable reddit_app_port {
  description = "Reddit app port"
  default     = 9292
}
variable instances {
    description = "Reddit app instances"
    type = set(string)
    default = ["reddit-app", "reddit-app-2"]
}
