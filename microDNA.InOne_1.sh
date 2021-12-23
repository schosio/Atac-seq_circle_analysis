#Arg1 is bowtie2 index file "/hdata1/CIRCLE_ANALYSIS/MICRODNA-HG38/hg38"
#Arg2 is fastq file 1 "fastqfile1"
#Arg3 is fastq file 2 "fastqfile2"
#Arg4 is # of processor "24" Higher the number lower would be run time.
#Arg5 is Sample name  "C4-2" in this case because circular DNA was isolated from C4-2 cell lines. You want give anyname to sample 
#Arg6 Read length "49"
#Arg7 Longest circle wish to identify "10000" Higher this number more time it would take to finish the run.
#Arg8 Path of script directory
#USAGE: bash /path-of-script-directory/microDNA.InOne.sh /path-of-script-directory/hg38  Index11_1.fq Index11_2.fq 24 C4-2 49 10000 /path-of-script-directory/ & 
#bowtie2 -x $1 -1 $2 -2 $3 --end-to-end -p $4 > $5-hg38.sam
#samtools view -bS -@ $4 $5-hg38.sam -o $5-hg38.bam
#samtools sort -@ $4 $5-hg38.bam -o $5-hg38.sorted.bam
#samtools index $5-hg38.sorted.bam
path=/home/chaos/sashi1/Circle_finder
thread=20
ref_path=/home/chaos/INDEX/hg38/bowtie2/hg38
read_length=75
echo "samtools view -@ $thread -f 4 -F32 /home/chaos/sashi1/tcga_cesc_samples/65450906-f848-4f24-b49f-cfc0111f45bd_atacseq_gdc_realn.bam | awk '$4>0 && $4==$8 && $6=="*"' | awk '$10!~/NNNNNNNNNN/ {printf("%sminus_%s_%d\t%s\t%s\n",$1,$3,$4,$10,$11)}' > 65.hg38_NM"
#samtools view -@ $thread -f 4 -F32 /home/chaos/sashi1/tcga_cesc_samples/65450906-f848-4f24-b49f-cfc0111f45bd_atacseq_gdc_realn.bam | awk '$4>0 && $4==$8 && $6=="*"' | awk '$10!~/NNNNNNNNNN/ {printf("%sminus_%s_%d\t%s\t%s\n",$1,$3,$4,$10,$11)}' > 65.hg38_NM
echo "samtools view -@ $thread -f 36 /home/chaos/sashi1/tcga_cesc_samples/65450906-f848-4f24-b49f-cfc0111f45bd_atacseq_gdc_realn.bam | awk '$4>0 && $4==$8 && $6=="*"' | awk '$10!~/NNNNNNNNNN/ {printf("%splus_%s_%d\t%s\t%s\n",$1,$3,$4,$10,$11)}' >> 65.hg38_NM"
#samtools view -@ $thread -f 36 /home/chaos/sashi1/tcga_cesc_samples/65450906-f848-4f24-b49f-cfc0111f45bd_atacseq_gdc_realn.bam | awk '$4>0 && $4==$8 && $6=="*"' | awk '$10!~/NNNNNNNNNN/ {printf("%splus_%s_%d\t%s\t%s\n",$1,$3,$4,$10,$11)}' >> 65.hg38_NM
echo "bash $path/FromBamExtractProperpairreads2Island2Inetrsect2MappedUnmapped.sh /home/chaos/sashi1/tcga_cesc_samples/65450906-f848-4f24-b49f-cfc0111f45bd_atacseq_gdc_realn.bam 195471971 $read_length 65.hg38_NM 50 $thread 10000 $path > Island_PE"
#bash $path/FromBamExtractProperpairreads2Island2Inetrsect2MappedUnmapped.sh /home/chaos/sashi1/tcga_cesc_samples/65450906-f848-4f24-b49f-cfc0111f45bd_atacseq_gdc_realn.bam 195471971 $read_length 65.hg38_NM 50 $thread 10000 $path > Island_PE
echo "bash $path/microDNA.RunAsOneJob.parallel.bowtie.sh Island.Mapped-Unmapped_file.Intersect_PE.bed 1 /home/chaos/sashi1/tcga_cesc_samples/65450906-f848-4f24-b49f-cfc0111f45bd_atacseq_gdc_realn.bam $ref_path.fa 10000 $thread $path"
#bash $path/microDNA.RunAsOneJob.parallel.bowtie.sh Island.Mapped-Unmapped_file.Intersect_PE.bed 1 /home/chaos/sashi1/tcga_cesc_samples/65450906-f848-4f24-b49f-cfc0111f45bd_atacseq_gdc_realn.bam $ref_path.fa 10000 $thread $path

echo "bash $path/LeftShift.co-ordinate.withJT.sh $refpath.fa 10000 $path"
#bash $path/LeftShift.co-ordinate.withJT.sh $refpath.fa 10000 $path
echo "bash $path/Check-whole-read-mappingon-probable-junction-plus-minus.sh microDNA.JT.postalign.bed $ref_path.fa 75 $thread 65450906-f848-4f24-b49f-cfc0111f45bd_atacseq_gdc_realn"
#bash $path/Check-whole-read-mappingon-probable-junction-plus-minus.sh microDNA.JT.postalign.bed $ref_path.fa 75 $thread 65450906-f848-4f24-b49f-cfc0111f45bd_atacseq_gdc_realn
echo "bash $path/Direct-repeat.withJT.sh $ref_path.fa 10000 $path"
#bash $path/Direct-repeat.withJT.sh $ref_path.fa 10000 $path
#The final circle co-ordinate is based on 1 based system
