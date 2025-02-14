
resource "aws_iam_policy" "castlemock_policy" {
   name     = "castlemockPolicy"
   policy   = jsonencode({
      "Version": "2012-10-17",
      "Statement": [
         {
            "Sid": "",
            "Effect": "Allow",
            "Action": [
              "ecs:ListClusters",
                "ecs:ListTaskDefinitions",
                "ecs:ListContainerInstances",
                "ecs:RunTask",
                "ecs:ListTasks",
                "ecs:StopTask",
                "ecs:DescribeTasks",
                "ecs:DescribeContainerInstances",
                "ecs:DescribeTaskDefinition",
                "ecs:RegisterTaskDefinition",
                "ecs:DeregisterTaskDefinition",
                "iam:GetRole",
                "iam:PassRole",
                "ec2:DescribeInstances",
                "ec2:CreateNetworkInterface",
                "ec2:DescribeNetworkInterfaces",
                "ec2:DeleteNetworkInterface",
                "ec2:DetachNetworkInterface",
                "ec2:AttachNetworkInterface",
                "ecs:CreateCluster",
                "ecs:DeleteCluster",
                "ecs:CreateService",
                "ecs:UpdateService",
                "ecs:DeleteService",
                "ecs:ListServices"
            ],
            "Resource": "*"
         }
      ]
   })
}

resource "aws_iam_role" "castlemockExecutionRole" {
   name                 = "castlemockExecutionRole"
   assume_role_policy   = jsonencode({
      "Version": "2012-10-17",
      "Statement": [
         {
            "Sid": "",
            "Effect": "Allow",
            "Principal": {
               "Service": "ecs-tasks.amazonaws.com",
               "AWS": [
                    "arn:aws:iam::130680585869:role/Assume-Rol-DevSecOps"
                ]
            },
            "Action": "sts:AssumeRole"
         }
      ]
   })

   managed_policy_arns = [
      data.aws_iam_policy.aws_ecs_task_execution_policy.arn, 
      aws_iam_policy.castlemock_policy.arn
   ]
}