data "alicloud_ram_roles" "roles" {
  policy_type = "Custom"
  name_regex  = "^Aliyun.*Role$"
}

locals {
  zone1 = var.availability_zones[0]
  zone2 = var.availability_zones[1]

  cs_roles = [
    {
      name            = "AliyunCSManagedLogRole"
      policy_document = "{\"Statement\":[{\"Action\":\"sts:AssumeRole\",\"Effect\":\"Allow\",\"Principal\":{\"Service\":[\"cs.aliyuncs.com\"]}}],\"Version\":\"1\"}"
      description     = "The log component of the cluster uses this role to access your resources in other cloud products."
      policy_name     = "AliyunCSManagedLogRolePolicy"
    },
    {
      name            = "AliyunCSManagedCmsRole"
      policy_document = "{\"Statement\":[{\"Action\":\"sts:AssumeRole\",\"Effect\":\"Allow\",\"Principal\":{\"Service\":[\"cs.aliyuncs.com\"]}}],\"Version\":\"1\"}"
      description     = "The CMS component of the cluster uses this role to access your resources in other cloud products."
      policy_name     = "AliyunCSManagedCmsRolePolicy"
    },
    {
      name            = "AliyunCSManagedCsiRole"
      policy_document = "{\"Statement\":[{\"Action\":\"sts:AssumeRole\",\"Effect\":\"Allow\",\"Principal\":{\"Service\":[\"cs.aliyuncs.com\"]}}],\"Version\":\"1\"}"
      description     = "The storage component of the cluster uses this role to access your resources in other cloud products."
      policy_name     = "AliyunCSManagedCsiRolePolicy"
    },
    {
      name            = "AliyunCSManagedCsiPluginRole"
      policy_document = "{\"Statement\":[{\"Action\":\"sts:AssumeRole\",\"Effect\":\"Allow\",\"Principal\":{\"Service\":[\"cs.aliyuncs.com\"]}}],\"Version\":\"1\"}"
      description     = "The storage component of the cluster uses this role to access your resources in other cloud products."
      policy_name     = "AliyunCSManagedCsiPluginRolePolicy"
    },
    {
      name            = "AliyunCSManagedCsiProvisionerRole"
      policy_document = "{\"Statement\":[{\"Action\":\"sts:AssumeRole\",\"Effect\":\"Allow\",\"Principal\":{\"Service\":[\"cs.aliyuncs.com\"]}}],\"Version\":\"1\"}"
      description     = "The storage component of the cluster uses this role to access your resources in other cloud products."
      policy_name     = "AliyunCSManagedCsiProvisionerRolePolicy"
    },
    {
      name            = "AliyunCSManagedVKRole"
      policy_document = "{\"Statement\":[{\"Action\":\"sts:AssumeRole\",\"Effect\":\"Allow\",\"Principal\":{\"Service\":[\"cs.aliyuncs.com\"]}}],\"Version\":\"1\"}"
      description     = "The VK component of ACK Serverless cluster uses this role to access your resources in other cloud products."
      policy_name     = "AliyunCSManagedVKRolePolicy"
    },
    {
      name            = "AliyunCSServerlessKubernetesRole"
      policy_document = "{\"Statement\":[{\"Action\":\"sts:AssumeRole\",\"Effect\":\"Allow\",\"Principal\":{\"Service\":[\"cs.aliyuncs.com\"]}}],\"Version\":\"1\"}"
      description     = "The cluster uses this role by default to access your resources in other cloud products."
      policy_name     = "AliyunCSServerlessKubernetesRolePolicy"
    },
    {
      name            = "AliyunCSKubernetesAuditRole"
      policy_document = "{\"Statement\":[{\"Action\":\"sts:AssumeRole\",\"Effect\":\"Allow\",\"Principal\":{\"Service\":[\"cs.aliyuncs.com\"]}}],\"Version\":\"1\"}"
      description     = "The cluster audit function uses this role to access your resources in other cloud products."
      policy_name     = "AliyunCSKubernetesAuditRolePolicy"
    },
    {
      name            = "AliyunCSManagedNetworkRole"
      policy_document = "{\"Statement\":[{\"Action\":\"sts:AssumeRole\",\"Effect\":\"Allow\",\"Principal\":{\"Service\":[\"cs.aliyuncs.com\"]}}],\"Version\":\"1\"}"
      description     = "The cluster network component uses this role to access your resources in other cloud products."
      policy_name     = "AliyunCSManagedNetworkRolePolicy"
    },
    {
      name            = "AliyunCSDefaultRole"
      policy_document = "{\"Statement\":[{\"Action\":\"sts:AssumeRole\",\"Effect\":\"Allow\",\"Principal\":{\"Service\":[\"cs.aliyuncs.com\"]}}],\"Version\":\"1\"}"
      description     = "The cluster uses this role by default during cluster operations to access your resources in other cloud products."
      policy_name     = "AliyunCSDefaultRolePolicy"
    },
    {
      name            = "AliyunCSManagedKubernetesRole"
      policy_document = "{\"Statement\":[{\"Action\":\"sts:AssumeRole\",\"Effect\":\"Allow\",\"Principal\":{\"Service\":[\"cs.aliyuncs.com\"]}}],\"Version\":\"1\"}"
      description     = "The cluster uses this role by default to access your resources in other cloud products."
      policy_name     = "AliyunCSManagedKubernetesRolePolicy"
    },
    {
      name            = "AliyunCSManagedArmsRole"
      policy_document = "{\"Statement\":[{\"Action\":\"sts:AssumeRole\",\"Effect\":\"Allow\",\"Principal\":{\"Service\":[\"cs.aliyuncs.com\"]}}],\"Version\":\"1\"}"
      description     = "The cluster Arms plugin uses this role to access your resources in other cloud products."
      policy_name     = "AliyunCSManagedArmsRolePolicy"
    },
    {
      name            = "AliyunCISDefaultRole"
      policy_document = "{\"Statement\":[{\"Action\":\"sts:AssumeRole\",\"Effect\":\"Allow\",\"Principal\":{\"Service\":[\"cs.aliyuncs.com\"]}}],\"Version\":\"1\"}"
      description     = "Container Service (CS) intelligent operations uses this role to access your resources in other cloud products."
      policy_name     = "AliyunCISDefaultRolePolicy"
    },
    {
      name            = "AliyunOOSLifecycleHook4CSRole"
      policy_document = "{\"Statement\":[{\"Action\":\"sts:AssumeRole\",\"Effect\":\"Allow\",\"Principal\":{\"Service\":[\"oos.aliyuncs.com\"]}}],\"Version\":\"1\"}"
      description     = "Cluster scaling node pools depend on OOS service, OOS uses this role to access your resources in other cloud products."
      policy_name     = "AliyunOOSLifecycleHook4CSRolePolicy"
    },
    {
      name            = "AliyunCSManagedAutoScalerRole"
      policy_document = "{\"Statement\":[{\"Action\":\"sts:AssumeRole\",\"Effect\":\"Allow\",\"Principal\":{\"Service\":[\"cs.aliyuncs.com\"]}}],\"Version\":\"1\"}"
      description     = "The auto scaling component of the cluster uses this role to access your resources in other cloud products."
      policy_name     = "AliyunCSManagedAutoScalerRolePolicy"
    }
  ]

  all_role_names     = [for role in local.cs_roles : role.name]
  created_role_names = [for role in data.alicloud_ram_roles.roles.roles : role.name]
  complement_names   = setsubtract(local.all_role_names, local.created_role_names)
  complement_roles   = [for role in local.cs_roles : role if contains(local.complement_names, role.name)]
}

