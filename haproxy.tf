resource "rancher_stack" "haproxy" {
  name            = var.name
  description     = "HAProxy for postgres cluster"
  environment_id  = var.environment_id
  start_on_create = true
  finish_upgrade  = true

  docker_compose = templatefile("${path.module}/haproxy/docker-compose.yml",
    {
      global   = var.global,
      affinity = var.affinity,
      secret   = rancher_secret.haproxy-config.name,
    }
  )
  rancher_compose = templatefile("${path.module}/haproxy/rancher-compose.yml",
    {
      global   = var.global,
      user     = var.db_user,
      password = var.db_password,
      dbname   = var.db_name,
      version  = var.db_version,
      scale    = var.scale,
    }
  )
}

resource "rancher_secret" "haproxy-config" {
  name           = "${var.name}-haproxy-config"
  environment_id = var.environment_id
  value = templatefile("${path.module}/haproxy/haproxy.cfg",
    {
      fqdn     = var.target_fqdn,
      maxCount = var.target_maxCount,
      port     = var.target_port,
    }
  )
}
