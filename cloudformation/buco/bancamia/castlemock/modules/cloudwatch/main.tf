resource "aws_cloudwatch_log_group" "castlemock_logs" {
   name = "/ecs/castlemock"

   tags = {
      Name = "${var.prefix}-logs"
   }
}

resource "aws_cloudwatch_log_stream" "castlemock_controller_log_stream" {
   name           = "castlemock-controller"
   log_group_name = aws_cloudwatch_log_group.castlemock_logs.name
}