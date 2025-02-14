output "castlemockExecutionRole" {
   description = "ARN of the castlemock Execution Role"
   value = aws_iam_role.castlemockExecutionRole.arn
}