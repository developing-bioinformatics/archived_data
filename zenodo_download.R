library(dplyr)
library(tidyverse)

## Read in the table from zenodo using the url
sample_att = read.csv('https://sandbox.zenodo.org/record/526712/files/SRA%20Sample%20Worksheet.csv')

## group by amplicon and tally to see how many samples per amplicon
amp= sample_att %>%
  group_by(samp_mat_process)%>%
  tally()
amp

## Filter by amplicon you want

rbcl= filter(sample_att, samp_mat_process== "rbcLa_amplicon")
rbcl

## Pull the column containing the sample names.fastq
rbcl %>% pull(sample_title.fastq)

## Change rbcl into a vector
rbcl_name <- as.vector(rbcl$sample_title.fastq)

## Create the urls for the files using the paste function and download the files
urls = vector()
for(x in 1:length(rbcl_name)){
  urls[x] = paste('https://sandbox.zenodo.org/record/527229/files/', rbcl_name[x], sep='')
  download.file(urls[x], rbcl_name[x])
}
