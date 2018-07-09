resource "google_compute_global_forwarding_rule" "puma_global_forwarding_rule" {
  name       = "puma-default-rule"
  target     = "${google_compute_target_http_proxy.puma_http_proxy.self_link}"
  port_range = "80"
}

resource "google_compute_target_http_proxy" "puma_http_proxy" {
  name    = "puma-http-proxy"
  url_map = "${google_compute_url_map.puma_url_map.self_link}"
}

resource "google_compute_url_map" "puma_url_map" {
  name            = "puma-url-map"
  default_service = "${google_compute_backend_service.puma_backend_service.self_link}"
}

resource "google_compute_backend_service" "puma_backend_service" {
  name          = "puma-backend-service"
  port_name     = "http"
  protocol      = "HTTP"
  timeout_sec   = 10
  health_checks = ["${google_compute_http_health_check.puma_health_check.self_link}"]

  backend {
    group = "${google_compute_instance_group.puma_group.self_link}"
  }
}

resource "google_compute_http_health_check" "puma_health_check" {
  name               = "puma-health-check"
  port               = "9292"
  request_path       = "/"
  check_interval_sec = 5
  timeout_sec        = 5
}

resource "google_compute_instance_group" "puma_group" {
  name = "puma-group"

  instances = [
    "${google_compute_instance.app.*.self_link}",
  ]

  named_port {
    name = "http"
    port = "9292"
  }

  zone = "${var.zone}"
}
