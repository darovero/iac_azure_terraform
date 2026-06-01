variable "cosmosdb_account_name" {
  type = string
}

variable "resource_group_name" {
  type = string
}

variable "location" {
  type = string
}

variable "offer_type" {
  type    = string
  default = "Standard"
}

variable "mongo_server_version" {
  type    = string
  default = "4.2"
}

variable "consistency_level" {
  type    = string
  default = "Session"
}

variable "databases" {
  type = map(object({
    name       = string
    throughput = optional(number)
  }))
  default = {}
}

variable "collections" {
  type = map(object({
    name         = string
    database_key = string
    shard_key    = string
    throughput   = optional(number)
  }))
  default = {}
}

variable "tags" {
  type    = map(string)
  default = {}
}