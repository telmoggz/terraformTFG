variable "resource_group_name" {
  description = "The name of the resource group where the resources will be created."
  type        = string
}

variable "location" {
  description = "The Azure region where the resources will be created."
  type        = string
}

variable "jump_ip" {
  description = "The IP address of the jump server."
  type        = string
}

variable "app2_ip" {
  description = "The IP address of the app2 server."
  type        = string
}

variable "postgres_name" {
  description = "The name of the PostgreSQL server."
  type        = string
}

variable "postgres_admin_username" {
  description = "The admin username for the PostgreSQL server."
  type        = string
}

variable "postgres_admin_password" {
  description = "The admin password for the PostgreSQL server."
  type        = string
  sensitive   = true
}

variable "postgres_sku_name" {
  description = "The SKU name for the PostgreSQL server."
  type        = string
}

variable "postgres_version" {
  description = "The version of the PostgreSQL server."
  type        = string
}

variable "virtual_network_name" {
  description = "The name of the virtual network."
  type        = string
}

variable "postgres_storage_mb" {
  description = "The storage size in MB for the PostgreSQL server."
  type        = number
}

variable "postgres_backup_retention_days" {
  description = "The backup retention period in days for the PostgreSQL server."
  type        = number
}

variable "postgres_geo_redundant_backup_enabled" {
  description = "Whether to enable geo-redundant backup for the PostgreSQL server."
  type        = bool
}

variable "hub_resource_group_name" {
  description = "The name of the hub resource group."
  type        = string
}

variable "postgres_active_directory_auth_enabled" {
  description = "Whether to enable Active Directory authentication for the PostgreSQL server."
  type        = bool
}

variable "postgres_password_auth_enabled" {
  description = "Whether to enable password authentication for the PostgreSQL server."
  type        = bool
}

variable "postgres_tenant_id" {
  description = "The Azure Active Directory tenant ID."
  type        = string
}

variable "postgres_db_name" {
  description = "The name of the PostgreSQL database to create."
  type        = string
}