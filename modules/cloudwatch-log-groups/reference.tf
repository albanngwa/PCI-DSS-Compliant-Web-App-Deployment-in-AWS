# # Create a CloudWatch Log Group for VPC Flow Logs
# resource "aws_cloudwatch_log_group" "aws_cloudwatch_log_group" {
#   name              = "${}-log-group-name"
#   retention_in_days = 
#   tags = {
#     Name = "${}-flow-logs"
#   }
# }

# # Enable VPC Flow Logs
# resource "aws_flow_log" "aws-flow-logs" {
#   log_destination      = 
#   log_destination_type = 
#   traffic_type         = 
#   vpc_id               = 
#   iam_role_arn         = 

#   tags = {
#     Name = "${}-vpc-flow-log"
# }
# }