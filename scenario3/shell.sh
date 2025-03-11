#!/bin/bash

if [ $# -gt 0 ]; then              # Checks if the number of arguments provided is greater than 0
    aws --version &>/dev/null      # Redirects the output of the command to /dev/null
    if [ $? -eq 0 ]; then          # Checks if the exit status of the last command is 0
        REGIONS="$@"               # Stores all the arguments provided
        for REGION in $REGIONS; do # Loops through each argument provided
            vpc=$(aws ec2 describe-vpcs --region ${REGION} | jq '.Vpcs[].VpcId' -r)
            echo -e "Vpc-Id of the $REGION is: \n$vpc"
            echo "--------------------------"
        done
    else
        echo "Incorrect AWS command. Please check your AWS CLI installation."
    fi
else
    echo "You have provided 0 arguments. Please provide at least one region."
fi
