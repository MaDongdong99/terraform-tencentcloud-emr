output "instance_name" {
  value = local.name
}

output "instance_id" {
  value = local.instance_id
}

output "node_type" {
  value = join("", tencentcloud_lite_hbase_instance.lite_hbase_instance.*.node_type)
}

output "disk_type" {
  value = join("", tencentcloud_lite_hbase_instance.lite_hbase_instance.*.disk_type)
}

output "disk_size" {
  value = join("", tencentcloud_lite_hbase_instance.lite_hbase_instance.*.disk_size)
}
