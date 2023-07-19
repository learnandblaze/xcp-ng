#!/bin/bash

# Initialize Terraform
terraform init

# Plan the infrastructure changes
terraform plan

# Apply the infrastructure changes
terraform apply -auto-approve

# Get the Kubernetes master node information
master_ip=$(terraform output -raw k8s_master_ip)
master_port=$(terraform output -raw k8s_master_port)
token=$(terraform output -raw k8s_token)
ca_cert_hash=$(terraform output -raw k8s_ca_cert_hash)

# Modify bootstrap.sh script with the obtained information
sed -i "s/<master-node-ip>/$master_ip/g" bootstrap.sh
sed -i "s/<master-node-port>/$master_port/g" bootstrap.sh
sed -i "s/<token>/$token/g" bootstrap.sh
sed -i "s/<ca-cert-hash>/$ca_cert_hash/g" bootstrap.sh

# Provision the Kubernetes cluster on worker nodes
for ((i=0; i<${var.worker_node_count}; i++)); do
  worker_ip=$(terraform output -raw "k8s_worker_ips[$i]")
  ssh $worker_ip 'curl -LO https://raw.githubusercontent.com/your-username/bootstrap.sh && chmod +x bootstrap.sh && ./bootstrap.sh'
done
