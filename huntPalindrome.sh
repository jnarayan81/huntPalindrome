#!/bin/bash

echo -e "This is a bash scrip to check the palindromes in genome file !"

# split the FASTA file
# awk -F "|" '/^>/ {close(F) ; F = $1".fasta"} {print >> F}' yourfile.fa

#USAGE: ./huntPalindrome.sh -d /home/jitendra/myTools/huntPalindrome/test -g testPal.fa -t 1 -r normal -s 10000 -m inverted/direct

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

USAGE="-d DIRECTORY -g GENOME -t THRESHOLD -r RULE -s MINSIZE -m MODE [-a START_DATE_TIME ]"
parse_options "${USAGE}" ${@}

echo "${Green}--:LOCATIONS:--${Reset}"
echo "${Green}Directory set:${Reset} ${DIRECTORY}"
echo "${Green}Genome name provided:${Reset} ${GENOME}"
echo "${Green}Rule for the finding:${Reset} ${RULE}"
echo "${Green}Minimum block size:${Reset} ${MINSIZE}"
echo "${Green}Repeats mode selected:${Reset} ${MODE}"

#Parameters accepted -- write absolute path of the BAM file

ref=${GENOME}
filter=${THRESHOLD}

fastaFile=$(basename "$ref" .fasta)
dir=${fastaLoc%/*}
dir=${DIRECTORY} #Stote the location

#Correct the format
perl -ne 'if (/^(>\S+)/){print "$1\n";}else{print $_;}' ${DIRECTORY}/${GENOME} > ${DIRECTORY}/test.fa
mv ${DIRECTORY}/test.fa  ${DIRECTORY}/${GENOME}

#split the FASTA file
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
	
	#Delete if no palindrome
	if [ "${RULE}" == "strict" ]; then
    	echo "Strict Opted - fine !"
		rule="fine"
	else
    	echo "Strict not opted - loose!"
		rule="loose"
	fi

	#Out directory will be of same name as fasta
	$sibelia -s $rule --sequencesfile --graphfile --minblocksize ${MINSIZE} --visualize --gff --outdir $fname ${arr[$i]}
	#Delete if no palindrome
	if [ "$(ls -A $fname)" ]; then
    	echo "Take action $fname is not Empty -> Reading GFF file"
        #Check the file for any palindrome blocks values
		NUMOFLINES=$(wc -l < "$fname/blocks_coords.gff")
		#echo $NUMOFLINES
		if [ $NUMOFLINES -le 3 ]; then
			#Delete the folder as it does not contain any useful values
		    rm -rf $fname
		fi
	else
    	echo "$fname is Empty !"
	fi

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

  # Move the result in outfolder - keeping date and time
  outfoldername=$(date +%Y%m%d%H%M%S)
  mkdir $outfoldername
  echo "Moving all the results folder in $outfoldername"

pattern=">" #This ">" is present in all folder
for _dir in *"${pattern}"*; do
    [ -d "${_dir}" ] && dir="${_dir}"
	mv ${dir} $outfoldername
done
#echo "${dir}"


echo "hunting for Palindrome completed. Check results in $outfoldername folder..."
