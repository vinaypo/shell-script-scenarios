This script automates the process of creating new users on a Linux system. It checks if a user already exists, creates a new user if they don't, generates a random password with a special character, and forces the user to reset their password on the first login.

## Features:
1. Checks if the provided username already exists in the system.
2. If the user doesn’t exist, it creates the user with a randomly generated password.
3. The password includes a special character and a random number.
4. The user is forced to reset their password during their first login.
5. Supports creating multiple users in one execution.
6. Includes automated SSH configuration changes to enable password authentication.

## Prerequisites:
- You must have root or sudo privileges to run this script.
- Ensure that `passwd` and `sed` are installed on your system.

## How It Works:
1. **Check for Existing Users:**  
   The script checks the `/etc/passwd` file to see if the provided username already exists.
   
2. **Create New User:**  
   If the user does not exist, it creates a new user with the `useradd` command and assigns a randomly generated password.
   
3. **Generate Random Password:**  
   The password is created using a combination of random numbers and a randomly selected special character from a predefined set.
   
4. **SSH Configuration:**  
   The script uses `sed` to modify the `/etc/ssh/sshd_config` file to enable password authentication. It also creates a backup of this file before making changes.
   
5. **Multiple Users Creation:**  
   The script allows you to create multiple users by passing multiple arguments.## Script Example:

```bash
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

```

## How to Run the Script:
1. Save the script as `user-automation.sh`.
2. Run the script with a username as an argument:
   ```bash
   bash user-automation.sh username1 username2
   ```
   Example:
   ```bash
   bash user-automation.sh alice bob
   ```

## Notes:
- Ensure that password authentication is enabled on your system if you want to use password-based login for the newly created users.
- This script automatically forces the new user to reset their password on first login.

---

This README provides an overview of the script in simple terms, helping users understand what it does and how to use it.
