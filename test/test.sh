base="test"

qsub -cwd -b y -N $base -l h_vmem=130g -o /dev/null -e /dev/null "module load R/3.6.0; LD_PRELOAD=/oicr/local/sw/gcc-6.5.0/lib64/libstdc++.so.6 Rscript /u/ccha/sleepingBeautyDataAnalysis/test/test.r $file /u/ccha/sleepingBeautyDataAnalysis/logs/test.log"
  
