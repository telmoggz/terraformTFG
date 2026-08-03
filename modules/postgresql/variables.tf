variable "server_name" {
  description = "The name of the PostgreSQL server."
  type        = string
}

variable "resource_group_name" {
  description = "The name of the resource group in which to create the PostgreSQL server."
  type        = string
}

variable "location" {
  description = "The Azure region in which to create the PostgreSQL server."
  type        = string
}

variable "postgres_version" {
  description = "The version of the PostgreSQL server."
  type        = string
  default     = "14"
}

variable "delegated_subnet_id" {
  description = "The ID of the subnet to which the PostgreSQL server will be delegated."
  type        = string
}

variable "private_dns_zone_id" {
  description = "The ID of the private DNS zone to which the PostgreSQL server will be linked."
  type        = string
}

variable "administrator_login" {
  description = "The administrator login name for the PostgreSQL server."
  type        = string
}

variable "administrator_password" {
  description = "The administrator password for the PostgreSQL server."
  type        = string
  sensitive   = true
}

variable "sku_name" {
  description = "The SKU name for the PostgreSQL server."
  type        = string
}

variable "storage_mb" {
  description = "The storage size in MB for the PostgreSQL server."
  type        = number
}

variable "backup_retention_days" {
  description = "The number of days to retain backups for the PostgreSQL server."
  type        = number
  default     = 7
}

variable "geo_redundant_backup_enabled" {
  description = "Whether to enable geo-redundant backups for the PostgreSQL server."
  type        = bool
  default     = false
}

variable "active_directory_auth_enabled" {
  description = "Whether to enable Active Directory authentication for the PostgreSQL server."
  type        = bool
  default     = false
}

variable "password_auth_enabled" {
  description = "Whether to enable password authentication for the PostgreSQL server."
  type        = bool
  default     = true
}

variable "tenant_id" {
  description = "The Azure Active Directory tenant ID for the PostgreSQL server."
  type        = string
  default     = null
}

variable "ssl_enforcement_enabled" {
  description = "Whether to enforce SSL connections for the PostgreSQL server."
  type        = bool
  default     = true
}

variable "db_name" {
  description = "The name of the database to create in the PostgreSQL server."
  type        = string
  default     = null
}

variable "public_network_access_enabled" {
  description = "Whether to allow public network access to the PostgreSQL server."
  type        = bool
  default     = false
}