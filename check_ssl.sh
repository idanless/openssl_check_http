function check() {
         if [ $count == 1 ]; then status=Accepted; else status=Block; fi
           }


Host=google.com
echo "check" $Host
echo "status = 0 Block / status = 1  Accepted"

echo -e "\n"
echo "check according to rule POST /root/index HTTP/1.1\r\nHost: $Host\r\n\r\nUser-Agent: idan"
data=$((echo -ne "POST /root/index HTTP/1.1\r\nHost: $Host\r\n\r\nUser-Agent: idan"  ;timeout 5 cat  ) | timeout 5 openssl s_client  -tls1_2 -connect $Host:443 2>&1)
count=$(echo $data | grep HTTP | wc -l)
check
echo $status
echo -e "\n"

echo "GET TEST GET /root/index HTTP/1.1\r\nHost: $Host\r\n\r\nUser-Agent: idan"
data=$((echo -ne "GET /root/index HTTP/1.1\r\nHost: $Host\r\n\r\nUser-Agent: idan"  ;timeout 5 cat  ) | timeout 5 openssl s_client  -tls1_2 -connect $Host:443 2>&1)
count=$(echo $data | grep HTTP | wc -l)
check
echo $status
echo -e "\n"

echo "TEST HOST POST /root/index HTTP/1.1\r\n\r\nUser-Agent: idan"
data=$((echo -ne "POST /root/index HTTP/1.1\r\n\r\nUser-Agent: idan"  ;timeout 5 cat  ) | timeout 5 openssl s_client  -tls1_2 -connect $Host:443 2>&1)
count=$(echo $data | grep HTTP | wc -l)
check
echo $status

echo -e "\n"
echo "TEST URL path POST /root HTTP/1.1\r\nHost: $Host\r\n\r\nUser-Agent: idan"
data=$((echo -ne "POST /root HTTP/1.1\r\nHost: $Host\r\n\r\nUser-Agent: idan"  ;timeout 5 cat  ) | timeout 5 openssl s_client  -tls1_2 -connect $Host:443 2>&1)
count=$(echo $data | grep HTTP | wc -l)
check
echo $status
