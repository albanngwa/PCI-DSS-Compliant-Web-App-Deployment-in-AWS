# PCI-DSS-Compliant-Web-App-Deployment-in-AWS
Deploy a simple web application in AWS that follows PCI-DSS best practices
including:

Secure networking

Encrypted data storage

Identity and access controls

Logging and monitoring

Vulnerability scanning

Architecture Overview

VPC with private/public subnets

EC2 instance running a mock web app

RDS (MySQL) with encryption

ALB with TLS (HTTPS)

S3 bucket for logs (server access logging enabled)

CloudTrail, GuardDuty, AWS Config

KMS for encryption

IAM roles & least-privilege policies

AWS Inspector for vulnerability scanning


PCI-DSS Requirements Covered 
PCI Requirement	How This Project Addresses It
1. Network Security (Firewalls)	VPC + Security Groups + NACLs
3. Protect stored cardholder data	RDS + S3 encrypted with KMS
4. Encrypt transmission of data	HTTPS via ALB with TLS certificate
5. Anti-malware	AWS Inspector for EC2 + RDS
7. Restrict access by business need	IAM roles with least privilege
10. Log and monitor access	CloudTrail, Config, S3 logging
11. Regular security testing	AWS Inspector + CloudWatch Alarms
