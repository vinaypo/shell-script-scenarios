#--------------------------

#!/bin/bash
if [ $# -gt 0 ]; then      # Checks if the number of arguments provided is greater than 0
    USERS=$@               # Stores all the arguments provided
    for USER in $USERS; do # Loops through each argument provided
        # if [[ $USER =~ ^[a-zA-Z]+$ ]]; then                                                # Checks if the argument provided is a valid username
        if [[ $USER =~ ^[a-z][a-z][a-z][a-z][0-9][0-9]+$ ]]; then
            EXISTING_USERS=$(cat /etc/passwd | grep -i -w $USER | awk -F ":" '{print $1}') # Stores the existing users in the machine & checks if the user provided is already present in the machine
            if [ "${USER}" == "${EXISTING_USERS}" ]; then                                  # Checks if the user provided is already present in the machine
                echo "The $USER you have entered is already exists in the machine, Please enter a new user"
            else
                echo "$USER is not present in the machine, Let's create a new user"
                sudo useradd $USER -m -s /bin/bash                                    # Creates a new user with the provided username and shell
                SPEC=$(echo '!@#$%^&*()_' | fold -w1 | shuf | head -1)                # Generates a random special character
                ALPA=$(echo 'abcdefghijklmnopqrstuvwxyz' | fold -w4 | shuf | head -1) # Generates a random alphabet
                PASSWORD=${ALPA}${RANDOM}${SPEC}                                      # Generates a random password
                echo "$USER:$PASSWORD" | sudo chpasswd                                # sets the password for the user created above and user has to change the password
                sleep 5                                                               # Waits for 5 seconds
                echo "User $USER has been created successfully"
                sleep 2 # Waits for 2 seconds
                echo "The temporary password for the user $USER is $PASSWORD"
                sudo passwd -e $USER # Expiring the password for the user
            fi
        else
            echo "Please enter a valid username"
        fi
    done
else
    echo "Please give the required arguments"
fi

# to remove password authentication
# sudo sed -i 's/PasswordAuthentication yes/PasswordAuthentication yes/g' /etc/ssh/sshd_config

------------------------
