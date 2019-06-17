#/bin/bash

#p-n-threads => how many cores are used. 0 = all available, change to more reasonable number if required
qiime dada2 denoise-paired \
  --i-demultiplexed-seqs manifestout.qza \
  --p-trim-left-f 20 \
  --p-trim-left-r 21 \
  --p-trunc-len-f 270 \
  --p-trunc-len-r 230 \
  --p-max-ee 6 \
  --p-chimera-method consensus \
  --p-n-threads 55 \
  --o-table dada2_table.qza \
  --o-representative-sequences dada2_repseqs.qza \
  --o-denoising-stats dada2_denoising_stats.qza \
  --verbose

#summarizing the outputs from dada2
qiime feature-table summarize \
  --i-table dada2_table.qza \
  --o-visualization dada2_table.qzv

qiime feature-table tabulate-seqs \
  --i-data dada2_repseqs.qza \
  --o-visualization dada2_repseqs.qzv
