#!/bin/sh
source ~/overcloudrc
openstack network create \
  --provider-network-type flat \
  --provider-physical-network baremetal \
  --share baremetal

openstack subnet create \
  --network baremetal \
  --subnet-range 192.0.2.0/24 \
  --ip-version 4 \
  --gateway 192.0.2.1 \
  --allocation-pool start=192.0.2.150,end=192.0.2.200 \
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

export DIB_LOCAL_IMAGE=rhel-server-7.5-x86_64-kvm.qcow2
export DIB_YUM_REPO_CONF=/etc/yum.repos.d/open.repo 
disk-image-create rhel7 baremetal -o rhel-image
KERNEL_ID=$(openstack image create \
  --file rhel-image.vmlinuz --public \
  --container-format aki --disk-format aki \
  -f value -c id rhel-image.vmlinuz)
RAMDISK_ID=$(openstack image create \
  --file rhel-image.initrd --public \
  --container-format ari --disk-format ari \
  -f value -c id rhel-image.initrd)
openstack image create \
  --file rhel-image.qcow2   --public \
  --container-format bare \
  --disk-format qcow2 \
  --property kernel_id=$KERNEL_ID \
  --property ramdisk_id=$RAMDISK_ID \
  rhel-image



