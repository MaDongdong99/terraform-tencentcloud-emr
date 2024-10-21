variable "create_cluster" {
  default = true
  type = bool
}
variable "cluster_id" {
  default = ""
  type = string
}

variable "vpc_settings" {
  type = map(string)
  description = "The private net config of EMR instance."
}
variable "product_id" {
  default = 38
  type = number
  description = <<EOF
16: represents EMR-V2.3.0
20: indicates EMR-V2.5.0
25: represents EMR-V3.1.0
27: represents KAFKA-V1.0.0
30: indicates EMR-V2.6.0
33: represents EMR-V3.2.1
34: stands for EMR-V3.3.0
36: represents STARROCKS-V1.0.0
37: indicates EMR-V3.4.0
38: represents EMR-V2.7.0
39: stands for STARROCKS-V1.1.0
41: represents DRUID-V1.1.0.
EOF
}
variable "softwares" {
  default = [
    "hdfs-2.8.5",
    "knox-1.6.1",
    "openldap-2.4.44",
    "yarn-2.8.5",
    "zookeeper-3.6.3",
  ]
  type = list(string)
  description = "The softwares of a EMR instance."
}
variable "support_ha" {
  default = 0
  type = number
  description = "The flag whether the instance support high availability.(0=>not support, 1=>support)."
}
variable "cluster_name" {
  type = string
  default = ""
  description = "cluster name"
}
variable "resource_spec" {
  type = any
  description = "Resource specification of EMR instance."
}
variable "login_settings" {
  type = map(string)
  description = "Instance login settings. There are two optional fields:- password: Instance login password: 8-16 characters, including uppercase letters, lowercase letters, numbers and special characters. Special symbols only support! @% ^ *. The first bit of the password cannot be a special character;- public_key_id: Public key id. After the key is associated, the instance can be accessed through the corresponding private key."
}
variable "time_span" {
  type = number
  default = 1
  description = "The length of time the instance was purchased. Use with TimeUnit.When TimeUnit is s, the parameter can only be filled in at 3600, representing a metered instance. When TimeUnit is m, the number filled in by this parameter indicates the length of purchase of the monthly instance of the package year, such as 1 for one month of purchase."
}

variable "pay_mode" {
  default = 0
  type = number
  description = "The pay mode of instance. 0 represent POSTPAID_BY_HOUR, 1 represent PREPAID."
}
variable "availability_zone" {
  type = string
  description = " zone "
}
variable "project_id" {
  default = 0
  type = number
}
variable "security_group_id" {
  default = null
  type = string
  description = " The ID of the security group to which the instance belongs,"
}

variable "tags" {
  type = map(string)
  default = {}
  description = "tags "
}

# users

variable "users" {
  default = {}
  type = any
  description = "see `tencentcloud_emr_user_manager`"
}