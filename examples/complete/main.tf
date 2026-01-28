provider "alicloud" {
  region = var.region
}

data "alicloud_zones" "default" {
  available_resource_creation = "VSwitch"
}

data "alicloud_instance_types" "default" {
  instance_type_family = "ecs.g7"
  sorted_by            = "CPU"
  memory_size          = "16"
}

resource "random_integer" "default" {
  min = 100000
  max = 999999
}

module "ack_hpa_cluster" {
  source = "../.."

  # Basic Configuration
  availability_zones = [data.alicloud_zones.default.zones[0].id, data.alicloud_zones.default.zones[1].id]

  # VPC Configuration
  vpc_cidr_block      = var.vpc_cidr_block
  vpc_name            = "${var.common_name}-vpc"
  vswitch1_cidr_block = var.vswitch1_cidr_block
  vswitch1_name       = "${var.common_name}-vswitch1"
  vswitch2_cidr_block = var.vswitch2_cidr_block
  vswitch2_name       = "${var.common_name}-vswitch2"

  # Security Group Configuration
  security_group_name = "${var.common_name}-sg"

  # Cluster Configuration
  managed_kubernetes_cluster_name = var.managed_kubernetes_cluster_name
  cluster_spec                    = var.cluster_spec
  service_cidr                    = var.service_cidr
  new_nat_gateway                 = true
  slb_internet_enabled            = true

  # Node Pool Configuration
  node_pool_name          = "${var.common_name}-nodepool"
  instance_types          = [data.alicloud_instance_types.default.ids[0]]
  system_disk_category    = var.system_disk_category
  system_disk_size        = var.system_disk_size
  runtime_name            = var.runtime_name
  runtime_version         = var.runtime_version
  scaling_config_min_size = var.scaling_config_min_size
  scaling_config_max_size = var.scaling_config_max_size

  # SLS Configuration
  sls_project_name = "${var.sls_project_name}-${random_integer.default.result}"

  # ROS Stack Configuration
  ros_stack_name = "${var.common_name}-k8s-resource-${random_integer.default.result}"
  ros_parameters = [
    {
      parameter_key   = "cluster_id"
      parameter_value = module.ack_hpa_cluster.cluster_id
    },
    {
      parameter_key   = "sls_project_name"
      parameter_value = module.ack_hpa_cluster.sls_project_name
    }
  ]
}