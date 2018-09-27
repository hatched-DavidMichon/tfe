// Settings
variable "namespace" {
  description = "Project namespace"
}

// Outputs
output "profile-name" { value = "${aws_iam_instance_profile.iam-instance-profile.name}" }
output "role-id" { value = "${aws_iam_role.iam-role.id}" }
output "role-arn" { value = "${aws_iam_role.iam-role.arn}" }
