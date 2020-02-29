#!/bin/bash

name=$1
filename="${name%.*}"

geser=$(stat -c %y $1 | grep -o -P '(?<= ).*(?=:.*:)')
#echo $geser

kecil="abcdefghijklmnopqrstuvwxyz"
besar="ABCDEFGHIJKLMNOPQRSTUVWXYZ"

caesar=$(echo "$filename" | sed "y/$kecil$besar/${kecil:$geser}${kecil::$geser}$
#echo $caesar

mv $name "${caesar}".txt
