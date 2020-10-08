variable public_key_path {
  description = "Path to the public key used for ssh access"
}
variable app_disk_image {
  description = "Disk image for reddit db"
  default     = "reddit-db-base"
}
variable subnet_id {
  description = "Subnets for modules"
}
variable private_key_path {
  description = "Private key path for connect by ssh"
}
variable db_addr {
  description = "Address to db"
}
