resource "byteplus_vke_cluster" "this" {
  name                      = "byteplus-test-deployment-alpha"
  description               = "created by terraform"
  delete_protection_enabled = false
  cluster_config {
    subnet_ids                       = [byteplus_subnet.this_private.id]
    api_server_public_access_enabled = false
    resource_public_access_default_enabled = false
  }
  pods_config {
    pod_network_mode = "VpcCniShared"
    vpc_cni_config {
      subnet_ids = [byteplus_subnet.this_private.id]
    }
  }
  services_config {
    service_cidrsv4 = ["172.30.0.0/18"]
  }
}