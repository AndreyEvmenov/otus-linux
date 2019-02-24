#!/bin/bash


clear
cat access.log | cut -d " " -f 1 >log2
cat log2 | cut -d " " -f 1 | sort | uniq -c | sort -n -r | head -n 10 >log3
cat log3 |  awk '{ print $2 }' >log4
readarray array < log4
declare -A ip_arr


for i in ${array[@]}
do
 ip_arr[$i]=$i
done

echo
echo 10 most frequent ip-addresses
echo quantyty ip-address
cat log3

i=1
while [[ $i -eq 1 ]]
	do   
	
	printf 'Если необходимо расширенная информация введите 1, если нет 0: '
	read i  
	

	echo
	printf 'Для просмотра информации WHOIS введите 1, для просмотра объема трафика введите 2, выход 3: '
	read PUNKT

case $PUNKT in
     1)
	echo
	
	for ii in ${ip_arr[@]}
		do
		echo
		echo 
		echo "$ii"
		whois "$ii"  | awk '($1 != "#")&&($1 != "%")&&(!/^$/) { print $0 }' | head -n 15
		done
		echo
          ;;

     2)

		echo
		echo 'Узлы с наибольшим трафиком'
		echo '     Трафик               Адрес'
		cat access.log | awk ' { total[$1] += $10 } END { for (x in total) { printf "%9.2f Mb : ip-addr %3s,\n", total[x]/1024/1024, x } } ' | sort -nr | head -n10
		echo
		echo          
          ;;

	 3)    
		  
		  ;;


     *)
          echo "Ошибка выбора"
          ;;
esac


	done
echo работа окончена


