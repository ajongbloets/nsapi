NSAPI
=====

R bindings for the [Nederlandse Spoorwegen API](http://ns.nl/reisinformatie/ns-api) (NS, Dutch railways).

Package support caching of the made requests in-memory (enabled by default). \#\# Installation

The package is still in development and can be downloaded with `devtools`:

``` r
# install.packages("devtools")
devtools::install_github("jjongbloets/nsapi")
```

Usage
-----

**In order to use this package you need a [NS API Account](https://www.ns.nl/ews-aanvraagformulier/) (Free)**

The NS provides API's to different datasets:

-   Stations, provides information on all stations known by NS (works, tested)
-   Departures, provides information on real-time departure times (works, tested)
-   Disruptions, provides information on actual and planned disruptions (works, tested)
-   Prices, provides information on ticket prices (*not implemented*)
-   Planner, provides advice on train travelling (*not implemented*)

### Credential loading

Upon loading the package will try to load the required credentials from th Global Environment by looking at the variables `NS_USER` and `NS_PASS`. If these variables are not found a message will be displayed in the console and every request will fail. To manually load credentials use the `save.credentials` function:

``` r
save.credentials( "user", "pass" )
```

Configurartion
--------------

### Caching

A simple form of caching is implemented by storing the retrieved XML files into the `xml_cache` environment. When enabled, the result of requests (identified by url's) are stored along with the current time. Whenever a new request is made, the url will be looked up and if present the validity of the cache entry is checked using an expiration time.

The following options can be set using `setOption`

-   `nsapi.cache`, Enables/Disables caching. Type: `bool`. Default: `TRUE`
-   `nsapi.cache.expire.after`, After how long the cache should be invalid. Type: `integer`. Default: `20`
-   `nsapi.cache.expire.units`, Units of the expiration time, see `difftime` for possible values. Type: `str`. Default: `mins`
