data "aws_vpc" "vpc_id_castlemock" {
  id = "vpc-04017d66495b122b7"
}
data "aws_subnets" "private_subnets" {
  tags = {
    "Type" = "private-develop"
  }
}

data "aws_subnets" "public_subnets" {
  filter {
    name   = "tag:Name"
    values = ["public"]
  }
}
