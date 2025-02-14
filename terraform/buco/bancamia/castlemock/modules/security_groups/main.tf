
resource "aws_security_group" "castlemock_alb" {
   name        = "castlemock-alb"
   description = "Security group for the ALB that points to the castlemock master"
   vpc_id      = data.aws_vpc.vpc_id_castlemock.id

   ingress {
      description = "Allow all traffic through port 80"
      from_port   = "80"
      to_port     = "80"
      protocol    = "tcp"
      cidr_blocks = ["0.0.0.0/0"]
   }

   egress {
      description = "Allow all outbound traffic"
      from_port   = "0"
      to_port     = "0"
      protocol    = "-1"
      cidr_blocks = ["0.0.0.0/0"]
   }

   tags = {
      Name = "${var.prefix}-castlemock-alb"
   }
}


resource "aws_security_group" "castlemock_controller" {
   name        = "castlemock-controller"
   description = "Security group for the castlemock master"
   vpc_id      = data.aws_vpc.vpc_id_castlemock.id

   ingress {
      description       = "Allow traffic from the ALB"
      from_port         = "${var.castlemock_controller_port}"
      to_port           = "${var.castlemock_controller_port}"
      protocol          = "tcp"
      security_groups   = [aws_security_group.castlemock_alb.id]
   }

 



   ingress {
      description       = "Allow traffic from VPC endpoints"
      from_port         = "443"
      to_port           = "443"
      protocol          = "tcp"
      security_groups   = [aws_security_group.vpc_endpoints.id]
   }

   
     ingress {
      description = "Allow all traffic through port 8080"
      from_port   = "8080"
      to_port     = "8080"
      protocol    = "tcp"
      cidr_blocks = ["0.0.0.0/0"]
   }
   

   egress {
      description = "Allow all outbound traffic"
      from_port   = "0"
      to_port     = "0"
      protocol    = "-1"
      cidr_blocks = ["0.0.0.0/0"]
   }

   tags = {
      Name = "${var.prefix}-castlemock-controller"
   }
}

resource "aws_security_group" "castlemock_efs" {
   name        = "castlemock-efs"
   description = "Security group for the EFS of the castlemock controller"
   vpc_id      = data.aws_vpc.vpc_id_castlemock.id

   ingress {
      description       = "Allow traffic from the castlemock controller"
      from_port         = "2049"
      to_port           = "2049"
      protocol          = "tcp"
      security_groups   = [aws_security_group.castlemock_controller.id]
   }

   egress {
      description = "Allow all outbound traffic"
      from_port   = "0"
      to_port     = "0"
      protocol    = "-1"
      cidr_blocks = ["0.0.0.0/0"]
   }

   tags = {
      Name = "${var.prefix}-castlemock-efs"
   }
}

resource "aws_security_group" "vpc_endpoints" {
   name        = "vpc-endpoints-castlemock"
   description = "SG for VPC Endpoints"
   vpc_id      = data.aws_vpc.vpc_id_castlemock.id

   ingress {
      description = "Allow HTTPS traffic"
      from_port   = "443"
      to_port     = "443"
      protocol    = "tcp"
      cidr_blocks = ["0.0.0.0/0"]
   }

   egress {
      description = "Allow all outbound traffic"
      from_port   = "0"
      to_port     = "0"
      protocol    = "-1"
      cidr_blocks = ["0.0.0.0/0"]
   }

   tags = {
      Name = "${var.prefix}-vpc-endpoints"
   }
}
