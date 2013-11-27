au13uwgeoarchlab
================

An [R](http://www.r-project.org/) package for simple exploratory analyses and visualization of geoarchaeological data for the UW ARCHY 482 & 486 Geoarchaeology class of Autumn 2013. The objective is to promote reproducible research in geoarchaeology by making the analyses explicit and by supporting reporting of the results in a R Markdown file that includes text, figures, and the code that generated the results. 

How to install
----
First, make sure you've got Hadley Wickham's excellent devtools package installed. If you haven't got it, you can get it with these lines in your R console:

```
install.packages(pkgs = "devtools", dependencies = TRUE)
```
Windows users may also need to install [Rtools](http://cran.rstudio.com/bin/windows/Rtools/) and Mac users may also need to install [Xcode](https://developer.apple.com/xcode/). These are installed outside of R. 

Then, use the `install_github()` function to fetch this package from github:

```
require(devtools)
install_github(repo = "au13uwgeoarchlab", username = "UW-Geoarchaeology-Lab", quick=TRUE)
```

Finally, attach the package to your R session like so, and get some basic information about it:

```
require(au13uwgeoarchlab)
# get a list of functions in this package
ls("package:au13uwgeoarchlab")
# get help on how to use a function
?psd_strat_plot
```

How to get started
----
Get the [lab report template R Markdown file](https://raw.github.com/UW-Georchaeology-Lab/au13uwgeoarchlab/master/vignettes/vignette.Rmd) by right-clicking on the [link](https://raw.github.com/UW-Georchaeology-Lab/au13uwgeoarchlab/master/vignettes/vignette.Rmd) and saving as an Rmd file to work on in [RStudio](http://www.rstudio.com/ide/download/). Then study the lab report template carefully because it shows how all of the functions in this package should be used. [This](https://docs.google.com/viewer?url=https%3A%2F%2Fgithub.com%2FUW-Georchaeology-Lab%2Fau13uwgeoarchlab%2Fblob%2Fmaster%2Fvignettes%2Fvignette.pdf%3Fraw%3Dtrue) is what is looks like when it's working properly. 

Solutions to common problems
----
Message: `Error: attempt to use zero-length variable name`
Solution: You are probably trying to use a file name that has spaces or an unusual
character in it. Change your filename so it has no spaces and, ideally, 
no punctuation that can be mistaken for a maths symbol (ie. no +, -, /. :, periods, etc.)

Message: `...had status 1`
Solution: You probably have your PDF file open and R cannot overwrite the file
while it's open. Quit all your PDF files and try again. 

Message: `... .Random.seed ...`
Solution: Go to the location of your markdown file and delete the folders called
`cache` and `figure`, then try again

Message: `Error: client error: (406) Not Acceptable` Solution: Try this instead:

```
install.packages("installr")
require(installr)
install.packages.zip("https://github.com/UW-Geoarchaeology-Lab/au13uwgeoarchlab/archive/master.zip")
# ignore any messages after install.packages.zip
require(au13uwgeoarchlab)
```



Limitations and License
----
Currently this package is limited to the exploration of the data collected during Autumn 2013. 

The MIT License (MIT)

Copyright (c) 2013 Ben Marwick

Permission is hereby granted, free of charge, to any person obtaining a copy
of this software and associated documentation files (the "Software"), to deal
in the Software without restriction, including without limitation the rights
to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
copies of the Software, and to permit persons to whom the Software is
furnished to do so, subject to the following conditions:

The above copyright notice and this permission notice shall be included in all
copies or substantial portions of the Software.

THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE
SOFTWARE.

  
