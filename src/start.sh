#!/bin/bash

#Start fake ims server
pushd /workspaces/dev-pacemaker/src/azure_instance_metadata_service_simulator/
    if [ -f "server.process" ]; then
        processId=$(cat "server.process")
        kill "${processId}"
        echo "Process killed ${processId}"
    fi

    rm -rf server.process
    go build -o bin/server server.go
    bin/server &
    echo $! > server.process
    echo "Azure ims fake server started"
    echo "ip a add 169.254.169.254/255.255.255.0 dev eth0:1"
popd

# Create fake binary
if [ ! -f "/usr/local/bin/crm_attribute" ]; then
    touch "/usr/local/bin/crm_attribute"
    chmod +x "/usr/local/bin/crm_attribute"
    cat > "/usr/local/bin/crm_attribute" << EOF
#!/bin/bash

echo "0"
exit 0

EOF
fi

# Create fake binary
if [ ! -f "/usr/local/bin/crm_resource" ]; then
    touch "/usr/local/bin/crm_resource"
    chmod +x "/usr/local/bin/crm_resource"

    cat > "/usr/local/bin/crm_resource" << EOF
#!/bin/bash

echo "3799c4856bff-fooobar"
exit 0

EOF
fi

if [ ! -f "/usr/local/bin/crm_node" ]; then
    touch "/usr/local/bin/crm_node"
    chmod +x "/usr/local/bin/crm_node"

    cat > "/usr/local/bin/crm_node" << EOF
#!/bin/bash

echo "3799c4856bff-57F3-4603-9B60-9B923FCC2743 6CBA910B-57F3-4603-9B60-9B923FCC2743"
exit 0

EOF
fi