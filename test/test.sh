module load R/3.6.0;
LD_PRELOAD=/oicr/local/sw/gcc-6.5.0/lib64/libstdc++.so.6;
qsub -cwd -N "test" -l h_vmem=130g "Rscript /u/ccha/sleepingBeautyDataAnalysis/test/test.r"
  