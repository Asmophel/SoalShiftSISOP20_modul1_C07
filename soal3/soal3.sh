#!/bin/bash
b=28
for ((a=1; a <= $b; a=a+1))
do
wget -a wget.log  https://loremflickr.com/320/240/cat -O pdkt_kusuma_$a
done

cat wget.log | grep Location: > location.log

mkdir kenangan
mkdir duplicate

awk '{
	i++
	print i " " $2
}' location.log | awk '
	{
		count[$2]++
		if (count[$2] > 1){
			system("mv pdkt_kusuma_"$1 " duplicate/duplicate_" $1)
		}else{
			system("mv pdkt_kusuma_"$1 " kenangan/kenangan_" $1)
		}
	}
'

cat location.log >> location.log.bak
> location.log

cat wget.log >> wget.log.bak
> wget.log
