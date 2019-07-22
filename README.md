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
-v visualize with circos [yes/no]

```

## OUTPUT FORMAT

huntPalindrome outfile columns: final.combined

* REF_CHROM       &lt;Reference entry chromosome name
* RPO_NAME        &lt;Name of the program used
* DETAIL          &lt;Detail of program
* REF_START       &lt;Reference start boundary estimate
* REF_END         &lt;Reference end boundary estimate
* REF_STRAND      &lt;Reference block strand
* REF_BLOCK       &lt;Reference synteny blocks number
* TAR_CHR         &lt;Targer chromosome name
* TAR_START       &lt;Target start location
* TAR_END         &lt;Target end location
* TAR_STRAND      &lt;Targer block strand
* TAR_BLOCK       &lt;Targer block number
* REPEATS         &lt;Detail information about the repeats

huntPalindrome result stats columns: final.stat

* TYPE            &lt;Type of repeats
* BLOCK_COUNT     &lt;Number of blocks
* BLOCK_SIZE      &lt;Size of repeats blocks
* GENOME_SIZE     &lt;Size of the genome
* PERCENTAGE      &lt;Percentage of bases in direct/indirect repeats

