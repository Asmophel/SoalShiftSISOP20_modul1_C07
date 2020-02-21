#!/bin/bash

function random(){

	array=()

	for i in {a..z} {A..Z} {0..9};
	 do
    		array[$RANDOM]=$i
	done

	printf %s ${array[@]::28} > /home/denta/Downloads/$a
}

a=$1
random $a
