variable "availability_zones" {
  type        = list(string)
  description = "List of availability zones for the VPC resources"
  validation {
    condition     = length(var.availability_zones) >= 2
    error_message = "At least two availability zones must be specified."
  }
}

variable "vpc_cidr_block" {
  type        = string
  description = "CIDR block for the VPC"
  default     = "10.0.0.0/8"
}

variable "vpc_name" {
  type        = string
  description = "Name of the VPC"
  default     = "ack-hpa-vpc"
}

variable "vswitch1_cidr_block" {
  type        = string
  description = "CIDR block for the first VSwitch"
  default     = "10.0.0.0/24"
}

variable "vswitch1_name" {
  type        = string
  description = "Name of the first VSwitch"
  default     = "ack-hpa-vswitch1"
}

variable "vswitch2_cidr_block" {
  type        = string
  description = "CIDR block for the second VSwitch"
  default     = "10.0.1.0/24"
}

variable "vswitch2_name" {
  type        = string
  description = "Name of the second VSwitch"
  default     = "ack-hpa-vswitch2"
}

variable "security_group_name" {
  type        = string
  description = "Name of the security group"
  default     = "ack-hpa-sg"
}

variable "https_rule_type" {
  type        = string
  description = "Type of the HTTPS security group rule"
  default     = "ingress"
}

variable "https_rule_ip_protocol" {
  type        = string
  description = "IP protocol for the HTTPS security group rule"
  default     = "tcp"
}

variable "https_rule_port_range" {
  type        = string
  description = "Port range for the HTTPS security group rule"
  default     = "443/443"
}

variable "https_rule_cidr_ip" {
  type        = string
  description = "CIDR IP for the HTTPS security group rule"
  default     = "0.0.0.0/0"
}

variable "http_rule_type" {
  type        = string
  description = "Type of the HTTP security group rule"
  default     = "ingress"
}

variable "http_rule_ip_protocol" {
  type        = string
  description = "IP protocol for the HTTP security group rule"
  default     = "tcp"
}

variable "http_rule_port_range" {
  type        = string
  description = "Port range for the HTTP security group rule"
  default     = "80/80"
}

variable "http_rule_cidr_ip" {
  type        = string
  description = "CIDR IP for the HTTP security group rule"
  default     = "0.0.0.0/0"
}

variable "sls_project_name" {
  type        = string
  description = "Name of the SLS project. Length must be 3-36 characters, starting and ending with lowercase letters or digits, containing only lowercase letters, digits, and hyphens"
  default     = "ack-hpa-sls-project"
}

variable "managed_kubernetes_cluster_name" {
  type        = string
  description = "Name of the ACK managed cluster"
  default     = "ack-hpa-cluster"
}

variable "cluster_spec" {
  type        = string
  description = "Specification of the Kubernetes cluster"
  default     = "ack.pro.small"
}

variable "service_cidr" {
  type        = string
  description = "CIDR block for the Kubernetes service network"
  default     = "172.16.0.0/16"
}

variable "new_nat_gateway" {
  type        = bool
  description = "Whether to create a new NAT gateway"
  default     = true
}

variable "slb_internet_enabled" {
  type        = bool
  description = "Whether to enable internet SLB for the cluster"
  default     = true
}

variable "cluster_addons" {
  type = list(object({
    name     = string
    config   = string
    version  = string
    disabled = bool
  }))
  description = "List of cluster addons to install"
  default = [
    {
      name     = "ack-node-local-dns"
      config   = ""
      version  = ""
      disabled = false
    },
    {
      name     = "terway-eniip"
      config   = "{\"IPVlan\":\"false\",\"NetworkPolicy\":\"false\",\"ENITrunking\":\"false\"}"
      version  = ""
      disabled = false
    },
    {
      name     = "csi-plugin"
      config   = ""
      version  = ""
      disabled = false
    },
    {
      name     = "csi-provisioner"
      config   = ""
      version  = ""
      disabled = false
    },
    {
      name     = "storage-operator"
      config   = "{\"CnfsOssEnable\":\"false\",\"CnfsNasEnable\":\"false\"}"
      version  = ""
      disabled = false
    },
    {
      name     = "nginx-ingress-controller"
      config   = ""
      version  = ""
      disabled = true
    },
    {
      name     = "logtail-ds"
      config   = "{\"IngressDashboardEnabled\":\"true\"}"
      version  = ""
      disabled = false
    },
    {
      name     = "alb-ingress-controller"
      config   = ""
      version  = ""
      disabled = false
    },
    {
      name     = "ack-helm-manager"
      config   = ""
      version  = ""
      disabled = false
    },
    {
      name     = "arms-prometheus"
      config   = ""
      version  = ""
      disabled = false
    }
  ]
}

variable "delete_options" {
  type = list(object({
    delete_mode   = string
    resource_type = string
  }))
  description = "List of delete options for cluster resources"
  default = [
    {
      delete_mode   = "delete"
      resource_type = "ALB"
    },
    {
      delete_mode   = "delete"
      resource_type = "SLB"
    },
    {
      delete_mode   = "delete"
      resource_type = "SLS_Data"
    },
    {
      delete_mode   = "delete"
      resource_type = "SLS_ControlPlane"
    },
    {
      delete_mode   = "delete"
      resource_type = "PrivateZone"
    }
  ]
}

variable "node_pool_name" {
  type        = string
  description = "Name of the node pool"
  default     = "ack-hpa-nodepool"
}

variable "instance_types" {
  type        = list(string)
  description = "List of ECS instance types for the node pool"
  default     = ["ecs.g7.large"]
}

variable "system_disk_category" {
  type        = string
  description = "Category of the system disk"
  default     = "cloud_essd"
}

variable "system_disk_size" {
  type        = number
  description = "Size of the system disk in GB"
  default     = 40
}

variable "runtime_name" {
  type        = string
  description = "Container runtime name"
  default     = "containerd"
}

variable "runtime_version" {
  type        = string
  description = "Container runtime version"
  default     = "1.6.28"
}

variable "scaling_config_enable" {
  type        = bool
  description = "Whether to enable auto scaling for the node pool"
  default     = true
}

variable "scaling_config_min_size" {
  type        = number
  description = "Minimum number of nodes in the node pool"
  default     = 2
}

variable "scaling_config_max_size" {
  type        = number
  description = "Maximum number of nodes in the node pool"
  default     = 10
}

variable "ros_stack_name" {
  type        = string
  description = "Name of the ROS stack for deploying Kubernetes resources"
}

variable "ros_template_url" {
  type        = string
  description = "URL of the ROS template for deploying Kubernetes resources"
  default     = "https://ros-public-templates.oss-cn-hangzhou.aliyuncs.com/ros-templates/documents/solution/micro/elastic-scaling-container-through-hpa-k8s-resource.tf.yaml"
}

variable "ros_parameters" {
  type = list(object({
    parameter_key   = string
    parameter_value = string
  }))
  description = "Parameters for the ROS stack"
  default     = []
}

variable "ros_disable_rollback" {
  type        = bool
  description = "Whether to disable rollback on ROS stack creation failure"
  default     = true
}

variable "ram_role_force" {
  type        = bool
  description = "Whether to force delete RAM roles"
  default     = true
}

variable "ram_policy_type" {
  type        = string
  description = "Type of the RAM policy"
  default     = "System"
}