au13uwgeoarchlab
================

Simple exploratory anayses and visualisation of geoarchaeological data for the UW ARCHY 482/486 Geoarchaeology class of Autumn 2013. The objective is to promote reproducible research in geoarchaeology by making the analyses explicit and supporting reporting of the results in a R Markdown file that includes text, figures, and the code that generated the results. 

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
install_github(repo = "au13uwgeoarchlab", username = "UW-Georchaeology-Lab", quick=TRUE)
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
Solution: You are probably trying to use a file name that has spaces or an unsual
character in it. Change your filename so it has no spaces and, ideally, 
no puncutaiton that can be mistaken for a maths symbol (ie. no +, -, /. :, periods, etc.)

Message: `...had status 1`
Solution: You probably have your PDF file open and R cannot overwrite the file
while it's open. Quit all your PDF files and try again. 

Message: `... .Random.seed ...`
Solution: Go to the location of your markdown file and delete the folders called
`cache` and `figure`, then try again



Limitations and License
----
Currently this package is limited to the exploration of the data collected during Autumn 2013. 

Copyright (C) 2013  Ben Marwick

This program is free software; you can redistribute it and/or
modify it under the terms of the GNU General Public License
as published by the Free Software Foundation; either version 2
of the License, or (at your option) any later version.

This program is distributed in the hope that it will be useful,
but WITHOUT ANY WARRANTY; without even the implied warranty of
MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
GNU General Public License for more details.

  
