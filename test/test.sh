module load R/3.6.0;
qsub -cwd -N "test" -l h_vmem=130g "LD_PRELOAD=/oicr/local/sw/gcc-6.5.0/lib64/libstdc++.so.6; Rscript /u/ccha/sleepingBeautyDataAnalysis/test/test.r"
    