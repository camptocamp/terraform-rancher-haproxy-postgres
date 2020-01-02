variable "name" {
  type        = string
  description = "Name of the rancher stack"
}

variable "environment_name" {
  type        = string
  description = "Name of rancher env"
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
