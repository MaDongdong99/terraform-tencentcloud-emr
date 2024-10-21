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