#!/bin/bash

exec openstack overcloud deploy \
        --templates /usr/share/openstack-tripleo-heat-templates \
        -e /home/stack/templates/overcloud_images.yaml \
        -e /home/stack/templates/node-info.yaml \
        -e /usr/share/openstack-tripleo-heat-templates/environments/network-isolation.yaml \
        -e /home/stack/templates/network-environment.yaml \
        -e /home/stack/templates/HostnameMap.yaml \
        -e /usr/share/openstack-tripleo-heat-templates/environments/storage/external-ceph.yaml \
        -e /usr/share/openstack-tripleo-heat-templates/environments/services/ironic.yaml \
        -e /home/stack/templates/ironic-config.yaml \
         --ntp-server pool.ntp.org \

