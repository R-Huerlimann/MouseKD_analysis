#!/bin/bash

#need to look into training the classifier for the specific region only.
#see here: https://docs.qiime2.org/2018.8/tutorials/feature-classifier/

classifier=/home1/16/jc167987/QIIME2/classifiers/GG_V3V4_classifier/classifier_GG_99_V3V4.qza


qiime feature-classifier classify-sklearn \
  --i-classifier ${classifier} \
  --i-reads dada2_repseqs.qza \
  --o-classification taxonomy.qza

qiime metadata tabulate \
  --m-input-file taxonomy.qza \
  --o-visualization taxonomy.qzv

#first, export your data as a .biom
qiime tools export \
  --input-path dada2_table.qza \
  --output-path biom_export

#then export taxonomy info
qiime tools export \
  --input-path taxonomy.qza \
  --output-path biom_export

###combining the taxonomy and biom file so it can be imported into Calypso
#first modifying the header of taxonomy.tsv so it works in biom
cat biom_export/taxonomy.tsv | sed 's|Feature ID|#OTUID|' | sed 's|Taxon|taxonomy|' | sed 's|Confidence|confidence|' > biom_export/biom_taxonomy.tsv

#then merging them
biom add-metadata -i biom_export/feature-table.biom -o biom_export/table-with-taxonomy.biom --observation-metadata-fp biom_export/biom_taxonomy.tsv --sc-separated taxonomy


#based on information here:
#https://forum.qiime2.org/t/is-there-any-way-to-summarize-taxa-plot-by-category/446/2?u=jairideout
