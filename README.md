# huntPalindrome
Find palindrome/large-scale-inverted-repeats in contigs/scaffolds/genomes

# Usage
```
./huntPalindrome.sh -d /home/jitendra/myTools/huntPalindrome/test -g testPal.fa -t 1 -r normal -s 10000 -m all

-d Absolute path of directory
-g genome file name / should be in directory
-t threshold / keep it 1 -- not used by now
-r rule for synteny [strict/normal]
-s synteny resolution / best at 10000
-m mode of reporting [inverted/direct/all]

```

## OUTPUT FORMAT

huntPalindrome outfile columns: final.combined

* REF_CHROM       Reference entry chromosome name
* RPO_NAME        Name of the program used
* DETAIL          Detail of program
* REF_START       Reference start boundary estimate
* REF_END         Reference end boundary estimate
* REF_STRAND      Reference block strand
* REF_BLOCK       Reference synteny blocks number
* TAR_CHR         Targer chromosome name
* TAR_START       Target start location
* TAR_END         Target end location
* TAR_STRAND      Targer block strand
* TAR_BLOCK       Targer block number
* REPEATS         Detail information about the repeats

huntPalindrome result stats columns: final.stat

* TYPE            Type of repeats
* BLOCK_COUNT     Number of blocks
* BLOCK_SIZE      Size of repeats blocks
* GENOME_SIZE     Size of the genome
* PERCENTAGE      Percentage of bases in irect/indirect repeats

