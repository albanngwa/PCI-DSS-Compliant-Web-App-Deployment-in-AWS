# Create a CloudWatch Log Group for VPC Flow Logs
resource "aws_cloudwatch_log_group" "aws_cloudwatch_log_group" {
  name              = "${var.project_name}-log-group-name"
  retention_in_days = var.retention_in_days
  tags = {
    Name = "${var.project_name}-flow-logs"
  }
}

# Enable VPC Flow Logs
resource "aws_flow_log" "aws_flow_logs" {
  log_destination      = aws_cloudwatch_log_group.aws_cloudwatch_log_group.arn
  log_destination_type = "cloud-watch-logs"
  traffic_type         = "ALL"
  vpc_id               = var.vpc_id
  iam_role_arn         = var.vpc_flow_logs_role_arn

  tags = {
    Name = "${var.project_name}-vpc-flow-log"
}
}