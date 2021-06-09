#!/bin/bash

source ./env.sh

while true
do
	word=$(shuf -n1 /usr/share/dict/words)
	mysql -e "insert into cats (name) values ('$word')"

	mysql -D "fauna@replica" -e "select * from cats order by rand() limit 100" > /dev/null
	mysql -D "fauna@rdonly" -e "select * from cats order by rand() limit 100" > /dev/null

	sleep 0.2
done