data "aws_region" "current" {}

data "aws_vpc" "vpc_id_vantilisto" {
  id = "vpc-04017d66495b122b7"
}
data "aws_subnets" "private_subnets" {
  filter {
    name   = "tag:Name"
    values = ["private"]
  }
}

data "aws_subnets" "public_subnets" {
  filter {
    name   = "tag:Name"
    values = ["public"]
  }
}

data "aws_lb_target_group" "tg" {
  name = "${var.prefix}-tg"
}