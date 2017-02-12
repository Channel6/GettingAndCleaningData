## Class Project for "Getting and Cleaning Data"

The class project for [Getting and Cleaning Data](https://www.coursera.org/course/getdata) was to read in the ["Human Activity Recognition Using Smartphones" data set](http://archive.ics.uci.edu/ml/datasets/Human+Activity+Recognition+Using+Smartphones), perform an analysis on the data set, and output a tidy data set.

This script will automatically download, unpack, and read relevant files. However, at this time, it does not verifify if the zip file has been downloaded, the directory created, or the files available. It will verify if you have a "data" directory in the current working directory on a UNIX-like system, and work from there.

**Once those steps are complete, you can run the R script ([run_analysis.R](run_analysis.R)).**
Required CRAN packages:

* [dplyr](https://cran.rstudio.com/web/packages/dplyr/vignettes/introduction.html)
* [tidyr](https://cran.r-project.org/web/packages/tidyr/index.html)
* [plyr](https://cran.r-project.org/web/packages/plyr/index.html)

**The output of the R script is a tidy data set, tidydata.txt.**

You can read more about the data and the analysis in the [code book](CodeBook.md).
