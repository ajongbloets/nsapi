NSAPI
=====

R bindings for the \[Nederlandse Spoorwegen API\]\[<http://ns.nl/reisinformatie/ns-api>\] (NS, Dutch railways).

Package support caching of the made requests in-memory (enabled by default). \#\# Installation

The package is still in development and can be downloaded with `devtools`:

``` r
# install.packages("devtools")
devtools::install_github("jjongbloets/nsapi")
```

Usage
-----

**In order to use this package you need a \[NS API Account\]\[<https://www.ns.nl/ews-aanvraagformulier/>\] (Free)**

The NS provides API's to different datasets. At this stage bindings are provided for:

-   

### Credential loading

Upon loading the package will try to load the required credentials from th Global Environment by looking at the variables `NS_USER` and `NS_PASS`. If these variables are not found a message will be displayed in the console and every request will fail. To manually load credentials use the `save.credentials` function:

``` r
save.credentials( "user", "pass" )
```

Configurartion
--------------
