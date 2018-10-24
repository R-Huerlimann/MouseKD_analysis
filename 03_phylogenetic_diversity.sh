#!/bin/bash

#Multiple sequence alignment
qiime alignment mafft \
  --i-sequences dada2_repseqs.qza \
  --o-alignment aligned_repseqs.qza

#Mask/Filter alignment to remove noise
qiime alignment mask \
  --i-alignment aligned_repseqs.qza \
  --o-masked-alignment masked_aligned_repseqs.qza

#FastTree to produce unrooted phylogenetic tree
qiime phylogeny fasttree \
  --i-alignment masked_aligned_repseqs.qza \
  --o-tree unrooted_tree.qza

#Root Tree (root at midpoint of the longest tip-to-tip distance in the unrooted tree)
qiime phylogeny midpoint-root \
  --i-tree unrooted_tree.qza \
  --o-rooted-tree rooted_tree.qza
