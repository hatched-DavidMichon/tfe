resource "aws_iam_role_policy" "ecr-policy" {
  name = "ecr-policy-${var.namespace}-${terraform.workspace}"
  role = "${aws_iam_role.iam-role.id}"
  policy = <<EOF
{
  "Version": "2012-10-17",
  "Statement": [
      {
          "Action": [
              "ecr:GetDownloadUrlForLayer",
              "ecr:BatchGetImage",
              "ecr:DescribeImages",
              "ecr:GetAuthorizationToken",
              "ecr:DescribeRepositories",
              "ecr:UploadLayerPart",
              "ecr:ListImages",
              "ecr:InitiateLayerUpload",
              "ecr:BatchCheckLayerAvailability",
              "ecr:GetRepositoryPolicy",
              "ecr:PutImage",
              "ecr:CompleteLayerUpload"
          ],
          "Resource": "*",
          "Effect": "Allow"
      }
  ]
}
EOF
}
