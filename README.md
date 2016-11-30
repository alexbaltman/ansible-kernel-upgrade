# qaa-ansible-kernel-upgrade
This playbook is used to fetch, compile, and install new kernels on linux - in particular, RedHat and CentOS.

### Usage
For local dev:
```
cd local_dev
vagrant up
``` 

For remote servers:
```
./getinventory.sh
ansible-playbook -vv deploy.yaml -i qaa-inventory/prod0.yaml deploy.yaml
```

### Adjustable: 
You can adjust the level of concurrency to speed compilation of the kernel - on local vagrant VM with 1 CPU timed ~2hr.s, on local vagrant VM w/ 6 CPU timed around 18min.s, and on a UCS server you can get the time down further by changing cpus to 40 or so - be careful to not overallocate, 80% of CPUs is fine since you'll be reboot anyways.
```
ansible-playbook -vv deploy.yaml -i qaa-inventory/prod0.yaml deploy.yaml --extra-vars 'kernel_ver=4.4.xx' --extra-vars 'cpus=40'
```

If you do choose to change the kernel version you will need a kernel.config so that you do not need to interactively make menuconfig. You will have to do this once per kernel version and swap out the current kernel.config OR you can ADD those to the repo as we go with vesions tagged to their name and just update the playbook.

Updating the kernel.config will let you silently compile the kernel. You can create this by manually compiling the kernel on one of the hosts one time, the resulting config can be found inside the folder where the kernel is compiled. This playbook expects the kernel config file (kernel.config) file to be in the file folder of the kernel-upgrade role.

A usable kernel config with default options are included in the script folder for 4.4.23.


### Playbook tested against:
1. ansible 2.1.1.0 
2. vagrant 1.8.4.
3. linx-kernel 4.4.23
4. Centos 7 and 7.2
