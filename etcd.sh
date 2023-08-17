#!/bin/bash

# Variables
ETCD_VERSION="3.5.0"  # Replace with the desired etcd version
ETCD_CLUSTER_SIZE=3   # Number of etcd nodes in the cluster
KUBE_APISERVER="https://kube-apiserver-url"  # Replace with your kube-apiserver URL

# Install etcd on each node
for i in $(seq 1 $ETCD_CLUSTER_SIZE); do
    # Install etcd binary (replace with your method)
    curl -L https://github.com/etcd-io/etcd/releases/download/v${ETCD_VERSION}/etcd-v${ETCD_VERSION}-linux-amd64.tar.gz | tar xz
    sudo mv etcd-v${ETCD_VERSION}-linux-amd64/etcd* /usr/local/bin/

    # Start etcd
    sudo mkdir -p /etc/etcd /var/lib/etcd
    sudo cp ca.pem kubernetes.pem kubernetes-key.pem /etc/etcd/
    sudo ETCD_NAME=etcd$i ETCD_INITIAL_CLUSTER_STATE=existing ETCD_INITIAL_CLUSTER="etcd1=https://ip1:2380,etcd2=https://ip2:2380,etcd3=https://ip3:2380" ETCD_INITIAL_ADVERTISE_PEER_URLS="https://ip$i:2380" ETCD_ADVERTISE_CLIENT_URLS="https://ip$i:2379" ETCD_LISTEN_PEER_URLS="https://0.0.0.0:2380" ETCD_LISTEN_CLIENT_URLS="https://0.0.0.0:2379" ETCD_CERT_FILE="/etc/etcd/kubernetes.pem" ETCD_KEY_FILE="/etc/etcd/kubernetes-key.pem" ETCD_PEER_CERT_FILE="/etc/etcd/kubernetes.pem" ETCD_PEER_KEY_FILE="/etc/etcd/kubernetes-key.pem" ETCD_TRUSTED_CA_FILE="/etc/etcd/ca.pem" ETCD_PEER_TRUSTED_CA_FILE="/etc/etcd/ca.pem" etcd &

    # Verify etcd is running
    ETCDCTL_API=3 etcdctl --endpoints=https://127.0.0.1:2379 --cacert=/etc/etcd/ca.pem --cert=/etc/etcd/kubernetes.pem --key=/etc/etcd/kubernetes-key.pem endpoint health
done

# Configure kube-apiserver to use etcd
sudo sed -i "s/ETCD_ENDPOINTS.*/ETCD_ENDPOINTS=\"https:\/\/ip1:2379,https:\/\/ip2:2379,https:\/\/ip3:2379\"/" /etc/kubernetes/apiserver

# Restart kube-apiserver
sudo systemctl restart kube-apiserver