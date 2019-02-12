#!/bin/bash

present=$(pwd)		#remember pwd
cd ./A3/    		#change to the subdir

for dir in ./*;  	#all TA's subdirs
do
	cd "$dir" 			#change into current TA subdir
	name=${dir:2}      		#get rid of "./" 

	firstname=$(echo $name | cut -f1 -d" ") 		#separate first name for the purpose of file
	echo $name         					#print the name

	grades=$(cat ./*/*txt | grep "Your Score" | cut -f3 -d" ") #opens .txt files and saves the grades
	n=0
	sum=0
	
	for grade in $grades    
	do
        sum=$( echo "$sum+$grade" | bc ) #add all grades
  		((n+=1))      	#add how many students
	done


	cd .. 			#change back to parental dir	
	
	c=$(echo "($sum) / $n" | bc -l) 		#full unrounded number
	d=$(echo $c | rev | cut -c 19- | rev) 		#deleting last 19 digits (rounding haha )

	echo -e Average: $d '\t''\t' "$sum/$n"		#print it on screen for fun and sanity check alongside sum/n 
	echo "" 					#new line

	echo -e $firstname '\t' $d >> ./results.txt	#writing the first name, tab and the average into the file for Excel to parse	
done

mv results.txt $present        #move the result file to the original directory
