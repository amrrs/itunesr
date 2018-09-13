# itunesr
[![Build Status](https://travis-ci.org/amrrs/itunesr.svg?branch=master)](https://travis-ci.org/amrrs/itunesr) [![CRAN\_Status\_Badge](http://www.r-pkg.org/badges/version/itunesr)](https://cran.r-project.org/package=itunesr) [![DOWNLOADSTOTAL](https://cranlogs.r-pkg.org/badges/grand-total/itunesr)](https://cranlogs.r-pkg.org/badges/grand-total/itunesr) [![Coverage Status](https://img.shields.io/codecov/c/github/amrrs/itunesr/master.svg)](https://codecov.io/github/amrrs/itunesr?branch=master) 
[![Rdoc](http://www.rdocumentation.org/badges/version/itunesr)](http://www.rdocumentation.org/packages/itunesr)


Overview
--------
The goal of `itunesr` is to help iOS App Developers access iTunes App Store Ratings and Reviews programmatically, since iTunes Connect doesn't provide this data straightforward.

Installation
------------

``` r
# install itunesr directly from CRAN:
install.packages("itunesr")

#  the development version from GitHub:
# install.packages("devtools")
devtools::install_github("amrrs/itunesr")
```

Dependency Packages
------------

* jsonlite
* xml2
* lubridate
* curl

Getting started
---------------

``` r
library(itunesr)
getReviews(368677368,'us',1)
getAttributes(742044692,'in')
```
```itunesr``` can be loaded just like any other R-package with ```library(itunesr)```.

**Note:** If you're trying this behind a Firewall, you might get:
```Error in open.connection(con, "rb") : Timeout was reached```
To resolve this error, Please refer this link: [Configuring R to Use an HTTP or HTTPS Proxy](https://support.rstudio.com/hc/en-us/articles/200488488-Configuring-R-to-Use-an-HTTP-or-HTTPS-Proxy)

Examples
---------------
### Code 
```r
library(itunesr)

#Latest (Page 1) Uber Reviews for the Country: US
uber_reviews <- getReviews(368677368,'us',1)

#Displaying the column names 
names(uber_reviews)

#Ratings count from the 50 Reviews
table(uber_reviews$Rating)
```


### Output
``` r
> library('itunesr')
> #Latest (Page 1) Uber Reviews for Country: US
> uber_reviews <- getReviews(368677368,'us',1)
> #Displaying the column names
> names(uber_reviews)
[1] "Title"       "Author_URL"  "Author_Name" "App_Version" "Rating"      "Review"      "Date"       
> #Ratings count from the 50 Reviews
> table(uber_reviews$Rating)

 1  2  3  4  5 
19  3  7  4 17 
```

### Using itunesr output with Tidyverse

``` r
> amazon_reviews <- getReviews("297606951","us",1)
> library(tidyverse)
> amazon_reviews %>% count(Rating)
# A tibble: 5 x 2
  Rating     n
  <fct>  <int>
1 1         25
2 2          8
3 3          9
4 4          4
5 5          4

```

