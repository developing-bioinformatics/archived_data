get_amplicon <- function(amplicon) {
  #put R code inside here
  
  library(dplyr)
  library(tidyverse)
  
  ## Read in the table from zenodo using the url
  sample_att = read.csv(
    'https://zenodo.org/record/3774043/files/SRA%20Sample%20Worksheet.csv'
  )
  
  amp = filter(sample_att, samp_mat_process == amplicon)
  amp
  
  ## Pull the column containing the sample names.fastq
  amp %>% pull(sample_title.fastq)
  
  ## Change rbcl into a vector
  amp_name <- as.vector(amp$sample_title.fastq)
  
  ## Create the urls for the files using the paste function and download the files
  urls = vector()
  for (x in 1:length(amp_name)) {
    urls[x] = paste('https://zenodo.org/record/3736457/files/',
                    amp_name[x],
                    sep = '')
    download.file(urls[x], amp_name[x])
  }
  
  return()
}

get_amplicon('rbcLa_amplicon')


get_amplicon("ITS2_amplicon")
