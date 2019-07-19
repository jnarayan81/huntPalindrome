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
