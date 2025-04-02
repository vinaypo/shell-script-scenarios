## Features:
1. **Break and Continue for Iteration Control**
2. **Custom Exit Codes**
3. **Arrays in Shell Scripts**

---

## 1. **Iteration Control Using Break and Continue**

In shell scripting, `break` and `continue` are essential for controlling loops.

- **Break**: Used to exit a loop when a condition is met.
- **Continue**: Used to skip the current iteration of the loop and move on to the next iteration.

**Example:**
```bash
for i in {1..10}; do
  if [[ $i -eq 5 ]]; then
    break  # Stops the loop when i equals 5
  fi
  echo $i
done
```

## 2. **Custom Exit Codes**

In shell scripts, you can use custom exit codes to signal the success or failure of commands. For instance, if an AWS command runs successfully, but you encounter a regional endpoint issue, you can check the exit status to determine what happened.

**Example:**
```bash
aws ec2 describe-vpcs --region us-east-1
if [[ $? -ne 0 ]]; then
  echo "Incorrect region, exiting"
  exit 1
else
  echo "Correct region"
fi
```

## 3. **Arrays in Shell Scripts**

Arrays are a useful way to handle multiple values in a shell script. You can manipulate strings or data using array operations.

**Example:**
```bash
NAME='SaikiranPinapathruni'
echo ${#NAME}  # Outputs the length of the string

for i in {0..${#NAME}}; do
  echo ${NAME:$i:1}  # Prints one character at a time
done
```

---


