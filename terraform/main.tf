terraform {
  required_providers {
    yandex = {
      source = "yandex-cloud/yandex"
    }
  }
}

provider "yandex" {}

resource "yandex_compute_instance" "app" {
  name = "reddit-app"

  resources {
    cores  = 1
    memory = 2
  }

  boot_disk {
    initialize_params {
      image_id = "fd8g17150trtl64i5i0k"
    }
  }

  network_interface {
    subnet_id = "b0cnunlut438e9ntfb0u"
    nat       = true
  }
}