resource "alicloud_vpc" "vpc" {
  cidr_block = var.vpc_cidr_block
  vpc_name   = var.vpc_name
}

resource "alicloud_vswitch" "vswitch1" {
  vpc_id       = alicloud_vpc.vpc.id
  cidr_block   = var.vswitch1_cidr_block
  zone_id      = local.zone1
  vswitch_name = var.vswitch1_name
}

resource "alicloud_vswitch" "vswitch2" {
  vpc_id       = alicloud_vpc.vpc.id
  cidr_block   = var.vswitch2_cidr_block
  zone_id      = local.zone2
  vswitch_name = var.vswitch2_name
}

resource "alicloud_security_group" "sg" {
  vpc_id              = alicloud_vpc.vpc.id
  security_group_name = var.security_group_name
}

resource "alicloud_security_group_rule" "ingress_https" {
  security_group_id = alicloud_security_group.sg.id
  type              = var.https_rule_type
  ip_protocol       = var.https_rule_ip_protocol
  port_range        = var.https_rule_port_range
  cidr_ip           = var.https_rule_cidr_ip
}

resource "alicloud_security_group_rule" "ingress_http" {
  security_group_id = alicloud_security_group.sg.id
  type              = var.http_rule_type
  ip_protocol       = var.http_rule_ip_protocol
  port_range        = var.http_rule_port_range
  cidr_ip           = var.http_rule_cidr_ip
}

