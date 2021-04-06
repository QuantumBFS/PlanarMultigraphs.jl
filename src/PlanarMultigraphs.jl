module PlanarMultigraphs

export PlanarMultigraph, HalfEdge, 
    vertices, faces, half_edges,
    src, dst, half_edge, face,
    next, prev, twin, α, ϕ, σ, σ_inv,
    nv, ne, nf, nhe, is_boundary
    out_half_edge, surrounding_half_edge,
    trace_face, trace_vertex, neighbors,
    rem_vertex!, rem_edge!, rem_face!, merge_graph!,
    check_faces, check_vertices, check_combinatorial_maps

include("planar_multigraph.jl")

end
