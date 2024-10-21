locals {
  // TODO: naming convention
  name = var.instance_name
  instance_id = join("", tencentcloud_lite_hbase_instance.lite_hbase_instance.*.id)
}

resource "tencentcloud_lite_hbase_instance" "lite_hbase_instance" {
  count = var.create ? 1 : 0
  instance_name = local.name
  pay_mode      = var.pay_mode
  disk_type     = var.disk_type
  disk_size     = var.disk_size
  node_type     = var.node_type

  dynamic "zone_settings" {
    for_each = var.zone_settings
    content {
      zone = zone_settings.value.zone
      dynamic "vpc_settings" {
        for_each = try(zone_settings.value.vpc_settings, [])
        content {
          subnet_id = vpc_settings.value.subnet_id
          vpc_id    = vpc_settings.value.vpc_id
        }
      }
      node_num = zone_settings.value.node_num
    }
  }

  dynamic "tags" {
    for_each = var.tags
    content {
      tag_key   = tags.value.tag_key
      tag_value = tags.value.tag_value
    }
  }
}

