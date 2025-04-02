#!/bin/bash
aws_regions=(us-east-1 us-east-2 us-west-1 us-west-2 eu-westro-1 eu-central-1 ap-southeast-1 ap-southeast-2 ap-northeast-1)

echo "Running the functions to list VPC's in all the regions"

for region in "${aws_regions[@]}"; do # Loops through each region
    echo "Listing VPC's in the region: $region"
    vpc_list=$(aws ec2 describe-vpcs --region $region 2>/dev/null | jq '.Vpcs[].VpcId' -r) # Lists all the VPC's in the region and stores the VPC-ID's in a variable
    vpc_array=(${vpc_list[@]})                                                             # Converts the list of VPC's into an array
    if [ ${#vpc_array[@]} -gt 0 ]; then                                                    # Checks if the number of VPC's in the region is greater than 0
        for vpc in "${vpc_list[@]}"; do                                                    # Loops through each VPC in the region
            echo "The VPC-ID of the $region is: $vpc"
        done
        echo "--------------------------"
    else
        echo "Invalid region"
        echo "## Breaking at the $region ##"
        echo "--------------------------"
        # break
        # continue
        # exit 404, 999
    fi
done
