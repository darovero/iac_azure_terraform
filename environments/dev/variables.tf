variable "subscription_id" {
  description = "Azure Subscription ID donde se desplegarán los recursos"
  type        = string
  sensitive   = true
}

variable "tenant_id" {
  description = "Azure Tenant ID"
  type        = string
  sensitive   = true
}

variable "location" {
  description = "Región de Azure"
  type        = string
}

variable "owner" {
  description = "Propietario de los recursos"
  type        = string
}

variable "environment" {
  description = "Ambiente de despliegue"
  type        = string
}

variable "project" {
  description = "Nombre corto del proyecto"
  type        = string
}