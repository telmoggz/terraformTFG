variable "public_ip" {
  description = "Public IP address to allow SSH access"
  type        = string
}

variable "jump_ip" {
  description = "Jump host IP address"
  type        = string
}

variable "app2_ip" {
  description = "App2 host IP address"
  type        = string
}

variable "postgresql_ip" {
  description = "PostgreSQL host IP address"
  type        = string
}