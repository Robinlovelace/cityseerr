#' Compute Network Centrality Measures
#'
#' Calculates betweenness, closeness, or straightness centrality
#' for nodes in a street network using cityseer algorithms.
#'
#' @param network A network object created by `prepare_network()`.
#' @param distances A numeric vector of distances (in meters) for computing
#'   centrality. Default is c(400, 800, 1600).
#' @param betas A numeric vector of distance decay parameters. Lower values
#'   give more weight to shorter distances. Default is c(0.01, 0.005, 0.0025).
#' @param type Character string specifying centrality type:
#'   - "betweenness": Betweenness centrality
#'   - "closeness": Closeness centrality
#'   - "straightness": Straightness centrality
#' @return A list containing node IDs, distances, betas, and centrality values.
#' @export
#' @examples
#' \dontrun{
#' network <- prepare_network(nodes_sf, edges_sf)
#' result <- compute_centrality(network,
#'   distances = c(400, 800),
#'   betas = c(0.01, 0.005),
#'   type = "betweenness"
#' )
#' }
compute_centrality <- function(network,
                                distances = c(400, 800, 1600),
                                betas = c(0.01, 0.005, 0.0025),
                                type = c("betweenness", "closeness", "straightness")) {
  if (!inherits(network, "cityseer_network")) {
    rlang::abort("Expected a cityseer_network object from prepare_network()")
  }

  type <- match.arg(type)

  if (!rlang::is_bare_numeric(distances) || length(distances) < 1) {
    rlang::abort("`distances` must be a numeric vector")
  }

  if (!rlang::is_bare_numeric(betas) || length(betas) < 1) {
    rlang::abort("`betas` must be a numeric vector")
  }

  res <- compute_centrality_(network, distances, betas, type)
  res
}

#' @export
print.cityseer_centrality <- function(x, ...) {
  .info <- centrality_info_helper(x)
  to_print <- c(
    "<cityseer_centrality>",
    sprintf("nodes: %i", .info$n_nodes)
  )
  cat(to_print, sep = "\n")
  invisible(to_print)
}
