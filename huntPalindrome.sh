#!/bin/bash

echo -e "This is a bash scrip to check the palindromes in genome file !"

# split the FASTA file
# awk -F "|" '/^>/ {close(F) ; F = $1".fasta"} {print >> F}' yourfile.fa

#USAGE: ./huntPalindrome.sh -d /media/urbe/MyCDrive/JitDATA/FALCON -g refGenome -t threshold

#Location of scripts
bioScript=./scriptBase

#Set the location
#Location of the tools
sibelia=$bioScript/Sibelia-3.0.7-Linux/bin/Sibelia

Red=`tput setaf 1`
Green=`tput setaf 2`
Reset=`tput sgr0`

# location to getopts.sh file
source ./scriptBase/getopt.sh
#source scriptBase/*

USAGE="-d DIRECTORY -g GENOME -t THRESHOLD [-a START_DATE_TIME ]"
parse_options "${USAGE}" ${@}

echo "${Green}--:LOCATIONS:--${Reset}"
echo "${Green}Directory set:${Reset} ${DIRECTORY}"
echo "${Green}Genome name provided:${Reset} ${GENOME}"

#Parameters accepted -- write absolute path of the BAM file

ref=${GENOME}
filter=${THRESHOLD}

fastaFile=$(basename "$ref" .fasta)
dir=${fastaLoc%/*}
dir=${DIRECTORY} #Stote the location

#split the BAM file
echo -e "\n${Green}Splitting the FASTA file ${Reset} $fastaLoc"
awk -F "|" '/^>/ {close(F) ; F = $1".fasta"} {print >> F}' $dir/$ref
#Move all split files
mv *.fasta ${DIRECTORY}

#Create an array with all the filer/dir inside ~/myDir
echo -e "\n${Green}Storing all the FASTAs in array${Reset}"
arr=($dir/*.fasta)

echo -e "\n${Green}Working on indivisual chromosome/contig based FASTA file${Reset}"
#Iterate through array using a counter
#Run till array-1 becuase one of the them will be ref
for ((i=0; i<${#arr[@]}; i++)); do
    #do something to each element of array
    fname=$(basename "${arr[$i]}")
    if [ "$fname" != "$ref" ] #to ignore the original REF file
    then
	echo -e "FILE: $fname\nLOCATION: ${arr[$i]}"
	echo "Working on ${arr[$i]}"

	#Create depth file
	#$bedtools genomecov -ibam ${arr[$i]} -bga > $dir/coverage.$fname.tmp
	#We can grep on the fly, no need to create this huge file

  #If file is empty
  #find $dir -size  0 -print0 |xargs -0 rm --
	rm -rf $dir/coverage.$fname.tmp
	rm -rf $dir/out_$fname.sam
	rm -rf $dir/*.bed
	rm -rf $dir/*.txt
	#Remove the tmp FASTA files
	rm -rf ${arr[$i]}
	    fi
    done

echo "hunting for Palindrome completed ..."
