resource "aws_service_discovery_private_dns_namespace" "controller" {
	name        = "castlemockeci.dns"
	description = "castlemock Controller DNS namespace"
	vpc         = var.vpc_id
}

resource "aws_service_discovery_service" "controller" {
  name = "${var.prefix}"

  dns_config {
    namespace_id = aws_service_discovery_private_dns_namespace.controller.id

    dns_records {
      ttl  = 10
      type = "A"
    }

    routing_policy = "MULTIVALUE"
  }

  health_check_custom_config {
    failure_threshold = 1
  }
}