variable "name" {
  type        = string
  description = "Name of the rancher stack"
}

variable "environment_id" {
  type        = string
  description = "Identifier of rancher env"
}

variable "target_fqdn" {
  type        = string
  description = "DNS entry that point to pg nodes"
}

variable "target_port" {
  type        = number
  description = "Port to reach pg nodes"
  default     = 5432
}

variable "target_maxCount" {
  type        = number
  description = "Max entry in the DNS record"
  default     = 8
}

variable "db_user" {
  type        = string
  description = "Username to use to connect DB"
  default     = "postgres"
}

variable "db_password" {
  type        = string
  description = "Password to use to connect DB"
}

variable "db_name" {
  type        = string
  description = "Name of the database"
  default     = "postgres"
}

variable "db_version" {
  type        = number
  description = "Major version of the postgres cluster"
}

variable "global" {
  type        = bool
  description = "Deploy haproxy on all hosts"
  default     = false
}

variable "affinity" {
  type        = string
  description = "Host Affinity label value. ex: application=true or application=true,integration=true"
  default     = ""
}
