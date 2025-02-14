resource "aws_ecs_cluster" "controller" {
   name = "${var.prefix}-controller"
}



resource "aws_ecs_cluster_capacity_providers" "controller" {
   cluster_name = aws_ecs_cluster.controller.name
   capacity_providers = ["FARGATE"]

   default_capacity_provider_strategy {
      base              = 1
      weight            = 100
      capacity_provider = "FARGATE"
   }
}


resource "aws_ecs_task_definition" "castlemock_td" {
   family                  = "${var.prefix}"
   container_definitions   = templatefile(
      "${path.module}/task-definitions/castlemock.tftpl", {
         name                    = "${var.prefix}",
        image                    = "castlemock/castlemock"
         cpu                     = var.castlemock_controller_cpu,
         memory                  = var.castlemock_controller_mem,
         efsVolumeName           = "${var.prefix}-efs",
         efsVolumeId             = var.castlemock_efs,
         transmitEncryption      = true,
         containerPath           = "/root/.castlemock",
         region                  = data.aws_region.current.name
         log_group               = var.castlemock_log_group
         log_stream              = var.castlemock_log_stream
         castlemock_controller_port = var.castlemock_controller_port
      }
   )
   requires_compatibilities   = ["FARGATE"]
   network_mode               = "awsvpc"
   cpu                        = var.castlemock_controller_cpu
   memory                     = var.castlemock_controller_mem
   execution_role_arn         = var.execution_role_arn
   task_role_arn              = var.execution_role_arn

   volume {
      name = "${var.prefix}-efs"

      efs_volume_configuration {
         file_system_id       = var.castlemock_efs
         root_directory       = "/root/.castlemock"
         transit_encryption   = "ENABLED"

         authorization_config {
            access_point_id = var.castlemock_efs_ap
            iam = "ENABLED"
         }
      }
   }
}

resource "aws_ecs_service" "castlemock" {
   name              = "castlemock"
   cluster           = aws_ecs_cluster.controller.id
   task_definition   = aws_ecs_task_definition.castlemock_td.arn
   launch_type       = "FARGATE"

   desired_count                       = 1
   enable_execute_command = true
   deployment_minimum_healthy_percent  = 0
   deployment_maximum_percent          = 100
   
   network_configuration {
      subnets           = data.aws_subnets.private_subnets.ids
      security_groups   = [var.castlemock_controller_sg]
   }

   service_registries {
      registry_arn = var.castlemock_controller_dns_arn
   }
   
   load_balancer {
     target_group_arn   = data.aws_lb_target_group.tg.arn
     container_name     = "${var.prefix}"
     container_port     = var.castlemock_controller_port
   }
}