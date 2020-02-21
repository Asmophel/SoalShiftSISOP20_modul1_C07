#!/bin/bash
b=28
for ((a=1; a <= $b; a=a+1))
do
wget a wget.log  https://loremflickr.com/320/240/cat -O dkt_kusuma_NO_$a.jpg
done
