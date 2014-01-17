#!/bin/bash
FILES=$1
for f in $FILES/*
do
	fileName=$f
	echo "${fileName:0}"
	
done
