# tencentcloud EMR


## usage

```terraform

locals {
  availability_zone = "ap-singapore-2"
  vpc_id = "vpc-j0sqtqk7"
  subnet_id = "subnet-p6xvdq6i"
  security_group_id = "sg-3fj6w1au"
}

module "emr" {
  source = "../../modules/emr"

  create_cluster = true
  availability_zone = local.availability_zone
  cluster_name = "test-emr-tf"
  tags = {
    "create": "terraform",
    "env": "dev"
  }

  vpc_settings = {
    vpc_id = local.vpc_id
    subnet_id = local.subnet_id
  }

  login_settings = {
    password = "P@ssw0rd!"
  }

  resource_spec = {
    master_resource_spec = {
      mem_size     = 16384
      cpu          = 8
      disk_size    = 100
      disk_type    = "CLOUD_PREMIUM"
      spec         = "CVM.SA2"
      storage_type = 5
      root_size    = 50
    }
    core_resource_spec = {
      mem_size     = 8192
      cpu          = 4
      disk_size    = 100
      disk_type    = "CLOUD_PREMIUM"
      spec         = "CVM.SA2"
      storage_type = 5
      root_size    = 50
    }
    master_count = 1
    core_count   = 2
  }

  pay_mode = 0
  time_span = 3600

  security_group_id = local.security_group_id


  users = {
    group1_user1 = {
      user_name   = "user1"
      user_group  = "group1"
      password    = "P@ssw0rd!"
    },
    group1_user2 = {
      user_name   = "user2"
      user_group  = "group1"
      password    = "P@ssw0rd!"
    },
    group3_user3 = {
      user_name   = "user3"
      user_group  = "group3"
      password    = "P@ssw0rd!"
    }
  }
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
| [tencentcloud_emr_cluster.emr_cluster](https://registry.terraform.io/providers/tencentcloudstack/tencentcloud/latest/docs/resources/emr_cluster) | resource |
| [tencentcloud_emr_user_manager.user_manager](https://registry.terraform.io/providers/tencentcloudstack/tencentcloud/latest/docs/resources/emr_user_manager) | resource |
| [tencentcloud_emr.this](https://registry.terraform.io/providers/tencentcloudstack/tencentcloud/latest/docs/data-sources/emr) | data source |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_availability_zone"></a> [availability\_zone](#input\_availability\_zone) | zone | `string` | n/a | yes |
| <a name="input_cluster_id"></a> [cluster\_id](#input\_cluster\_id) | n/a | `string` | `""` | no |
| <a name="input_cluster_name"></a> [cluster\_name](#input\_cluster\_name) | cluster name | `string` | `""` | no |
| <a name="input_create_cluster"></a> [create\_cluster](#input\_create\_cluster) | n/a | `bool` | `true` | no |
| <a name="input_login_settings"></a> [login\_settings](#input\_login\_settings) | Instance login settings. There are two optional fields:- password: Instance login password: 8-16 characters, including uppercase letters, lowercase letters, numbers and special characters. Special symbols only support! @% ^ *. The first bit of the password cannot be a special character;- public\_key\_id: Public key id. After the key is associated, the instance can be accessed through the corresponding private key. | `map(string)` | n/a | yes |
| <a name="input_pay_mode"></a> [pay\_mode](#input\_pay\_mode) | The pay mode of instance. 0 represent POSTPAID\_BY\_HOUR, 1 represent PREPAID. | `number` | `0` | no |
| <a name="input_product_id"></a> [product\_id](#input\_product\_id) | 16: represents EMR-V2.3.0<br>20: indicates EMR-V2.5.0<br>25: represents EMR-V3.1.0<br>27: represents KAFKA-V1.0.0<br>30: indicates EMR-V2.6.0<br>33: represents EMR-V3.2.1<br>34: stands for EMR-V3.3.0<br>36: represents STARROCKS-V1.0.0<br>37: indicates EMR-V3.4.0<br>38: represents EMR-V2.7.0<br>39: stands for STARROCKS-V1.1.0<br>41: represents DRUID-V1.1.0. | `number` | `38` | no |
| <a name="input_project_id"></a> [project\_id](#input\_project\_id) | n/a | `number` | `0` | no |
| <a name="input_resource_spec"></a> [resource\_spec](#input\_resource\_spec) | Resource specification of EMR instance. | `any` | n/a | yes |
| <a name="input_security_group_id"></a> [security\_group\_id](#input\_security\_group\_id) | The ID of the security group to which the instance belongs, | `string` | `null` | no |
| <a name="input_softwares"></a> [softwares](#input\_softwares) | The softwares of a EMR instance. | `list(string)` | <pre>[<br>  "hdfs-2.8.5",<br>  "knox-1.6.1",<br>  "openldap-2.4.44",<br>  "yarn-2.8.5",<br>  "zookeeper-3.6.3"<br>]</pre> | no |
| <a name="input_support_ha"></a> [support\_ha](#input\_support\_ha) | The flag whether the instance support high availability.(0=>not support, 1=>support). | `number` | `0` | no |
| <a name="input_tags"></a> [tags](#input\_tags) | tags | `map(string)` | `{}` | no |
| <a name="input_time_span"></a> [time\_span](#input\_time\_span) | The length of time the instance was purchased. Use with TimeUnit.When TimeUnit is s, the parameter can only be filled in at 3600, representing a metered instance. When TimeUnit is m, the number filled in by this parameter indicates the length of purchase of the monthly instance of the package year, such as 1 for one month of purchase. | `number` | `1` | no |
| <a name="input_users"></a> [users](#input\_users) | see `tencentcloud_emr_user_manager` | `any` | `{}` | no |
| <a name="input_vpc_settings"></a> [vpc\_settings](#input\_vpc\_settings) | The private net config of EMR instance. | `map(string)` | n/a | yes |

## Outputs

| Name | Description |
|------|-------------|
| <a name="output_cluster_id"></a> [cluster\_id](#output\_cluster\_id) | n/a |
| <a name="output_cluster_name"></a> [cluster\_name](#output\_cluster\_name) | n/a |
