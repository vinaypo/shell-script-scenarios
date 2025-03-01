#!/bin/bash

###################
# Author: Vinay
# Version: 1
#
#
# To give the information about the Aws Resources usages
#
set -x
#
# list the s3-Buckets
echo "list the s3_buckets"
aws s3 ls
#
#
# list the ec2-Instances
echo "list the ec2 Instances"
aws ec2 describe-instances | jq '.Reservations[].Instances[].InstanceId'
#
#
# list the lambda functions
echo "list the lamda"
aws lambda list-functions
#
#
# list the Iam-Users
echo "list the Iam users"
aws iam list-users
