# Tests for cityseerr package
# These tests verify that the Rust bindings work correctly

test_that("init_network creates network object", {
  # Create simple test data
  nodes <- data.frame(id = 1:4, x = c(0, 1, 1, 2), y = c(0, 0, 1, 1))
  edges <- data.frame(from = c(1, 2, 2, 3), to = c(2, 1, 3, 4))

  # Test that init_network returns a cityseer_network object
  network <- init_network(nodes, edges)
  expect_s3_class(network, "cityseer_network")
})

test_that("compute_centrality returns a list", {
  nodes <- data.frame(id = 1:4, x = c(0, 1, 1, 2), y = c(0, 0, 1, 1))
  network <- init_network(nodes, nodes)

  result <- compute_centrality(network, distances = c(400), betas = c(0.01))

  expect_type(result, "list")
  expect_named(result, c("node_id", "distances", "betas", "centrality_type", "values"))
})

test_that("network_info_helper returns node and edge counts", {
  nodes <- data.frame(id = 1:3, x = c(0, 1, 2), y = c(0, 1, 2))
  network <- init_network(nodes, nodes)

  info <- network_info_helper(network)

  expect_equal(info$n_nodes, 3)
})

test_that("centrality_info_helper returns node count", {
  nodes <- data.frame(id = 1:3, x = c(0, 1, 2), y = c(0, 1, 2))
  network <- init_network(nodes, nodes)
  result <- compute_centrality(network)

  info <- centrality_info_helper(result)
  expect_equal(info$n_nodes, 3)
})
