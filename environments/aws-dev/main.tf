module "aws_vpc" {
  source   = "../../modules/aws-vpc"
  vpc_cidr = var.vpc_cidr
  vpc_name = var.vpc_name
}