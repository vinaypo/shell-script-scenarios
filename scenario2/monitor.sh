#!/bin/bash
#
#
#
#
# Version: 1 
#
# This script will report the AWS resource usage
###############################
#
# AWS S3
# AWS Ec2-Instances
# AWS Lambda functions
# AWS IAM-Users
#
#


set -x
echo "--------------------------------------------"
#Listing the aws s3 buckets
echo "Print list of S3 Buckets"
aws s3 ls
echo "--------------------------------------------"
#list the Ec2 Instances
echo "Print the Ec2-Instances"
aws ec2 describe-instances | jq '.Reservations[].Instances[].InstanceId'
echo "--------------------------------------------"
#list the Lambda functions
echo "Print the Lambda functions"
aws lambda list-functions | jq '.Functions[].FunctionName'

echo "--------------------------------------------"
#list the IAM-Users
echo "Print the IAM-Users"
aws iam list-users | jq '.Users[].UserName'
echo "---------------------------------------------"
