FROM ubuntu:14.04

# Install.
RUN \
   apt-get update && \
   apt-get -y upgrade && \
   apt-get -y install python python-pip python-dev libffi-dev libssl-dev git libguac-client-rdp0 guacd \
   python-virtualenv python-setuptools libjpeg-dev zlib1g-dev swig mongodb libcap2-bin libguac-client-vnc0 \
   postgresql libpq-dev qemu-kvm libvirt-bin ubuntu-vm-builder bridge-utils python-libvirt libguac-client-ssh0 && \
   echo deb http://download.virtualbox.org/virtualbox/debian xenial contrib | sudo tee -a /etc/apt/sources.list.d/virtualbox.list && \
   wget -q https://www.virtualbox.org/download/oracle_vbox_2016.asc -O- | sudo apt-key add - && \
   apt-get update && \
   apt-get install virtualbox-5.2 tcpdump && \ 
   pip install m2crypto==0.24.0 && \
   pip install XenAPI && \
   groupadd pcap && \
   usermod -a -G pcap cuckoo && \
   chgrp pcap /usr/sbin/tcpdump && \
   setcap cap_net_raw,cap_net_admin=eip /usr/sbin/tcpdump && \
   git clone https://github.com/volatilityfoundation/volatility && \
   cd volatility && python setup.py install && \
   adduser cuckoo && usermod -a -G vboxusers cuckoo && usermod -a -G libvirtd cuckoo && \
   pip install -U pip setuptools && pip install -U cuckoo && \
   
# Skip launching services for now.
cmd ["bin/bash"]
