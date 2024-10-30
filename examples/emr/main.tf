locals {
  availability_zones = ["ap-singapore-2"]
  vpc_cidr = "10.0.0.0/16"
  subnet_cidrs = ["10.0.0.0/24"]
  name = "test-emr-tf"
  security_group_id = "sg-3fj6w1au"
  tags = {
    create: "terraform"
  }
}

module "network" {
  source  = "terraform-tencentcloud-modules/vpc/tencentcloud"
  version = "1.1.0"
  vpc_name         = local.name
  vpc_cidr         = "10.0.0.0/16"
  vpc_is_multicast = false
  tags             = local.tags

  availability_zones = local.availability_zones
  subnet_name        = local.name
  subnet_cidrs       = local.subnet_cidrs
  subnet_is_multicast = false
  subnet_tags        = local.tags
}

module "emr" {
  source = "../../modules/emr"

  create_cluster = true
  availability_zone = local.availability_zones[0]
  cluster_name = local.name
  tags = local.tags

  vpc_settings = {
    vpc_id = module.network.vpc_id
    subnet_id =  module.network.subnet_id[0]
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