#!/bin/bash

TOKEN=1382843305:AAHzHe30OE0Tk2Y4z4MKsFWK016M72BCWMo
CHAT_ID=-1001270129998
#MESSAGE="Hello World"
SCRIPT=$(for i in {1..4}; do ssh root@smtp$i-bgn -p2250 cat /var/log/mail.log | grep -i "`date --date='today' '+%b %e'`" | grep postfix/qmgr | grep -w from= | awk '{print$7}' | sed 's/from=//' | tr -d '<>,' | sort;done > /home/smtp-log/logemailtesting && cat /home/smtp-log/logemailtesting | sort | sed '/^[[:space:]]*$/d' | uniq -c | sort -nr | head -n 5)
#SCRIPT=$(for i in {1..4}; do ssh root@smtp$i-bgn -p2250 grep -i "`date --date='today' '+%b %e'`" /var/log/mail.log | grep postfix/qmgr | grep -w from= | awk '{print$7}' | sed 's/from=//' | tr -d '<>,' | sort;done > /home/smtp-log/logemailtesting && cat /home/smtp-log/logemailtesting | sort | uniq -c | sort -nr | head -n 5)
D1=$(ssh root@smtp1-bgn -p2250 cat /var/log/mail.log | grep -i "`date --date='today' '+%b %e'`" | grep status=deferred|awk '{print $6}'|sort|uniq -c | wc -l)
D2=$(ssh root@smtp2-bgn -p2250 cat /var/log/mail.log | grep -i "`date --date='today' '+%b %e'`" | grep status=deferred|awk '{print $6}'|sort|uniq -c | wc -l)
D3=$(ssh root@smtp3-bgn -p2250 cat /var/log/mail.log | grep -i "`date --date='today' '+%b %e'`" | grep status=deferred|awk '{print $6}'|sort|uniq -c | wc -l)
D4=$(ssh root@smtp4-bgn -p2250 cat /var/log/mail.log | grep -i "`date --date='today' '+%b %e'`" | grep status=deferred|awk '{print $6}'|sort|uniq -c | wc -l)
Q1=$(ssh root@smtp1-bgn -p2250 mailq | grep -c "^[A-F0-9]")
Q2=$(ssh root@smtp2-bgn -p2250 mailq | grep -c "^[A-F0-9]")
Q3=$(ssh root@smtp3-bgn -p2250 mailq | grep -c "^[A-F0-9]")
Q4=$(ssh root@smtp4-bgn -p2250 mailq | grep -c "^[A-F0-9]")
#TEXT=urlencode("Ini Status Blacklist RBL PMG \n $SCRIPT")
URL="https://api.telegram.org/bot$TOKEN/sendMessage"

curl -s -X POST $URL -d chat_id=$CHAT_ID -d text="Statistik Email SMTP-BGN%0A%0AStatistik 5 Akun Email Terbanyak %0A$SCRIPT%0A%0AStatistik Deferred Email SMTP%0Asmtp1-bgn : $D1%0Asmtp2-bgn : $D2%0Asmtp3-bgn : $D3%0Asmtp4-bgn : $D4%0A%0AStatistik Queue Email SMTP%0Asmtp1-bgn : $Q1%0Asmtp2-bgn : $Q2%0Asmtp3-bgn : $Q3%0Asmtp4-bgn : $Q4"

rm -rf /home/smtp-log/logemailtesting
