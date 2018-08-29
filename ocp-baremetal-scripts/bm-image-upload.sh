#!/bin/bash
source /home/stack/overcloudrc
KERNEL_ID=$(openstack image create --file /home/stack/ocp-baremetal-scripts/rhel-bm-image.vmlinuz --public \
    --container-format aki --disk-format aki -f value -c id \
    rhel-bm-image.vmlinuz)
RAMDISK_ID=$(openstack image create --file /home/stack/ocp-baremetal-scripts/rhel-bm-image.initrd --public \
    --container-format ari --disk-format ari -f value -c id \
    rhel-bm-image.initrd)
openstack image create --file /home/stack/ocp-baremetal-scripts/rhel-bm-image --public \
    --container-format bare --disk-format raw \
    --property kernel_id=$KERNEL_ID --property ramdisk_id=$RAMDISK_ID \
    rhel-bm-image
