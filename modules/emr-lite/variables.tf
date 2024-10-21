variable "create" {
  description = "Whether to create the resources in this module. If true, the resources will be created; otherwise, the resources will be skipped."
  type        = bool
  default     = true
}

variable "region" {
  description = "The region where the VPN gateway and other resources are located. Example: 'ap-jakarta'."
  type        = string
  default     = "ap-jakarta"
}

variable "instance_name" {
  description = " (Required, String) Instance name. Length limit is 6-36 characters. Only Chinese characters, letters, numbers, -, and _ are allowed."
  type        = string
  default = "default-emr-instance"
}

variable "pay_mode" {
  description = "(Required, Int) Instance pay mode. Value range: 0: indicates post pay mode, that is, pay-as-you-go."
  type        = number
  default     = 0
}

variable "disk_type" {
  description = "(Required, String) Instance disk type, fill in CLOUD_HSSD to indicate performance cloud storage."
  default     = "CLOUD_HSSD"
  type        = string
}

variable "disk_size" {
  description = " (Required, Int) Instance single-node disk capacity, in GB. The single-node disk capacity must be greater than or equal to 100 and less than or equal to 10000, with an adjustment step size of 20."
  type        = number
  default     = 100
}

variable "node_type" {
  description = "(Required, String) Instance node type, can be filled in as 4C16G, 8C32G, 16C64G, 32C128G, case insensitive."
  type        = string
  default     = "4C16G"
}


variable "zone_settings" {
  description = "(Required, List) Detailed configuration of the instance availability zone, currently supports multiple availability zones, the number of availability zones can only be 1 or 3, including zone name, VPC information, and number of nodes. The total number of nodes across all zones must be greater than or equal to 3 and less than or equal to 50."
  type = any
  default = []
}

variable "tags" {
  description = "tags to bind to the instance."
  type = list(object({
    tag_key   = string
    tag_value = string
  }))
  default = []
}
