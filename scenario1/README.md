
Wrote a sample shell script to list the aws resources in monitor.sh.

gave the required permissions to execute the shell script
```
chmod 755 /home/ubuntu/monitor.sh
./monitor.sh
```

this process should be done daily @16 and store the results in log file to send it to the reporting board.

this process should be done by using crontab 
```
crontab -e
```
add this * 16 * * * /home/ubuntu/monitor.sh /home/ubuntu/monitor_logs.txt

to list the edited cronjob
```
crontab -l
```
monitor_logs.txt file will be loaded with the resource details every minute @16
