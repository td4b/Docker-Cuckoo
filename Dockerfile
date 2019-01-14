FROM ubuntu:14.04

# Install.
RUN \
   apt-get update && \
   apt-get -y upgrade && \
   apt-get -y install python python-pip python-dev libffi-dev libssl-dev \
   python-virtualenv python-setuptools libjpeg-dev zlib1g-dev swig mongodb libcap2-bin \
   postgresql libpq-dev qemu-kvm libvirt-bin ubuntu-vm-builder bridge-utils python-libvirt && \
   echo deb http://download.virtualbox.org/virtualbox/debian xenial contrib | sudo tee -a /etc/apt/sources.list.d/virtualbox.list && \
   wget -q https://www.virtualbox.org/download/oracle_vbox_2016.asc -O- | sudo apt-key add - && \
   apt-get update && \
   apt-get install virtualbox-5.2 tcpdump && \ 
   pip install XenAPI && \
   groupadd pcap && \
   usermod -a -G pcap cuckoo && \
   chgrp pcap /usr/sbin/tcpdump && \
   setcap cap_net_raw,cap_net_admin=eip /usr/sbin/tcpdump
   
   
# Skip launching services for now.
cmd ["bin/bash"]
