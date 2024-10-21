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
