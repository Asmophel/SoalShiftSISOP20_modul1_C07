#!/bin/bash

function randomcok(){

	array=()

	for i in {a..z} {A..Z} {0..9};
	 do
    		array[$RANDOM]=$i
	done

	printf %s ${array[@]::28} $'\n' > /home/denta/Downloads/$a.txt
}

a=$1
randomcok $a