resource "alicloud_log_project" "sls_project" {
  project_name = var.sls_project_name
}

resource "alicloud_cs_managed_kubernetes" "ack" {
  depends_on = [
    alicloud_ram_role.role,
    alicloud_ram_role_policy_attachment.attach
  ]
  name                 = var.managed_kubernetes_cluster_name
  cluster_spec         = var.cluster_spec
  vswitch_ids          = [alicloud_vswitch.vswitch1.id, alicloud_vswitch.vswitch2.id]
  pod_vswitch_ids      = [alicloud_vswitch.vswitch1.id, alicloud_vswitch.vswitch2.id]
  service_cidr         = var.service_cidr
  new_nat_gateway      = var.new_nat_gateway
  slb_internet_enabled = var.slb_internet_enabled
  security_group_id    = alicloud_security_group.sg.id

  dynamic "addons" {
    for_each = var.cluster_addons
    content {
      name     = addons.value.name
      config   = lookup(addons.value, "config", "")
      version  = lookup(addons.value, "version", "")
      disabled = lookup(addons.value, "disabled", false)
    }
  }

  dynamic "delete_options" {
    for_each = var.delete_options
    content {
      delete_mode   = delete_options.value.delete_mode
      resource_type = delete_options.value.resource_type
    }
  }
}

resource "alicloud_cs_kubernetes_node_pool" "node_pool" {
  node_pool_name       = var.node_pool_name
  cluster_id           = alicloud_cs_managed_kubernetes.ack.id
  vswitch_ids          = [alicloud_vswitch.vswitch1.id, alicloud_vswitch.vswitch2.id]
  instance_types       = var.instance_types
  system_disk_category = var.system_disk_category
  system_disk_size     = var.system_disk_size

  runtime_name    = var.runtime_name
  runtime_version = var.runtime_version

  scaling_config {
    enable   = var.scaling_config_enable
    min_size = var.scaling_config_min_size
    max_size = var.scaling_config_max_size
  }
}

resource "alicloud_ros_stack" "deploy_k8s_resource" {
  stack_name   = var.ros_stack_name
  template_url = var.ros_template_url

  dynamic "parameters" {
    for_each = var.ros_parameters
    content {
      parameter_key   = parameters.value.parameter_key
      parameter_value = parameters.value.parameter_value
    }
  }

  disable_rollback = var.ros_disable_rollback
  depends_on       = [alicloud_cs_kubernetes_node_pool.node_pool]
}

resource "alicloud_ram_role" "role" {
  for_each                    = { for r in local.complement_roles : r.name => r }
  role_name                   = each.value.name
  assume_role_policy_document = each.value.policy_document
  description                 = each.value.description
  force                       = var.ram_role_force
}

resource "alicloud_ram_role_policy_attachment" "attach" {
  for_each    = { for r in local.complement_roles : r.name => r }
  policy_name = each.value.policy_name
  policy_type = var.ram_policy_type
  role_name   = each.value.name
  depends_on  = [alicloud_ram_role.role]
}