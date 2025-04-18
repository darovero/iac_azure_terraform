variable "aks_name" {
  description = "Nombre del clúster AKS"
  type        = string
}

variable "location" {
  description = "Ubicación de Azure"
  type        = string
}

variable "resource_group_name" {
  description = "Grupo de recursos donde se desplegará el AKS"
  type        = string
}

variable "node_count" {
  description = "Número de nodos del pool"
  type        = number
  default     = 1
}

variable "vm_size" {
  description = "Tamaño de las VMs en el node pool"
  type        = string
  default     = "Standard_B2s"
}

variable "kubernetes_version" {
  description = "Versión de Kubernetes a usar"
  type        = string
  default     = "1.28.3"
}

variable "tags" {
  description = "Etiquetas para el AKS"
  type        = map(string)
  default     = {}
}
