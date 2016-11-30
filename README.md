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
ansible-playbook -vv deploy.yaml -i qaa-ansible-inventory/prod0.yaml deploy.yaml
```

### Adjustable: 
1. CPUs
2. Kernel Version (with a caveat)

You can adjust the level of concurrency to speed compilation of the kernel - on local vagrant VM with 1 CPUs timed ~2hr.s, on local vagrant VM w/ 6 CPUs timed around 18min.s, and on a UCS server you can get the time down further by changing CPUs to 40 or so - be careful to not overallocate, 80% of CPUs is fine since you'll be rebooting anyways.
```
ansible-playbook -vv deploy.yaml -i qaa-inventory/prod0.yaml deploy.yaml --extra-vars 'kernel_ver=4.4.xx' --extra-vars 'cpus=40'
```

If you do choose to change the kernel version you will need a kernel.config file so that you do not need to interactively make menuconfig. You can get it from an existing server with a .config file. You will have to do this once per kernel version and swap out the current kernel.config OR you can just and those to the repo as we go, with vesions tagged to the end of their name and just update the playbook to use the version at the end to id the file.

A usable kernel config with default options are included in the file folder of the kernel-upgrade role for 4.4.23.


### Playbook tested against:
1. ansible 2.1.1.0 
2. vagrant 1.8.4.
3. linx-kernel 4.4.23
4. Centos 7 and 7.2
