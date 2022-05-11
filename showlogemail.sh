printf "\n"

echo "--------------------------------------------"
echo " Silahkan Input Data Untuk Melihat Log Email"
echo "--------------------------------------------"

printf "\n"

read -p "Masukkan Alamat Email Penerima : " sender
#read -p "Masukkan Alamat Email Penerima : " receiver

printf "\n"

for i in {1..4}; do ssh smtp$i-bgn -p2250 "/home/mailgrep.pl -s" $sender;done

printf "\n"
#ssh smtp1-bgn -p2250 "/home/mailgrep.pl -s" $sender
