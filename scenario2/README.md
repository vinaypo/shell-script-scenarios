### Useage of AWS Resources 

Wrote a sample shell script to list the aws resources in monitor.s
gave the required permissions to execute the shell script
```
chmod 755 /home/ubuntu/shell-scripting-scenarios/scenario2/monitor.sh
./monitor.sh
```

this process should run the cronjob daily @19 and store the results in log file to send it to the reporting board
this process should be done by using crontab 
edit the crontab
```
crontab -e
```
add this * 19 * * * /home/ubuntu/shell-scripting-scenarios/scenario2/monitor.sh >> /home/ubuntu/shell-scripting-scenarios/scenario2/monitor_logs.txt
to list the edited crontab 
```
crontab -l
```
monitor_logs.txt file will be loaded with the resource details every minute @19
