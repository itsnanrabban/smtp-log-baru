#SCRIPT=$(for i in {1..4}; do ssh root@smtp$i-bgn -p2250 cat /var/log/mail.log | grep postfix/qmgr | grep -w from= | awk '{print$7}' | sed 's/from=//' | tr -d '<>,' | sort;done > /home/smtp-log/logemailtesting && cat /home/smtp-log/logemailtesting | sort | uniq -c | sort -nr | head -n 5)
D1=$(ssh root@smtp1-bgn -p2250 cat /var/log/mail.log | grep -i "`date --date='today' '+%b %e'`" | grep status=deferred|awk '{print $6}'|sort|uniq -c | wc -l)
D2=$(ssh root@smtp2-bgn -p2250 cat /var/log/mail.log | grep -i "`date --date='today' '+%b %e'`" | grep status=deferred|awk '{print $6}'|sort|uniq -c | wc -l)
D3=$(ssh root@smtp3-bgn -p2250 cat /var/log/mail.log | grep -i "`date --date='today' '+%b %e'`" | grep status=deferred|awk '{print $6}'|sort|uniq -c | wc -l)
D4=$(ssh root@smtp4-bgn -p2250 cat /var/log/mail.log | grep -i "`date --date='today' '+%b %e'`" | grep status=deferred|awk '{print $6}'|sort|uniq -c | wc -l)
Q1=$(ssh root@smtp1-bgn -p2250 mailq | grep -c "^[A-F0-9]")
Q2=$(ssh root@smtp2-bgn -p2250 mailq | grep -c "^[A-F0-9]")
Q3=$(ssh root@smtp3-bgn -p2250 mailq | grep -c "^[A-F0-9]")
Q4=$(ssh root@smtp4-bgn -p2250 mailq | grep -c "^[A-F0-9]")

printf "\n"
echo "--------------------------"
echo " Statistik Email SMTP-BGN "
echo "--------------------------"

printf "\n"

echo "Statistik 5 Akun Email Terbanyak"
for i in {1..4}; do ssh root@smtp$i-bgn -p2250 cat /var/log/mail.log | grep -i "`date --date='today' '+%b %e'`" | grep postfix/qmgr | grep -w from= | awk '{print$7}' | sed 's/from=//' | tr -d '<>,' | sort;done > /home/smtp-log/logemailtesting && cat /home/smtp-log/logemailtesting | sort | sed '/^[[:space:]]*$/d' | uniq -c | sort -nr | head -n 5 

printf "\n"

echo "Statistik Deferred Email SMTP"
echo "smtp1-bgn : "$D1
echo "smtp2-bgn : "$D2
echo "smtp3-bgn : "$D3
echo "smtp4-bgn : "$D4

printf "\n"

echo "Statistik Queue Email SMTP"
echo "smtp1-bgn : "$Q1
echo "smtp2-bgn : "$Q2
echo "smtp3-bgn : "$Q3
echo "smtp4-bgn : "$Q4

printf "\n"

rm -rf /home/smtp-log/logemailtesting

