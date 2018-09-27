resource "aws_iam_role_policy" "rds-policy" {
  name = "rds-policy-${var.namespace}-${terraform.workspace}"
  role = "${aws_iam_role.iam-role.id}"
  policy = <<EOF
{
  "Version": "2012-10-17",
  "Statement": [
      {
          "Action": [
              "rds:DescribeDBSnapshots",
              "rds:CreateDBSnapshot",
              "rds:DeleteDBSnapshot",
              "rds:DescribeDBClusterSnapshots",
              "rds:CreateDBClusterSnapshot",
              "rds:DeleteDBClusterSnapshot"
          ],
          "Resource": "*",
          "Effect": "Allow"
      }
  ]
}
EOF
}
