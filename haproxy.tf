resource "rancher_stack" "haproxy" {
  name            = var.name
  description     = "HAProxy for postgres cluster"
  environment_id  = var.environment_id
  start_on_create = true
  finish_upgrade  = true
  depends_on      = ["rancher_secret.haproxy-config"]

  docker_compose  = templatefile("${path.module}/haproxy/docker-compose.yml",
                                 { name     = var.name,
                                   global   = var.global,
                                   affinity = var.affinity })
  rancher_compose = templatefile("${path.module}/haproxy/rancher-compose.yml",
                                 { global   = var.global,
                                   user     = var.db_user,
                                   password = var.db_password,
                                   dbname   = var.db_name,
                                   version  = var.db_version })
}

resource rancher_secret "haproxy-config" {
  name           = "${var.name}-haproxy-config"
  environment_id = var.environment_id
  value          = templatefile("${path.module}/haproxy/haproxy.cfg", { fqdn = var.target_fqdn,
                                                                        maxCount = var.target_maxCount,
                                                                        port = var.target_port })
}
