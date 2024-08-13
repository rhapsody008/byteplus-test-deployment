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

resource "byteplus_security_group" "this" {
  security_group_name = "byteplus-test-deployment-security-group"
  vpc_id              = byteplus_vpc.this.id
}

data "byteplus_images" "this" {
  name_regex = "veLinux 1.0 CentOS兼容版 64位"
}

resource "byteplus_vke_node_pool" "this" {
  cluster_id = byteplus_vke_cluster.this.id
  name       = "byteplus-test-deployment-node-pool"
  auto_scaling {
    enabled          = true
    min_replicas     = 2
    max_replicas     = 5
    desired_replicas = 2
    priority         = 5
    subnet_policy    = "ZoneBalance"
  }
  node_config {
    instance_type_ids = ["ecs.g1ie.xlarge"]
    subnet_ids        = [byteplus_subnet.this_private.id]
    image_id          = [for image in data.byteplus_images.this.images : image.image_id if image.image_name == "veLinux 1.0 CentOS兼容版 64位"][0]
    system_volume {
      type = "ESSD_PL0"
      size = 80
    }
    data_volumes {
      type        = "ESSD_PL0"
      size        = 80
      mount_point = "/tf1"
    }
    data_volumes {
      type        = "ESSD_PL0"
      size        = 60
      mount_point = "/tf2"
    }
    initialize_script = "ZWNobyBoZWxsbyB0ZXJyYWZvcm0h"
    security {
      login {
        password = "UHdkMTIzNDU2"
      }
      security_strategies = ["Hids"]
      security_group_ids  = [byteplus_security_group.this.id]
    }
    additional_container_storage_enabled = false
    instance_charge_type                 = "PostPaid"
    name_prefix                          = "byteplus-test-deployment"
  }
  kubernetes_config {
    taints {
      key    = "node.cilium.io/agent-not-ready"
      effect = "NoExecute"
    }
    cordon = true
  }
}