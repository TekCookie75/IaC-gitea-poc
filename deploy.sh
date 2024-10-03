# Setup the correct SELinux label to allow access to the config
chcon --verbose --type svirt_home_t ${PWD}/Fedora-CoreOS.ign

# Start a Fedora CoreOS virtual machine
virt-install --connect="qemu:///system" --name=fcos --vcpus=2 --ram=2048 --os-variant=fedora-coreos-stable \
    --import --graphics=none \
    --qemu-commandline="-fw_cfg name=opt/com.coreos/config,file=${PWD}/Fedora-CoreOS.ign" \
    --disk=size=20,backing_store=${PWD}/iso/fedora-coreos.qcow2 \
    --disk path=/var/lib/libvirt/images/container-volumes.qcow2,size=5 \
    --check path_in_use=off
