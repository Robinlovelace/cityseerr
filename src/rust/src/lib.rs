use extendr_api::prelude::*;

/// Cityseer network structure - simplified for proof of concept
#[derive(Clone, Debug)]
pub struct CityseerNetwork {
    pub n_nodes: usize,
    pub n_edges: usize,
}

/// Initialize a cityseer network from R objects
#[extendr]
fn init_network(nodes: Robj, edges: Robj) -> ExternalPtr<CityseerNetwork> {
    let n_nodes = nodes.len();
    let n_edges = edges.len();

    let network = CityseerNetwork {
        n_nodes,
        n_edges,
    };

    let mut ptr = ExternalPtr::new(network);
    ptr.set_class(["cityseer_network"]).unwrap();
    ptr
}

/// Compute centrality measures - returns a simple list
#[extendr]
fn compute_centrality_(
    network: ExternalPtr<CityseerNetwork>,
    distances: Vec<f64>,
    betas: Vec<f64>,
    centrality_type: &str,
) -> Robj {
    let distances_vec = if distances.is_empty() {
        vec![400.0, 800.0, 1600.0]
    } else {
        distances
    };

    let betas_vec = if betas.is_empty() {
        vec![0.01, 0.005, 0.0025]
    } else {
        betas
    };

    let n = network.n_nodes;
    let min_len = std::cmp::min(distances_vec.len(), betas_vec.len());

    // Create result vectors
    let mut node_ids: Vec<i32> = Vec::with_capacity(n);
    let mut values: Vec<f64> = Vec::with_capacity(n * min_len);

    for i in 0..n {
        node_ids.push((i + 1) as i32);
        for j in 0..min_len {
            let beta = betas_vec[j];
            // Simplified centrality computation
            let base_centrality = (network.n_edges as f64) / (n as f64 + 1.0);
            let value = base_centrality * beta * 1000.0;
            values.push(value);
        }
    }

    list!(
        node_id = node_ids,
        distances = distances_vec,
        betas = betas_vec,
        centrality_type = centrality_type,
        values = values
    ).into()
}

/// Get network info helper
#[extendr]
fn network_info_helper(x: ExternalPtr<CityseerNetwork>) -> Robj {
    list!(
        n_nodes = x.n_nodes,
        n_edges = x.n_edges
    ).into()
}

/// Get centrality info helper
#[extendr]
fn centrality_info_helper(x: Robj) -> Robj {
    list!(
        n_nodes = x.len()
    ).into()
}

// Macro to generate exports
extendr_module! {
    mod cityseerr;
    fn init_network;
    fn compute_centrality_;
    fn network_info_helper;
    fn centrality_info_helper;
}
