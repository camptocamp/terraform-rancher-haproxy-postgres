resource "rancher_stack" "haproxy" {
  name            = var.name
  description     = "HAProxy for postgres cluster"
  environment_id  = var.environment_id
  start_on_create = true
  finish_upgrade  = true
  depends_on      = ["rancher_secret.haproxy-config"]

  docker_compose  = templatefile("${path.module}/docker-compose.yml", { name = var.name })
  rancher_compose = file("${path.module}/rancher-compose.yml")

}

resource rancher_secret "haproxy-config" {
  name           = "${var.name}-haproxy-config"
  environment_id = var.environment_id
  value          = templatefile("${path.module}/haproxy.cfg", { fqdn = var.target_fqdn,
                                                                maxCount = var.target_maxCount,
                                                                port = var.target_port })
}
