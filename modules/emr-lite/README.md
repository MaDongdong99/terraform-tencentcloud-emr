# tencentcloud EMR Lite HBase



## usage

```terraform

locals {
  availability_zone = "ap-singapore-2"
  subnet_id = "subnet-6g5sypcb"
  vpc_id    = "vpc-mbxaeij4"
}

module "emr-lite" {
  source = "../../modules/emr-lite"

  create             = true
  instance_name      = "tf-test"
  pay_mode           = 0
  disk_type          = "CLOUD_HSSD"
  disk_size          = 100
  node_type          = "8C32G"
  zone_settings = [
    {
      node_num  = 3
      zone      = local.availability_zone
      vpc_settings = [ // support only one vpc
        {
          subnet_id = local.subnet_id
          vpc_id    = local.vpc_id
        }
      ]

    }
  ]
  tags = [
    { tag_key: "create", tag_value: "terraform" },
    { tag_key: "name", tag_value: "test-tf" }
  ]

}
```
## Requirements

| Name | Version |
|------|---------|
| <a name="requirement_terraform"></a> [terraform](#requirement\_terraform) | >= 1.5.0 |
| <a name="requirement_tencentcloud"></a> [tencentcloud](#requirement\_tencentcloud) | >= 1.81.130 |

## Providers

| Name | Version |
|------|---------|
| <a name="provider_tencentcloud"></a> [tencentcloud](#provider\_tencentcloud) | >= 1.81.130 |

## Modules

No modules.

## Resources

| Name | Type |
|------|------|
| [tencentcloud_lite_hbase_instance.lite_hbase_instance](https://registry.terraform.io/providers/tencentcloudstack/tencentcloud/latest/docs/resources/lite_hbase_instance) | resource |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_create"></a> [create](#input\_create) | Whether to create the resources in this module. If true, the resources will be created; otherwise, the resources will be skipped. | `bool` | `true` | no |
| <a name="input_disk_size"></a> [disk\_size](#input\_disk\_size) | (Required, Int) Instance single-node disk capacity, in GB. The single-node disk capacity must be greater than or equal to 100 and less than or equal to 10000, with an adjustment step size of 20. | `number` | `100` | no |
| <a name="input_disk_type"></a> [disk\_type](#input\_disk\_type) | (Required, String) Instance disk type, fill in CLOUD\_HSSD to indicate performance cloud storage. | `string` | `"CLOUD_HSSD"` | no |
| <a name="input_instance_name"></a> [instance\_name](#input\_instance\_name) | (Required, String) Instance name. Length limit is 6-36 characters. Only Chinese characters, letters, numbers, -, and \_ are allowed. | `string` | `"default-emr-instance"` | no |
| <a name="input_node_type"></a> [node\_type](#input\_node\_type) | (Required, String) Instance node type, can be filled in as 4C16G, 8C32G, 16C64G, 32C128G, case insensitive. | `string` | `"4C16G"` | no |
| <a name="input_pay_mode"></a> [pay\_mode](#input\_pay\_mode) | (Required, Int) Instance pay mode. Value range: 0: indicates post pay mode, that is, pay-as-you-go. | `number` | `0` | no |
| <a name="input_region"></a> [region](#input\_region) | The region where the VPN gateway and other resources are located. Example: 'ap-jakarta'. | `string` | `"ap-jakarta"` | no |
| <a name="input_tags"></a> [tags](#input\_tags) | tags to bind to the instance. | <pre>list(object({<br>    tag_key   = string<br>    tag_value = string<br>  }))</pre> | `[]` | no |
| <a name="input_zone_settings"></a> [zone\_settings](#input\_zone\_settings) | (Required, List) Detailed configuration of the instance availability zone, currently supports multiple availability zones, the number of availability zones can only be 1 or 3, including zone name, VPC information, and number of nodes. The total number of nodes across all zones must be greater than or equal to 3 and less than or equal to 50. | `any` | `[]` | no |

## Outputs

| Name | Description |
|------|-------------|
| <a name="output_disk_size"></a> [disk\_size](#output\_disk\_size) | n/a |
| <a name="output_disk_type"></a> [disk\_type](#output\_disk\_type) | n/a |
| <a name="output_instance_id"></a> [instance\_id](#output\_instance\_id) | n/a |
| <a name="output_instance_name"></a> [instance\_name](#output\_instance\_name) | n/a |
| <a name="output_node_type"></a> [node\_type](#output\_node\_type) | n/a |
