resource "aws_iam_role" "iam-role" {
  name = "iam-role-${var.namespace}-${terraform.workspace}"

  assume_role_policy = <<EOF
{
  "Version": "2012-10-17",
  "Statement": [
    {
      "Action": "sts:AssumeRole",
      "Principal": {
        "Service": [
          "ec2.amazonaws.com"
        ]
      },
      "Effect": "Allow",
      "Sid": ""
    }
  ]
}
EOF
}

resource "aws_iam_instance_profile" "iam-instance-profile" {
  name = "iam-instance-profile-${var.namespace}-${terraform.workspace}"
  role = "${aws_iam_role.iam-role.name}"
}
