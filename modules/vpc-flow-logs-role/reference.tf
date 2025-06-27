# # Generates an IAM policy document.
# data "aws_iam_policy_document" "vpc_flow_logs_assume_role" {
#   statement {
#     actions = ["sts:AssumeRole"]

#     principals {
#       type        = "Service"
#       identifiers = ["vpc-flow-logs.amazonaws.com"]
#     }
#   }
# }

# # Create the IAM role for VPC Flow Logs
# resource "aws_iam_role" "vpc_flow_logs_role" {
#   name               = "${}-vpc-flow-logs-role"
#   assume_role_policy = 
# }

# # Attach the managed policy that allows writing to CloudWatch Logs
# resource "aws_iam_role_policy_attachment" "vpc_flow_logs_attachment" {
#   role       = 
#   policy_arn = "arn:aws:iam::aws:policy/service-role/AmazonVPCFlowLogsRole"
# }
