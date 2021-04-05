struct HalfEdge
    src::Int
    dst::Int
end

struct PlanarMultigraph
    v2he::Dict{Int, Int}    # v_id -> he_id
    half_edges::Dict{Int, HalfEdge} # he_id -> he
    f2he::Dict{Int, Int}    # f_id -> he_id
    next::Dict{Int, Int}    # he_id -> he_id
    twin::Dict{Int, Int}    # he_id -> he_id
    v_max::Int
    he_max::Int
    f_max::Int
end

α(g::PlanarMultigraph, he::Integer) = g.next[he]
next(g::PlanarMultigraph, he::Integer) = α(g, he)
function prev(g::PlanarMultigraph, he::Integer)
    current_he = next(g, he)
    next_he = next(g, current_he)
    while next_he != he
        current_he = next_he
        next_he = next(g, next_he)
    end
    return current_he
end

ϕ(g::PlanarMultigraph, he::Integer) = g.twin[he]
twin(g::PlanarMultigraph, he::Integer) = ϕ(g, he)

σ(g::PlanarMultigraph, he::Integer) = twin(g, prev(g, he))
σ_inv(g::PlanarMultigraph, he::Integer) = next(g, twin(g, he))

src(g::PlanarMultigraph, he::Integer) = g.half_edges[he].src
dst(g::PlanarMultigraph, he::Integer) = g.half_edges[he].dst

nv(g::PlanarMultigraph) = length(g.v2he)

out_half_edge(g::PlanarMultigraph, v::Integer) = g.v2he[v]
surrounding_half_edge(g::PlanarMultigraph, f::Integer) = g.f2he[f]

function trace_orbit(f::Function, a::T; rev::Bool = false) where T
    next = f(a)
    perm = T[a]
    while next != a
        if rev 
            pushfirst!(perm, next)
        else
            push!(perm, next)
        end
        next = f(next)
    end
    return perm
end

trace_face(g::PlanarMultigraph, f::Int) = trace_orbit(h -> g.next[h], surrounding_half_edge(g, f))
trace_vertex(g::PlanarMultigraph, v::Int) = trace_orbit(h -> σ_inv(g, h), out_half_edge(g, v); rev = true)