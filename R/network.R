#' Prepare a Network from sf Objects
#'
#' Creates a cityseerr network structure from sf node and edge objects.
#' The network must be in a projected CRS (not WGS84/lon-lat).
#'
#' @param nodes An sf object with POINT geometries representing network nodes.
#' @param edges An sf object with LINESTRING geometries representing network edges.
#' @return A cityseerr network object for use with centrality functions.
#' @export
#' @examples
#' \dontrun{
#' # Create network from sf objects
#' network <- prepare_network(nodes_sf, edges_sf)
#' }
prepare_network <- function(nodes, edges) {
  if (!rlang::is_true(sf::st_is_longlat(nodes)) &&
      !rlang::is_true(sf::st_is_longlat(edges))) {
    rlang::abort("Network must be in a projected CRS, not WGS84 (lon-lat).")
  }

  init_network(nodes, edges)
}

#' @export
print.cityseer_network <- function(x, ...) {
  .info <- network_info_helper(x)
  to_print <- c(
    "<cityseer_network>",
    sprintf("nodes: %i", .info$n_nodes),
    sprintf("edges: %i", .info$n_edges)
  )
  cat(to_print, sep = "\n")
  invisible(to_print)
}
