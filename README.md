# itunesr
[![Build Status](https://travis-ci.org/amrrs/itunesr.svg?branch=master)](https://travis-ci.org/amrrs/itunesr) [![CRAN\_Status\_Badge](http://www.r-pkg.org/badges/version/itunesr)](https://cran.r-project.org/package=itunesr)

Overview
--------
The goal of itunesr is to help iOS App Developers access iTunes App Store Ratings and Reviews programmatically, since iTunes Connect doesn't provide this data straightforward.

Installation
------------

``` r
# install itunesr directly from CRAN:
install.packages("itunesr")

#  the development version from GitHub:
# install.packages("devtools")
devtools::install_github("amrrs/itunesr")
```

Getting started
---------------

``` r
library(itunesr)
getAttributes(742044692,'in')
```

