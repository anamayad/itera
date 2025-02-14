output "castlemock_log_group" {
   description = "The name of the castlemock CloudWatch log group"
   value = aws_cloudwatch_log_group.castlemock_logs.name
}

output "castlemock_controller_log_stream" {
   description = "The name of the castlemock controller log stream"
   value = aws_cloudwatch_log_stream.castlemock_controller_log_stream.name
}