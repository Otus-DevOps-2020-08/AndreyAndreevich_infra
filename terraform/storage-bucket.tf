terraform {
  backend "s3" {
    endpoint                    = "storage.yandexcloud.net"
    bucket                      = "otus-hw-terraform-storage"
    region                      = "ru-central-1"
    key                         = "terraform.tfstate"
    access_key                  = "access_key"
    secret_key                  = "secret_key"
    skip_region_validation      = true
    skip_credentials_validation = true
  }
}
