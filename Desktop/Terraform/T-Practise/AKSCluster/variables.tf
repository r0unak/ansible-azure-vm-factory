variable "location" {
  type    = string
  default = "eastus"
}

variable "resource_group_name" {
  type    = string
  default = "my-rg"
}

variable "environment" {
  type = string
  default = "prod"
}

variable "kubernetes_version" {
  type = string
  default = "1.33.1"
} 

variable "enable_resource_lock" {
  description = "Enable resource lock to prevent manual deletion of resources"
  default     = false
  type        = bool
}

variable "subscription_id" { type = string }
variable "client_id"       { type = string }
variable "client_secret"   { type = string }
variable "tenant_id"       { type = string }
