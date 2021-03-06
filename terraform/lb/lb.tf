resource "yandex_lb_target_group" "lb_target_group" {
  name = "reddit-lb-target-group"

  dynamic "target" {
    iterator = ip_address
    for_each = values(yandex_compute_instance.app).*.network_interface.0.ip_address
    content {
      subnet_id = var.subnet_id
      address   = ip_address.value
    }
  }
}

resource "yandex_lb_network_load_balancer" "lb" {
  name = "reddit-lb"

  listener {
    name = "reddit-lb-listener"
    port = var.reddit_app_port
    external_address_spec {
      ip_version = "ipv4"
    }
  }

  attached_target_group {
    target_group_id = yandex_lb_target_group.lb_target_group.id

    healthcheck {
      name = "http"
      http_options {
        port = var.reddit_app_port
        path = "/"
      }
    }
  }
}
