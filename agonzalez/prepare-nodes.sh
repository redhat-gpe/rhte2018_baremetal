#!/bin/sh
source ~/overcloudrc
openstack baremetal node delete ocp01 ocp02 ocp03 cns01 cns02 cns03
openstack baremetal create baremetal.yaml
KERNEL_ID=$(openstack image show bm-deploy-kernel -f value -c id)
RAMDISK_ID=$(openstack image show bm-deploy-ramdisk -f value -c id)
for bm in ocp01 ocp02 ocp03 cns01 cns02 cns03; do 
  openstack baremetal node manage $bm; 
  openstack baremetal node set $bm \
  --driver-info deploy_kernel=$KERNEL_ID \
  --driver-info deploy_ramdisk=$RAMDISK_ID
  openstack baremetal node set $bm --property  root_device='{"name":"/dev/vda"}'
  openstack baremetal node provide $bm; 
done

