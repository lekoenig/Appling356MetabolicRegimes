
<!-- README.md is generated from README.Rmd. Please edit that file -->

# Appling356MetabolicRegimes

<!-- badges: start -->
<!-- badges: end -->

The goal of Appling356MetabolicRegimes is to leverage the
[sbtools](https://github.com/USGS-R/sbtools) package to download data
associated with “Appling et al. 2018. Metabolism estimates for 356 U.S.
rivers (2007-2017): U.S. Geological Survey data release,
<https://doi.org/10.5066/F70864KX>”

## Installation

You can install Appling356MetabolicRegimes from
[GitHub](https://github.com/) with:

``` r
# install.packages("devtools")
devtools::install_github("lekoenig/Appling356MetabolicRegimes")
```

## Examples

This package consists of a set of functions to download each data
release item directly from ScienceBase. Documentation includes examples
to download data for multiple sites.

Note that on occasion functions may hang up while connecting to
ScienceBase. If running a function is taking a very long time or if you
experience errors that reference issues with item\_file\_download, it’s
possible that ScienceBase is not available or is responding slowly at
the moment. Try re-running the function, testing whether ScienceBase is
available by running sbtools::sb\_ping(), or making some tea and trying
again in a bit.

``` r
library(Appling356MetabolicRegimes)

# Access site information:
pc_sites <- download_site_data()
pc_sites <- download_site_data(save_dir = "./data/site_data")

# Download time series zip files for a site(s) of interest:
download_timeseries_data(sitename = "nwis_01036390",save_dir = "./data/timeseries")

# Once downloaded, load time series data of water quality/quantity into R environment:
# returns a list containing the respective data tables
timeseries_dat <- load_timeseries_data(sitename = "nwis_01036390",zip_dir = "./data/timeseries")  
  
# For a given site, download the data used to estimate metabolism:
input_dat <- download_model_inputs(sitename = "nwis_01184000",save_dir = "./data/model_inputs")

# Download the model specifications used to estimate metabolism:
specs <- download_model_config(save_dir = "./data/config")

# For a given site, download complete fits from metabolism models:
# returns a list containing model parameters and estimated K600-discharge nodes
output_dat <- download_model_outputs("nwis_01184000",save_dir = "./data/model_outputs",res = c("15min"))

# Inspect diagnostics and assessments of model performance
diag_dat <- download_model_diagnostics(save_dir = "./data")

# For all sites, download daily metabolism estimates and potential predictor variables:
metab_dat <- download_metabolism_estimates(save_dir = "./data/daily_estimates")
```

## Disclaimer

I developed the wrapper functions included here to aid my own personal
workflows that rely on the Appling et al. 2018 data release. This
package is not associated with the original ScienceBase data release,
and comes with no warranty. This package is provided “AS IS.” However,
if you come across bugs or have any questions/suggestions for
improvement, please let me know:
<https://github.com/lekoenig/Appling356MetabolicRegimes/issues>.

**Some shout-outs:**  
The workhorse underlying the data download functions used here is
[sbtools](https://github.com/USGS-R/sbtools). Thanks to USGS-R for
developing and supporting these tools to interface with ScienceBase.
Also, thank you to Alison Appling and co-authors for their hard work in
creating and releasing “Metabolism estimates for 356 U.S. rivers
(2007-2017).”
