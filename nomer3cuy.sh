#!/bin/bash
b=28
for ((a=1; a <= $b; a=a+1))
do
wget https://loremflickr.com/320/240/cat -O dkt_kusuma_NO_$a.jpg -a wget.log 
done

#echo "hello world"
