## Instructions

#### VMWare
1) Install vmware fusion and vagrant

2) type "vagrant plugin install vagrant-vmware-fusion"

3) type "vagrant plugin license vagrant-vmware-fusion license.lic"

4) type "vagrant up --provider vmware_fusion"

5) If you get an error message "The HGFS kernel module was not found on the running virtual machine." type "vagrant reload".

6) If the puppset manifests don't run, type "vagrant reload".

#### Virtualbox
1) Install vitrualbox fusion and vagrant

2) change "vmware = true" to "vmware = false" in the Vagrantfile

3) type "vagrant up" in this cloned repo

4) type "vagrant provision" after booted

#### Vagrant ssh

To start this party:

3) type "vagrant ssh" to ssh into new box

#### Using browser

1) type 'ifconfig' in the vm. Grab the IP number from the eth0. for virtualbox this should just be 33.33.33.33. For VMware it wil be something like 192.168.231.132.
2) add the ip address and site name to the /etc/hosts file. type: "sudo vim /etc/hosts" and enter IP_ADDRESS URL for any sites you use on the vm. Example:

192.168.231.132 nydmv.local

for dmv on VMware


