# Define the Ubuntu VM template
resource "xcpng_vm" "k8s_node" {
  name         = "k8s-node-${count.index}"
  template     = "Ubuntu 20.04"
  memory       = var.vm_memory
  vcpus        = var.vm_vcpus
  auto_poweron = true
  network {
    network_name = "k8s-xcphyper"
  }
  count        = var.worker_node_count
}

