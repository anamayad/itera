
module "security_groups_castlemock" {
   source = "./modules/security_groups"
   prefix = var.prefix
   vpc_id = data.aws_vpc.vpc_id_castlemock.id
   castlemock_controller_port = var.castlemock_controller_port
}

module "efs_castlemock" {
   source            = "./modules/efs"
   prefix            = var.prefix
   efs_sg            = module.security_groups_castlemock.castlemock_efs
   subnet_id_efs_castlemock = var.subnet_id_efs_castlemock

}

module "elb_castlemock" {
   source         = "./modules/elb"
   prefix         = var.prefix
   castlemock_alb_sg = module.security_groups_castlemock.castlemock_alb
   vpc_id         = data.aws_vpc.vpc_id_castlemock.id
   public_subnets = data.aws_subnets.public_subnets
}

module "ecs_castlemock" {
   source                     = "./modules/ecs"
   prefix                     = var.prefix
   castlemock_controller_cpu     = var.castlemock_controller_cpu
   castlemock_controller_mem     = var.castlemock_controller_mem
   castlemock_controller_port    = var.castlemock_controller_port
   castlemock_efs                = module.efs_castlemock.efs
   castlemock_efs_ap             = module.efs_castlemock.efs_ap
   castlemock_alb_tg             = module.elb_castlemock.alb_tg_arn
   castlemock_controller_sg      = module.security_groups_castlemock.castlemock_controller
   castlemock_log_group          = module.cloudwatch_castlemock.castlemock_log_group
   castlemock_log_stream         = module.cloudwatch_castlemock.castlemock_controller_log_stream
   castlemock_controller_dns_arn = module.cloud_map_castlemock.castlemock_controller_dns_arn
   private_subnets            = data.aws_subnets.private_subnets.ids
   execution_role_arn         = module.iam_castlemock.castlemockExecutionRole
}

module "cloudwatch_castlemock" {
   source = "./modules/cloudWatch"
   prefix = var.prefix
}

module "iam_castlemock" {
   source = "./modules/iam"
}

module "cloud_map_castlemock" {
   source   = "./modules/cloudMap"
   vpc_id   = data.aws_vpc.vpc_id_castlemock.id
   prefix   = var.prefix
}