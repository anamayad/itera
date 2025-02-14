//create vpc
resource "aws_vpc" "vpc" {
  cidr_block           = "10.33.4.0/22"
  enable_dns_support = true
  enable_dns_hostnames = true
  tags = {
    Name            = "vpc"

  }
}

//Create subnet for az d
resource "aws_subnet" "subnet_public_1" {
  availability_zone       = "us-east-1a"
  cidr_block              = "10.33.4.0/27"
  vpc_id                  = aws_vpc.vpc.id
  map_public_ip_on_launch = true
  tags = {
    Name            = "public"
    vpc-id          = aws_vpc.vpc.id
   type          = "public-develop"
  }
}

//Create subnet for az d
resource "aws_subnet" "subnet_public_2" {
  availability_zone       = "us-east-1b"
  cidr_block              = "10.33.5.0/27"
  vpc_id                  = aws_vpc.vpc.id
  map_public_ip_on_launch = true
  tags = {
    Name            = "public"
    vpc-id          = aws_vpc.vpc.id
   type          = "public-develop"
  }
}

//Create subnet for az d
resource "aws_subnet" "subnet_private_1" {
  availability_zone       = "us-east-1a"
  cidr_block              = "10.33.4.32/27"
  vpc_id                  = aws_vpc.vpc.id
  tags = {
 Name            = "private"
    vpc-id          = aws_vpc.vpc.id
   type          = "private-develop"
  
  }
}

//Create subnet for az d
resource "aws_subnet" "subnet_private_2" {
  availability_zone       = "us-east-1b"
  cidr_block              = "10.33.5.32/27"
  vpc_id                  = aws_vpc.vpc.id
  tags = {
 Name            = "private"
    vpc-id          = aws_vpc.vpc.id
   type          = "private-develop"
  
  }
}

//Create route table in az 1
resource "aws_route_table" "rtb_public" {
  vpc_id = aws_vpc.vpc.id
  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.igw.id
  }
  tags = {
    Name            = "rtb-public"
    private         = false
}
}

//Create route table in az 2
resource "aws_route_table" "rtb_private" {
  vpc_id = aws_vpc.vpc.id
  tags = {
    Name            = "rtb-private"
    private         = true
  }
}

//Create igw
resource "aws_internet_gateway" "igw" {
  vpc_id = aws_vpc.vpc.id
  tags = {
    Name = "igw"

  }
}


//Create eip in az 1
resource "aws_eip" "eip_1" {
  tags = {
    Name            = "iep-1"
  
  }
}


//Create nat az 1
resource "aws_nat_gateway" "nat" {
  allocation_id = aws_eip.eip_1.id
  subnet_id     = aws_subnet.subnet_public_1.id
  tags = {
    Name = "nat"
    zona = "us-east-1a"
  }
  depends_on = [aws_eip.eip_1]
}


//Create association route table with subnet private 1
resource "aws_route_table_association" "custom_rtb_public_subnet_1" {
  route_table_id = aws_route_table.rtb_public.id
  subnet_id      = aws_subnet.subnet_public_1.id
}

//Create association route table with subnet private 1
resource "aws_route_table_association" "custom_rtb_public_subnet_2" {
  route_table_id = aws_route_table.rtb_public.id
  subnet_id      = aws_subnet.subnet_public_2.id
}



//Create association route table with subnet private 1
resource "aws_route_table_association" "custom_rtb_subnet_private_1" {
  route_table_id = aws_route_table.rtb_private.id
  subnet_id      = aws_subnet.subnet_private_1.id
}
//Create association route table with subnet private 1
resource "aws_route_table_association" "custom_rtb_subnet_private_2" {
  route_table_id = aws_route_table.rtb_private.id
  subnet_id      = aws_subnet.subnet_private_2.id
}




//Create route igw to route table az d
resource "aws_route" "igw" {
  route_table_id         = aws_route_table.rtb_public.id
  destination_cidr_block = "0.0.0.0/0"
  gateway_id             = aws_internet_gateway.igw.id
}

//Create route subnet private 1 to route table private
resource "aws_route" "subnet_private_1" {
  route_table_id         = aws_route_table.rtb_private.id
  destination_cidr_block = "0.0.0.0/0"
  nat_gateway_id         = aws_nat_gateway.nat.id
}
