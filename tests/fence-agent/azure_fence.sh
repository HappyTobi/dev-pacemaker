#!/bin/bash

export SUBSCRIPTION_ID="<USE_OWN_VARS>"
export APPLICATION_ID="<USE_OWN_VARS>"
export APPLICATION_KEY="<USE_OWN_VARS>"
export TENANT_ID="<USE_OWN_VARS>"
export AZURE_RESOURCE_GROUP="<USE_OWN_VARS>"
export AZURE_VM_NAME="<USE_OWN_VARS>"

function cleanupEnv() {
    unset SUBSCRIPTION_ID
    unset APPLICATION_ID
    unset APPLICATION_KEY
    unset TENANT_ID
}

trap cleanupEnv EXIT

# Remove all python dependencies
function removeAzureDependencies() {
    echo "Remove all Azure dependencies"

    pip uninstall -y azure-core && \
    pip uninstall -y azure-common && \
    pip uninstall -y azure-mgmt-compute && \
    pip uninstall -y azure-mgmt-core && \
    pip uninstall -y azure-mgmt-network && \
    pip uninstall -y azure-identity && \
    pip uninstall -y msrest && \
    pip uninstall -y msal && \
    pip uninstall -y msal-extensions

    echo "Done"
}

function installSuseDependencies() {
    pip install azure-core==1.32.0 && \
    pip install azure-mgmt-core==1.5.0 && \
    pip install azure-mgmt-compute==34.0.0 && \
    pip install azure-mgmt-network==28.1.0 && \
    pip install azure-identity==1.19.0 && \
    pip install azure-common==1.1.28
}

function installRhel9Dependencies() {
    pip install adal==1.2.7 && \
    pip install azure_common==1.1.27 && \
    pip install azure_core==1.15.0 && \
    pip install azure_identity==1.10.0 && \
    pip install azure_mgmt_compute==21.0.0 && \
    pip install azure_mgmt_core==1.2.2 && \
    pip install azure_mgmt_network==19.0.0 && \
    pip install msal_extensions==1.0.0 && \
    pip install msrest==0.6.21 && \
    pip install msrestazure==0.6.4
}

function installRhel8DependenciesNew() {
    pip install azure-core==1.24.2 && \
    pip install azure-common==1.1.28 && \
    pip install azure-mgmt-compute==27.2.0 && \
    pip install azure-mgmt-core==1.3.2 && \
    pip install azure-mgmt-network==20.0.0 && \
    pip install azure-identity==1.10.0 && \
    pip install msrest==0.7.1 && \
    pip install msal==1.27.0 && \
    pip install msal-extensions==1.0.0
    sleep 10
}

function installRhel8DependenciesOld() {
    pip install azure_common==1.1.19 && \
    pip install azure_mgmt_compute==5.0.0 && \
    pip install adal==1.2.0 && \
    pip install msrest==0.6.2
    sleep 10
}

function runPythonTest() {
    echo "Run AZURE-FENCE tests for $1"
    python3 -m unittest ./azure_fence_test.py || { echo "azure fence failed failed $1" ; exit 1; }
}

# Suse test set
removeAzureDependencies > /dev/null 2>&1
installSuseDependencies > /dev/null 2>&1
runPythonTest "suse"
removeAzureDependencies > /dev/null 2>&1

# RHEL 8 test (new dependencies)
installRhel8DependenciesNew > /dev/null 2>&1
runPythonTest "rhel8-new"
removeAzureDependencies > /dev/null 2>&1

# RHEL 8 test
installRhel8DependenciesOld > /dev/null 2>&1
runPythonTest "rhel8-old"
removeAzureDependencies > /dev/null 2>&1

# RHEL 9 test
installRhel9Dependencies > /dev/null 2>&1
runPythonTest "rhel9"
removeAzureDependencies  > /dev/null 2>&1
