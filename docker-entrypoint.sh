#!/bin/bash

confPath="/root/.biblepaycore/biblepay.conf"
envs=( "$REINDEX" "$GENPROCLIMIT" "$GEN" "$POOL" "$POOLPORT" "$WORKERID" )
vars=( "reindex" "genproclimit" "gen" "pool" "poolport" "workerid" )

if [ ! -f $confPath ]; then
	echo -e "\nCreate config file:\n"
	touch $confPath
else
	echo -e "\nEdit config file:\n"
fi

function setConf {
        if grep -q "$1" $confPath
        then
		echo "set $1=$2: replacing in $confPath"
                sed -i "s/$1=.*/$1=$2/" $confPath
        else
		echo "set $1=$2: adding to $confPath"
                echo "$1=$2" >> $confPath
        fi
}

function addNode {
	if grep -q "$1" $confPath
        then
		echo "set addnode=$1: already set in $confPath"
	else
		echo "set addnode=$1: adding to $confPath"
       		echo "addnode=$1" >> $confPath
	fi
}

addNode "node.biblepay.org"
addNode "biblepay.inspect.network"

if [ -n "$ADDNODE" ]
	then
		addNode $ADDNODE
fi

for i in "${!envs[@]}"
do
        if [ -n "${envs[$i]}" ]
        then
                setConf "${vars[$i]}" "${envs[$i]}"
        fi
done

echo -e "\nStarting biblepayd:\n"
exec "$@"
