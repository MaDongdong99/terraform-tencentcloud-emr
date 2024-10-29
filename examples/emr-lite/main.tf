locals {
  region = "ap-jakarta"
  name = "test-emr-lite"
  availability_zones = ["ap-jakarta-2"]

  tags = { create: "terraform"}
}
provider "tencentcloud" {
  region = local.region
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
  subnet_cidrs       = ["10.0.0.0/24"]
  subnet_is_multicast = false
  subnet_tags        = local.tags
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
      zone      = local.availability_zones[0]
      vpc_settings = [ // support only one vpc
        {
          subnet_id = module.network.subnet_id[0]
          vpc_id    =  module.network.vpc_id
        }
      ]

    }
  ]
  tags = [
    { tag_key: "create", tag_value: "terraform" },
    { tag_key: "name", tag_value: "test-tf" }
  ]

}