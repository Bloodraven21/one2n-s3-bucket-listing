output "ecs_cluster_id" {
  value = aws_ecs_cluster.one2ntask.id
}

output "ecs_cluster_name" {
  value = aws_ecs_cluster.one2ntask.name
}

output "one2ntask_security_group" {
  value = aws_security_group.one2ntask_security_group.id
}

# modules/ecs/outputs.tf

output "ecs_execution_role_arn" {
  description = "The ARN of the ECS execution role."
  value       = aws_iam_role.ecs_execution_role.arn  # Reference the actual resource instead of a variable
}

output "ecs_task_role_arn" {
  description = "The ARN of the ECS task role."
  value       = aws_iam_role.ecs_task_role.arn        # Reference the actual resource instead of a variable
}

# Uncomment if you have public subnets defined elsewhere
output "public_subnet_id" {
  value = var.public_subnet_id  // Ensure this variable is passed from the parent module
}
# output "public_b" {
#   value = aws_subnet.public_b
# }