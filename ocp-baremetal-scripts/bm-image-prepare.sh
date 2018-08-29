#!/bin/bash
export DIB_LOCAL_IMAGE=/home/stack/ocp-baremetal-scripts/rhel-server-7.5-x86_64-kvm.qcow2
export DIB_YUM_REPO_CONF=/etc/yum.repos.d/open.repo
disk-image-create rhel7 baremetal dhcp-all-interfaces grub2 -t raw -u -o rhel-bm-image
