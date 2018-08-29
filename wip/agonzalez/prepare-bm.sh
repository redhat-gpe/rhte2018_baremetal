#!/bin/sh
source ~/overcloudrc
openstack network create \
  --provider-network-type flat \
  --provider-physical-network baremetal \
  --share baremetal

openstack subnet create \
  --network baremetal \
  --subnet-range 192.0.3.0/24 \
  --ip-version 4 \
  --gateway 192.0.3.1 \
  --allocation-pool start=192.0.3.10,end=192.0.3.200 \
  --dhcp baremetal

cd images/
openstack image create \
  --container-format aki \
  --disk-format aki \
  --public \
  --file ./ironic-python-agent.kernel bm-deploy-kernel

openstack image create \
  --container-format ari \
  --disk-format ari \
  --public \
  --file ./ironic-python-agent.initramfs bm-deploy-ramdisk


openstack flavor create \
  --id auto --ram  4096 \
  --vcpus 2 --disk 40 \
  --property baremetal=true \
  --public baremetal

openstack aggregate create --property baremetal=true baremetal-hosts
openstack aggregate add host baremetal-hosts overcloud-controller-0.example.com
openstack aggregate create --property baremetal=false octavia_65

