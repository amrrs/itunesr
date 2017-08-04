# itunesr
[![Build Status](https://travis-ci.org/amrrs/itunesr.svg?branch=master)](https://travis-ci.org/amrrs/itunesr)

Overview
--------
The goal of itunesr is to help iOS App Developers access iTunes App Store Ratings and Reviews programmatically, since iTunes Connect doesn't provide this data straightforward.

Installation
------------

``` r
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

