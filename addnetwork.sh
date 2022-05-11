printf "\n"

echo "------------------------------------------------------------"
echo " Silahkan Input IP yang Ingin di Whitelist Pada SMTP Server"
echo "------------------------------------------------------------"

printf "\n"

read -p "Masukkan IP Subnet / IP Server yang Akan di Whitelist (ex:1.1.1.1 atau 1.1.1.1/32) : " ip

for i in {1..4}; do echo $ip ' OK' | ssh root@smtp$i-bgn -p2250 -T "cat >> /etc/postfix/mynetworks";done 

for i in {1..4}; do ssh root@smtp$i-bgn -p2250 -T "service postfix restart && postmap /etc/postfix/mynetworks";done

printf "\n"

echo "IP Network Berhasil di Whitelist"
