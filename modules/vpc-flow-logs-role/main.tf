# Generates an IAM policy document.
data "aws_iam_policy_document" "vpc_flow_logs_assume_role" {
  statement {
    actions = ["sts:AssumeRole"]

    principals {
      type        = "Service"
      identifiers = ["vpc-flow-logs.amazonaws.com"]
    }
  }
}

# Create the IAM role for VPC Flow Logs
resource "aws_iam_role" "vpc_flow_logs_role" {
  name               = "${var.project_name}-vpc-flow-logs-role"
  assume_role_policy = data.aws_iam_policy_document.vpc_flow_logs_assume_role.json
}

# Create a policy that allows writing to CloudWatch Logs
data "aws_iam_policy_document" "vpc_flow_logs_permissions" {
  statement {
    actions = [
      "logs:CreateLogGroup",
      "logs:CreateLogStream",
      "logs:PutLogEvents"
    ]
    resources = ["*"]
  }
}

# Create the policy
resource "aws_iam_policy" "vpc_flow_logs_policy" {
  name   = "${var.project_name}-vpc-flow-logs-policy"
  policy = data.aws_iam_policy_document.vpc_flow_logs_permissions.json
}

# Attach the policy to the role
resource "aws_iam_role_policy_attachment" "vpc_flow_logs_attachment" {
  role       = aws_iam_role.vpc_flow_logs_role.name
  policy_arn = aws_iam_policy.vpc_flow_logs_policy.arn
}
