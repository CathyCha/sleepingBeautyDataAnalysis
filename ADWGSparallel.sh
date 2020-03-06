dir=~/mm9elements/exonBased/*

for file in $dir; do
    base_ext=${file##*/}
    base=${base_ext%.Rdata}
    qsub -cwd -b y -N $base -l h_vmem=40g -o /dev/null -e /dev/null "module load R/3.6.0; LD_PRELOAD=/oicr/local/sw/gcc-6.5.0/lib64/libstdc++.so.6 Rscript /u/ccha/sleepingBeautyDataAnalysis/performADWGS.R  $file > /u/ccha/sleepingBeautyDataAnalysis/logs/ws1mb/$base.log"
    
done
