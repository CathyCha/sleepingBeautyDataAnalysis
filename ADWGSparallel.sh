dir=~/SB_Data/*

for file in $dir; do
    base_ext=${file##*/}
    base=${base_ext%.rds}
    qsub -cwd -b y -N $base -l h_vmem=130g -o /dev/null -e /dev/null "module load R/3.6.0; LD_PRELOAD=/oicr/local/sw/gcc-6.5.0/lib64/libstdc++.so.6 Rscript /u/ccha/sleepingBeautyDataAnalysis/performADWGS.R  $file > /u/ccha/sleepingBeautyDataAnalysis/logs/$base.log"
    
done