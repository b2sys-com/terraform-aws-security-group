output "security_group_arn" {
  description = "The ARN of the security group"
  value       = try(aws_security_group.this.arn, aws_security_group.this_name_prefix.arn, "")
}

output "security_group_id" {
  description = "The ID of the security group"
  value       = try(aws_security_group.this.id, aws_security_group.this_name_prefix.id, "")
}
