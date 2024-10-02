#!/bin/bash

#echo "Login into azure az login ..."
#az login --service-principal -u $ARM_CLIENT_ID -p $ARM_CLIENT_SECRET --tenant $ARM_TENANT_ID

echo "Clone latest sourcecode from github into docker volume ..."
if [ -d "src/azure_instance_metadata_service_simulator"]; then
    echo "azure_instance_metadata_service_simulator already downloaded"
else
    pushd src
        git clone https://github.com/chgeuer/azure_instance_metadata_service_simulator.git
    popd
fi

if [ -d "src/resource-agents" ]; then
    echo "resource-agents already cloned"
else
    pushd src
        git clone https://github.com/ClusterLabs/resource-agents.git
    popd
fi


echo "installing go packages"
go install -v  golang.org/x/tools/gopls@latest
go install -v  github.com/cweill/gotests/gotests@latest
go install -v  github.com/fatih/gomodifytags@latest
go install -v  github.com/josharian/impl@latest
go install -v  github.com/haya14busa/goplay/cmd/goplay@latest
go install -v  github.com/go-delve/delve/cmd/dlv@latest
go install -v  honnef.co/go/tools/cmd/staticcheck@latest

# Add ip address to eth0 device
ip a add 169.254.169.254/255.255.255.0 dev eth0:1
