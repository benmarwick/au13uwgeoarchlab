#' Make a PDF from a R Markdown file
#' 
#' For this function you'll need to have two other programs installed on your computer. 
#' These programs are not part of R, so the first time you use this function 
#' you'll need to leave R, install these programs, then \emph{RESTART} R before 
#' running this fuction. After the first run, you don't need to restart again when
#' using this function. Here are the two other programs you need: 
#' (1) \href{http://johnmacfarlane.net/pandoc/installing.html}{Pandoc} and (2) LaTeX, 
#' follow the instructions on the Pandoc download page: \href{http://johnmacfarlane.net/pandoc/installing.html}{http://johnmacfarlane.net/pandoc/installing.html} 
#' 
#' @param my_rmd_filename the filename of your R Markdown file, without the .Rmd bit on the end. 
#' The file name must be in quote marks
#' 
#' @param wd the full path of the folder that contains your Rmd file. The path must be 
#' in quote marks. You can find the path by opening the folder on your desktop and 
#' then right-clicking on the R Markdown file and clicking 'Properties' (on windows) 
#' or 'Get Info' (on a Mac). Note that the path must have forward slashes (/) separating 
#' the parts of the path, not backslashes (\), which are the default on windows. You 
#' will have to replace the slashes by hand before running this function. 
#' 
#' 
#' @return a PDF in your working directory, and in the console you'll get the 
#' full path to where that PDF is (should be the same as what you put in the
#' function to make the PDF)
#' 
#' 
#' @export
#' 
#' @examples
#' 
#' # hopefully your path will be simpler than mine!
#'  rmd_to_pdf("my_lab_report", 
#'            "E:/My Documents/My UW/Teaching/2008 482 Geoarchaeology/2013 Autumn 482 & 486/AU13 482 & 486 Lab report/AU13-ARCHY-486-Geoarchaeology-Lab/au13_uw_geoarch_lab/au13_uw_geoarch_lab")
#'                           
  

rmd_to_pdf <- function(my_rmd_filename,  wd, ...){
  
  # fix slashes
  # wd <- gsub("\\\\","/", wd)

  
  # set working directory - you'll need to change this to the folder where 
  # you've saved this file that you're working on. Note the double-backslashes!
  tmp <- getwd()
  if(tmp == wd){
         0       # if working directory is already wd, do nothing
  } else {
    setwd(wd)  } # assumes wd has been set earlier in the line above
     
  
  # Load packages. By now you know you'll need to install these packages
  # the first time that you need them. 
  require(knitr)
  require(markdown)
  
  # Process this .Rmd and generate a .pdf file (including smart punctuation and grey background of code blocks)
  # For this step you'll need to have two other programs installed on your computer
  # 1. Pandoc: http://johnmacfarlane.net/pandoc/installing.html
  # 2. LaTeX: follow the instructions on the Pandoc download page
  
  filen <- my_rmd_filename # name of the markdown file without suffix
  knit(paste0(filen,".Rmd"))
  system(paste0("pandoc -s ", paste0(filen,".md"), " -t latex -o ", paste0(filen,".pdf"), " --highlight-style=tango  -S"))
  
  # Now find the location on your computer where the PDF file was created:
  return(getwd())
  
  
}