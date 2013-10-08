guest iptables not working after libvirt restarts
=================================================

This is a proof of concept of iptables issues on libvirt versions
older than 0.9.13:

http://wiki.libvirt.org/page/Networking#Forwarding_Incoming_Connections

Steps to reproduce inside the vagrant box:

    sudo virsh start guest
    sudo iptables-save > iptables.before
    sudo service libvirt-bin restart
    sudo iptables-save > iptables.after

See how rule for 192.168.122.10/32 moves below REJECT on FORWARD
after restarting libvirt-bin.

