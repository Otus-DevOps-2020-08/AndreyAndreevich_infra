variable cloud_id {
  description = "Cloud"
}
variable folder_id {
  description = "Folder"
}
variable zone {
  description = "Zone"
  default     = "ru-central1-a"
}
variable app_zone {
  description = "App Zone"
  default     = "ru-central1-a"
}
variable service_account_key_file {
  description = "key.json"
}
variable public_key_path {
  description = "Path to the public key used for ssh access"
}
variable reddit_app_port {
  description = "Reddit app port"
  default     = 9292
}
variable app_disk_image {
  description = "Disk image for reddit app"
}
variable db_disk_image {
  description = "Disk image for reddit db"
}
