variable "elastic_pool_name" {
  type = string
}

variable "resource_group_name" {
  type = string
}

variable "location" {
  type = string
}

variable "server_name" {
  type = string
}

variable "sku_name" {
  type    = string
  default = "GP_Gen5"
}

variable "sku_tier" {
  type    = string
  default = "GeneralPurpose"
}

variable "sku_family" {
  type    = string
  default = "Gen5"
}

variable "vcores" {
  type    = number
  default = 2
}

variable "min_capacity_per_db" {
  type    = number
  default = 0
}

variable "max_capacity_per_db" {
  type    = number
  default = 1
}

variable "max_size_bytes" {
  type    = number
  default = 34359738368
}

variable "tags" {
  type    = map(string)
  default = {}
}