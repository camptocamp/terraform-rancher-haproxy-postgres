resource "rancher_stack" var.name {
  name            = var.name
  description     = "HAProxy for postgres cluster"
  environment_id  = var.environment_id
  start_on_create = true
  finish_upgrade  = true
  depends_on      = ['rancher_secret.haproxy-config']

  docker_compose  = templatefile("${path.module}/docker-compose.yml", { host_label = var.host_label })
  rancher_compose = templatefile("${path.module}/rancher-compose.yml", {})

}

resource rancher_secret "haproxy-config" {
  name           = "${var.name}-haproxy-config"
  environment_id = var.environment_id
  value          = templatefile("${path.module}/haproxy.cfg", { fqdn = var.target_fqdn })
}
