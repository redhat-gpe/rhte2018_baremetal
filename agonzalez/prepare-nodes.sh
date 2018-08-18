#!/bin/sh
openstack baremetal node delete ocp-master01 ocp-infra01 ocp-app01
openstack baremetal create baremetal.yaml
KERNEL_ID=$(openstack image show bm-deploy-kernel -f value -c id)
RAMDISK_ID=$(openstack image show bm-deploy-ramdisk -f value -c id)
for bm in ocp-master01 ocp-infra01 ocp-app01; do 
  openstack baremetal node manage $bm; 
  openstack baremetal node provide $bm; 
  openstack baremetal node set $bm \
  --driver-info deploy_kernel=$KERNEL_ID \
  --driver-info deploy_ramdisk=$RAMDISK_ID
done

