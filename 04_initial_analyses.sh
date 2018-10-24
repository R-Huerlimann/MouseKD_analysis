#!/bin/bash

#for both of these, check the table.qzv file and select an appropriate p-mas-depth

#alpha rarefaction
qiime diversity alpha-rarefaction \
  --i-table dada2_table.qza \
  --i-phylogeny rooted_tree.qza \
  --p-max-depth 6317 \
  --o-visualization alpha_rarefaction.qzv

#more here:
#https://chmi-sops.github.io/mydoc_qiime2.html

#running through the core alpha and beta diversity analyses.
qiime diversity core-metrics-phylogenetic \
  --i-phylogeny rooted_tree.qza \
  --i-table dada2_table.qza \
  --p-sampling-depth 6317 \
  --m-metadata-file metadata.tsv \
  --output-dir core_metrics_results
