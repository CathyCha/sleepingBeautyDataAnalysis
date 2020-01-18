dir=~/mm9elements/*

for file in $dir; do
    base_ext=${file##*/}
    base=${base_ext%.rds}
    qsub -cwd -b y -N $base -l h_vmem=130g -o /dev/null -e /dev/null "Rscript /u/ccha/sleepingBeautyDataAnalysis/performADWGS.R  $file > /u/ccha/sleepingBeautyDataAnalysis/logs/$base.log"
    
done
