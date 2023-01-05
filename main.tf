provider "aws" {
  region = "ap-south-1"
}

resource "aws_vpc" "my-vpc" {
  cidr_block = var.vpc_cidr_block
  tags = {
    Name : "${var.env_prefix}-vpc"
  }
}

module "subnet-modules" {
  source                 = "./modules/subnet"
  subnet_cidr_block      = var.subnet_cidr_block
  avail_zone             = var.avail_zone
  env_prefix             = var.env_prefix
  vpc_id                 = aws_vpc.my-vpc.id
  default_route_table_id = aws_vpc.my-vpc.default_route_table_id
}

module "webserver-modules" {
  source              = "./modules/webserver"
  vpc_id              = aws_vpc.my-vpc.id
  my_ip               = var.my_ip
  image_name          = var.image_name
  public_key_location = var.public_key_location
  instance_type       = var.instance_type
  subnet_id           = module.subnet-modules.subnet.id
  env_prefix          = var.env_prefix
  avail_zone          = var.avail_zone
}