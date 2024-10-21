
locals {
  cluster_id = var.create_cluster ? concat(tencentcloud_emr_cluster.emr_cluster.*.instance_id, [""])[0] : var.cluster_id
  cluster_name = data.tencentcloud_emr.this.clusters[0].cluster_name
}

resource "tencentcloud_emr_cluster" "emr_cluster" {
  count = var.create_cluster ? 1 : 0
  product_id = var.product_id # 38
  vpc_settings = var.vpc_settings
  softwares = var.softwares
#  [
#    "hdfs-2.8.5",
#    "knox-1.6.1",
#    "openldap-2.4.44",
#    "yarn-2.8.5",
#    "zookeeper-3.6.3",
#  ]
  support_ha    = var.support_ha # 0
  instance_name = var.cluster_name # "emr-cluster-test"
  resource_spec {
    master_resource_spec {
      mem_size     = var.resource_spec.master_resource_spec.mem_size # 8192
      cpu          = var.resource_spec.master_resource_spec.cpu # 4
      disk_size    = var.resource_spec.master_resource_spec.disk_size # 100
      disk_type    = var.resource_spec.master_resource_spec.disk_type # "CLOUD_PREMIUM"
      spec         = var.resource_spec.master_resource_spec.spec # "CVM.${data.tencentcloud_instance_types.cvm4c8m.instance_types.0.family}"
      storage_type = var.resource_spec.master_resource_spec.storage_type # 5
      root_size    = var.resource_spec.master_resource_spec.root_size # 50
    }
    core_resource_spec {
      mem_size     = var.resource_spec.core_resource_spec.mem_size # 8192
      cpu          = var.resource_spec.core_resource_spec.cpu # 4
      disk_size    = var.resource_spec.core_resource_spec.disk_size # 100
      disk_type    = var.resource_spec.core_resource_spec.disk_type # "CLOUD_PREMIUM"
      spec         = var.resource_spec.core_resource_spec.spec # "CVM.${data.tencentcloud_instance_types.cvm4c8m.instance_types.0.family}"
      storage_type = var.resource_spec.core_resource_spec.storage_type # 5
      root_size    = var.resource_spec.core_resource_spec.root_size # 50
    }
    master_count = var.resource_spec.master_count # 1
    core_count   = var.resource_spec.core_count # 2
  }
  login_settings = var.login_settings
  time_span = var.time_span # 3600
  time_unit = var.pay_mode == 0 ? "s" : "m" # "s" The unit of time in which the instance was purchased. When PayMode is 0, TimeUnit can only take values of s(second). When PayMode is 1, TimeUnit can only take the value m(month).
  pay_mode  = var.pay_mode # 0

  placement_info {
    zone       = var.availability_zone
    project_id = var.project_id
  }
  sg_id = var.security_group_id

  tags = var.tags
}

data "tencentcloud_emr" "this" {
  display_strategy = "clusterList"
  instance_ids     = [local.cluster_id]
}


resource "tencentcloud_emr_user_manager" "user_manager" {
  for_each = var.users
  instance_id = local.cluster_id
  user_name   = each.value.user_name
  user_group  = each.value.user_group
  password    = each.value.password
}