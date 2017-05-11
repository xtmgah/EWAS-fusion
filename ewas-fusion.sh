#!/bin/bash
#11-5-2017 MRC-Epid JHZ

engine=parallel

# SNP	pos	A1	A2	Z
if [ $# -lt 1 ] || [ "$1" == "-h" ]; then
    echo "Usage: ewas-fusion.sh <input>"
    echo "where <input> is in tab-delimited format:"
    echo "SNP pos A1 A2 Z"
    echo "The output is contained in <$1.tmp>"
    exit
fi
dir=$(pwd)/$(basename $1).tmp
if [ ! -d $dir ]; then
   mkdir -p $dir
fi
export EWAS_fusion=/genetics/bin/EWAS-fusion
awk '(NR>1) {
  FS=OFS="\t"
  $2=toupper($2)
  $3=toupper($3)
  print $1, NR, $2, $3, $4
}' $dir.txt | \
sort -k1,1 | \
join -12 -21 $EWAS_fusion/EWAS.bim - | \
awk -f $EWAS_fusion/CLEAN_ZSCORES.awk | \
awk '{if(NR==1) print "SNP","A1","A2","Z"; else {$2="";print}}' > $dir.input
ln -sf $EWAS_fusion/glist-hg19 $dir/glist-hg19
export dir=$dir
export WGT=$EWAS_fusion/EWAS/
export LDREF=$EWAS_fusion/LDREF
export FUSION=/genetics/bin/fusion_twas
export RSCRIPT=/genetics/data/software/bin/Rscript
if [[ $engine == "" ]];then
qsub -cwd -sync y \
     -v EWAS_fusion=$EWAS_fusion \
     -v dir=$dir \
     -v sumstats=$(dir).input \
     -v WGT=$WGT \
     -v LDREF=$LDREF \
     -v FUSION=$FUSION \
     -v RSCRIPT=$RSCRIPT \
     -v LOCUS_WIN=500000 \
     $EWAS_fusion/ewas-fusion.qsub
else
parallel --env EWAS_fusion \
         --env dir \
         --env WGT \
         --env LDREF \
         --env sumstats \
         --env FUSION \
         --env RSCRIPT \
         --env LOCUS_WIN \
         -C' ' '/bin/bash $EWAS_fusion/ewas-fusion.subs {} $dir $WGT $LDREF $sumstats $FUSION $RSCRIPT $EWAS_fusion $LOCUS_WIN' ::: $(seq 22)
fi
