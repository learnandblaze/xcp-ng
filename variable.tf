variable "worker_node_count" {
  description = "Number of worker nodes"
  type        = number
  default     = 2
}

variable "vm_memory" {
  description = "VM memory (in MB)"
  type        = number
  default     = 4096
}

variable "vm_vcpus" {
  description = "Number of VM vCPUs"
  type        = number
  default     = 2
}
