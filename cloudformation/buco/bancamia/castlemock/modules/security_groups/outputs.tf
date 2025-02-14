output "castlemock_controller" {
   description = "ID of the castlemock Controller SG"
   value = aws_security_group.castlemock_controller.id
}



output "castlemock_efs" {
   description = "ID of the castlemock EFS SG"
   value = aws_security_group.castlemock_efs.id
}

output "castlemock_alb" {
   description = "ID of the castlemock ALB SG"
   value = aws_security_group.castlemock_alb.id
}

output "vpc_endpoints" {
   description = "ID of the VPC Endpoints SG"
   value = aws_security_group.vpc_endpoints.id
}