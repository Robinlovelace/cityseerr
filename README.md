cityseerr
================

<!-- README.md is generated from README.Rmd. Please edit that file -->

``` r
# Install cityseerr from GitHub
# install.packages("pak")
pak::pak("Robinlovelace/cityseerr")
```

# cityseerr

The goal of cityseerr is to provide R bindings to cityseer for computing
network centrality, accessibility metrics, and land use analysis on
urban street networks.

## Installation

You can install the development version of cityseerr from
[GitHub](https://github.com/Robinlovelace/cityseerr) with:

``` r
# install.packages("pak")
pak::pak("Robinlovelace/cityseerr")
```

## Local development

To develop the R package, clone the repo and run:

``` r
devtools::load_all()
```

## Quick test

This test verifies that the Rust code compiles and the basic functions
work:

``` r
library(cityseerr)

# Create simple test network (in practice, load from file)
nodes_test <- data.frame(
  id = 1:4,
  x = c(0, 1, 1, 2),
  y = c(0, 0, 1, 1)
)

# Test that init_network works
network <- init_network(nodes_test, nodes_test)
print(network)
#> <pointer: 0x5ed83ea1d810>
#> attr(,"class")
#> [1] "cityseer_network"

# Test that compute_centrality_ works
result <- compute_centrality_(network, distances = c(400, 800), betas = c(0.01, 0.005), type = "closeness")
print(result)
#> $node_id
#> [1] 1 2 3
#> 
#> $distances
#> [1] 400 800
#> 
#> $betas
#> [1] 0.010 0.005
#> 
#> $centrality_type
#> [1] "closeness"
#> 
#> $values
#> [1] 7.50 3.75 7.50 3.75 7.50 3.75
```

## Next steps

This is a proof-of-concept package. The next steps are:

1.  Test the full build process with `R CMD build cityseerr`
2.  Fix any compilation issues
3.  Publish to GitHub
4.  Open an issue on cityseer asking about R integration

## Contributing

Contributions are welcome! Please see the GitHub repository for details.
