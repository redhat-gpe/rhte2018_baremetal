#! /bin/bash
DEPLOY_KERNEL=$(openstack image show bm-deploy-kernel -f value -c id)
DEPLOY_RAMDISK=$(openstack image show bm-deploy-ramdisk -f value -c id)
for uuid in $(openstack baremetal node list --provision-state enroll -f value -c UUID);
do
    openstack baremetal node set $uuid \
        --driver-info deploy_kernel=$DEPLOY_KERNEL \
        --driver-info deploy_ramdisk=$DEPLOY_RAMDISK \
        --driver-info rescue_kernel=$DEPLOY_KERNEL \
        --driver-info rescue_ramdisk=$DEPLOY_RAMDISK
    openstack baremetal node manage $uuid --wait &&
        openstack baremetal node provide $uuid
done
