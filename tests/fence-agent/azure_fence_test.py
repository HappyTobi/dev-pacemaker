#!/bin/python
import sys

sys.path.append("/usr/share/fence")
import azure_fence
import unittest
import os


class TestClass(unittest.TestCase):
    def test_get_azure_cloud_environment(self):
        config = azure_fence.AzureConfiguration()

        config.SubscriptionId = os.environ.get('SUBSCRIPTION_ID')
        config.ApplicationId = os.environ.get('APPLICATION_ID')
        config.ApplicationKey = os.environ.get('APPLICATION_KEY')
        config.Tenantid = os.environ.get('TENANT_ID')

        cloudEnvironment = azure_fence.get_azure_cloud_environment(config)
        self.assertIsNotNone(cloudEnvironment)

    def test_get_azure_credentials(self):
        config = azure_fence.AzureConfiguration()

        config.SubscriptionId = os.environ.get('SUBSCRIPTION_ID')
        config.ApplicationId = os.environ.get('APPLICATION_ID')
        config.ApplicationKey = os.environ.get('APPLICATION_KEY')
        config.Tenantid = os.environ.get('TENANT_ID')

        credentials = azure_fence.get_azure_credentials(config)
        self.assertIsNotNone(credentials)

    def test_get_compute_client_and_vm(self):
        config = azure_fence.AzureConfiguration()

        config.SubscriptionId = os.environ.get('SUBSCRIPTION_ID')
        config.ApplicationId = os.environ.get('APPLICATION_ID')
        config.ApplicationKey = os.environ.get('APPLICATION_KEY')
        config.Tenantid = os.environ.get('TENANT_ID')

        resourceGroup = os.environ.get('AZURE_RESOURCE_GROUP')
        vmName = os.environ.get('AZURE_VM_NAME')

        compute_client = azure_fence.get_azure_compute_client(config)
        vm = azure_fence.get_vm_resource(compute_client,resourceGroup,vmName)

        self.assertIsNotNone(vm)

if __name__=='__main__':
    unittest.main()