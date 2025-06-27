output "flow_log_id" {
  value = aws_flow_log.aws_flow_logs.id
}

output "log_group_arn" {
  value = aws_cloudwatch_log_group.aws_cloudwatch_log_group.arn
}