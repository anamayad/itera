output "castlemock_controller_dns_arn" {
   description = "The castlemock Controller DNS ARN"
   value = aws_service_discovery_service.controller.arn
}

output "castlemock_controller_dns_endpoint" {
   description = "The castlemock Controller DNS endpoint"
   value = "${aws_service_discovery_service.controller.name}.${aws_service_discovery_private_dns_namespace.controller.name}"
}