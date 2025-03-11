# Passing Arguments, Special parameters.

### Passing arguments
It means providing a value to the arguments while executing the script. These arguments helps in customize the behaviour of the script without modifying the code.

* Passing Parameters: How to pass and utilize arguments in Bash scripts.

* Special Parameters: Utilizing `$?`, `$@`, `$*`, and `$#` to handle script behavior based on inputs and command execution status.

  * ```$?```- It's a variable that holds the return value of last executed command. If the last executed command is correct and successfull then it displays 0. If the command is invalid and causes error then it displays non-zero value.

  * ```"$*"```- With the double quotes means all the arguments will be treated as single string jointly.

  * ```"$@"```- With the double quotes means all the arguments will be treated seperately.

  * ```$#```- Helps in providing the number of arguments given while executing the script.



Example:
```
ubuntu@ip-172-31-83-93:~$ cat script.sh
#!/bin/bash
Name=$@
echo "Hello world,${Name}."
ubuntu@ip-172-31-83-93:~$ sudo chmod 700 script.sh
ubuntu@ip-172-31-83-93:~$ ./script.sh vinay
Hello world,vinay.
```

## Script Over View:
This script retrieves VPC IDs from a specified AWS region.
```bash
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
```
Giving the permission to execute the script and providing the arguments while executing the script
```
sudo chmod 700 shell.sh
./shell.sh us-east-1 us-east-2 ap-south-1
```
Outputs:
```
Vpc-Id of the us-east-1 is:
vpc-0ef72ca9a16d8ba13
vpc-0d56eff7083c81a3c
--------------------------
Vpc-Id of the us-east-2 is:
vpc-0665383d67b5c3104
--------------------------
Vpc-Id of the ap-south-1 is:
vpc-0c5610c0d96c2b33e
--------------------------
```
Error Handling:
Execute the script without provinding the arguments.

```./shell.sh```

Outputs:

Errors

If AWS CLI is not installed or incorrectly configured, the script will output:
```
Incorrect AWS command. Please check your AWS CLI installation.
```
If no regions are provided as arguments, the script will output:
```
You have provided 0 arguments. Please provide at least one region.
```


