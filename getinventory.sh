#!/bin/bash

if [ ! -d './qaa-ansible-inventory' ]; then
    git clone git@github.com:cisco-cis/qaa-ansible-inventory.git 
    if [[ $? -eq 0 ]]; then
        exit 0
    else 
        echo 'Clone Failed.' 
        exit 1
    fi
else
    cd qaa-ansible-inventory && git pull
    if [[ $? -eq 0 ]]; then
        exit 0
    else 
        echo 'Pull Failed.' 
        exit 1
    fi
fi
