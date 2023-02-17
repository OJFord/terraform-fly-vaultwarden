variable "env" {
  type        = map(string)
  description = "Environment variables to set, i.e. Vaultwarden config"
  default     = {}
}

variable "region" {
  type        = string
  description = "Fly.io region name"
}

variable "size_gb" {
  type        = number
  description = "Size of volume in GB"
  default     = 3
}

variable "vaultwarden_version" {
  type        = string
  description = "Vaultwarden version number, 'latest', or 'testing'"
}
