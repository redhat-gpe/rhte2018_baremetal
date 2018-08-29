for bm in ocp01 ocp02 ocp03 cns01 cns02 cns03; do 
  openstack baremetal node set $bm --property  root_device='{"name":"/dev/vda"}'
done

