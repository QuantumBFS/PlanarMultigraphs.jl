using PlanarMultigraphs
using Test

function planar_rz()
    v2he = Dict{Int, Int}(
        1 => 1,
        2 => 9,
        3 => 4,
        4 => 6,
        5 => 14,
    )
    half_edges = Dict{Int, HalfEdge}(
        1 => HalfEdge(1, 2),
        2 => HalfEdge(2, 1),
        3 => HalfEdge(1, 3),
        4 => HalfEdge(3, 1),
        5 => HalfEdge(1, 4),
        6 => HalfEdge(4, 1),
        7 => HalfEdge(2, 3),
        8 => HalfEdge(3, 2),
        9 => HalfEdge(2, 5),
        10 => HalfEdge(5, 2),
        11 => HalfEdge(3, 5),
        12 => HalfEdge(5, 3),
        13 => HalfEdge(4, 5),
        14 => HalfEdge(5, 4),
    )
    
    f2he = Dict{Int, Int}(
        0 => 2,
        1 => 1,
        2 => 8,
        3 => 3,
    )
    he2f = Dict{Int, Int}(
        2 => 0,
        5 => 0,
        13 => 0,
        10 => 0,

        1 => 1,
        7 => 1,
        4 => 1,

        8 => 2,
        9 => 2,
        12 => 2,
        
        3 => 3,
        11 => 3,
        14 => 3,
        6 => 3,
    )    
    next = Dict{Int, Int}(
        2 => 5,
        5 => 13,
        13 => 10,
        10 => 2,

        1 => 7,
        7 => 4,
        4 => 1,

        8 => 9,
        9 => 12,
        12 => 8,

        3 => 11,
        11 => 14,
        14 => 6,
        6 => 3,
    )
    twin = Dict{Int, Int}(
        1 => 2,
        2 => 1,
        3 => 4,
        4 => 3,
        5 => 6,
        6 => 5,
        7 => 8,
        8 => 7,
        9 => 10,
        10 => 9,
        11 => 12,
        12 => 11,
        13 => 14,
        14 => 13,
    )
    rz = PlanarMultigraph(v2he, half_edges,
        f2he, he2f,
        next, twin,
        5, 14, 3
    )
    return rz
end

function planar_rx()
    v2he = Dict{Int, Int}(
        1 => 1,
        2 => 9,
        3 => 4,
        4 => 8,
        5 => 6,
        6 => 14,
    )
    half_edges = Dict{Int, HalfEdge}(
        1 => HalfEdge(1, 2),
        2 => HalfEdge(2, 1),
        3 => HalfEdge(1, 3),
        4 => HalfEdge(3, 1),
        5 => HalfEdge(1, 5),
        6 => HalfEdge(5, 1),
        7 => HalfEdge(3, 4),
        8 => HalfEdge(4, 3),
        9 => HalfEdge(2, 6),
        10 => HalfEdge(6, 2),
        11 => HalfEdge(4, 6),
        12 => HalfEdge(6, 4),
        13 => HalfEdge(5, 6),
        14 => HalfEdge(6, 5),
    )
    
    f2he = Dict{Int, Int}(
        0 => 2,
        1 => 1,
        2 => 3,
    )
    he2f = Dict{Int, Int}(
        2 => 0,
        5 => 0,
        13 => 0,
        10 => 0,

        1 => 1,
        9 => 1,
        12 => 1,
        8 => 1,
        4 => 1,

        3 => 2,
        7 => 2,
        11 => 2,
        14 => 2,
        6 => 2,
    )    
    next = Dict{Int, Int}(
        2 => 5,
        5 => 13,
        13 => 10,
        10 => 2,

        1 => 9,
        9 => 12,
        12 => 8,
        8 => 4,
        4 => 1,

        3 => 7,
        7 => 11,
        11 => 14,
        14 => 6,
        6 => 3,
    )
    twin = Dict{Int, Int}(
        1 => 2,
        2 => 1,
        3 => 4,
        4 => 3,
        5 => 6,
        6 => 5,
        7 => 8,
        8 => 7,
        9 => 10,
        10 => 9,
        11 => 12,
        12 => 11,
        13 => 14,
        14 => 13,
    )
    rx = PlanarMultigraph(v2he, half_edges,
        f2he, he2f,
        next, twin,
        6, 14, 2
    )
    return rx
end

@testset "Rx, Rz" begin
    rz = planar_rz()
    @test PlanarMultigraphs.check_faces(rz)
    @test PlanarMultigraphs.check_vertices(rz)
    @test PlanarMultigraphs.check_combinatorial_maps(rz)
    PlanarMultigraphs.rem_vertex!(rz, 3)
    @test PlanarMultigraphs.check_combinatorial_maps(rz)
    @test PlanarMultigraphs.nf(rz) == 2

    rx = planar_rx()
    @test PlanarMultigraphs.check_faces(rx)
    @test PlanarMultigraphs.check_vertices(rx)
    @test PlanarMultigraphs.check_combinatorial_maps(rx)
end