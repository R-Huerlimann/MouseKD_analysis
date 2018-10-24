#!/bin/bash
#Roger Huerlimann
#2018/09/12
#Script to generate manifest file from gzipped raw fastq files located in folder named Data 

echo "Creating manifest file"

echo "sample-id,absolute-filepath,direction" > manifest.txt #initiates manifest file and prints header

for i in Data/*R1_001.fastq.gz;do
    name=$(echo $i | sed 's|Data/||' | sed 's|_.*||')
    echo "${name},$PWD/${i},forward" >>  manifest.txt #prints info and adds it to manifest
    echo "${name},$PWD/${i/_R1/_R2},reverse" >>  manifest.txt #prints info and adds to manifest
done

echo "Done"
echo "Importing data into QIIME2"

qiime tools import \
  --type 'SampleData[PairedEndSequencesWithQuality]' \
  --input-path manifest.txt \
  --output-path manifestout.qza \
  --input-format PairedEndFastqManifestPhred33
echo "Done"

echo "Summarizing imported data"
qiime demux summarize \
  --i-data manifestout.qza \
  --o-visualization manifestout.qzv

echo "Done"
echo
echo "Visualize manifestout.qvz in https://view.qiime2.org to determine trimming values in 02_denoising.sh"

