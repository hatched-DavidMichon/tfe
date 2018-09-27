resource "aws_iam_role_policy" "ecs-policy" {
  name = "ecs-policy-${var.namespace}-${terraform.workspace}"
  role = "${aws_iam_role.iam-role.id}"
  policy = <<EOF
{
  "Version": "2012-10-17",
  "Statement": [
      {
          "Action": [
              "ecs:DescribeServices",
              "ecs:UpdateService",
              "ecs:RunTask",
              "ecs:DescribeTasks",
              "iam:PassRole"
          ],
          "Resource": "*",
          "Effect": "Allow"
      }
  ]
}
EOF
}
