using Multigraphs, LightGraphs, SparseArrays
using Test

@testset "Multigraphs.jl" begin
    # Write your own tests here.
end

@testset "multigraph.jl" begin
    m = spzeros(Int, 4, 4)
    m[1,2] = 2
    m[2,1] = 2
    m[2,3] = 2
    m[3,2] = 2
    m[3,4] += 1
    m[3,4] = 0
    m[4,3] += 1
    m[4,3] = 0
    g = Multigraph(m)

    i = 0
    for me in edges(g)
        for e in me
            i += 1
        end
        # println(me)
    end
    @test multype(g) == Int
    @test i == 4
    ne(g)
    @test nv(g) == 4 && ne(g, true) == 4 && ne(g) == 2

    add_vertices!(g,3)
    @test nv(g) == 7

    @test has_edge(g, 1, 2, 2)
    @test rem_vertices!(g, [1, 5, 4, 6, 8]) == [2, 3, 7]
    add_edge!(g, 2, 3, 2)
    rem_edge!(g, 2, 3, 1)

    @test has_edge(g, 2, 3)
    @test !has_edge(g, 2, 3, 2)
    @test !has_edge(g, 2, 2)
end

@testset "di_multigraph.jl" begin
    m = spzeros(Int, 4, 4)
    m[1,2] = 2
    m[2,1] = 1
    m[2,3] = 3
    # m[3,2] = 4
    m[3,4] += 1
    m[3,4] = 0
    m[4,3] += 1
    m[4,3] = 0
    g = DiMultigraph(m)

    i = 0
    for me in edges(g)
        for e in me
            i += 1
        end
        # println(me)
    end
    @test multype(g) == Int
    @test i == 6

    @test outneighbors(g, 2) == [1]
    @test inneighbors(g, 2) == [1, 3]

    @test nv(g) == 4 && ne(g, true) == 6 && ne(g) == 3

    add_vertices!(g,3)
    @test nv(g) == 7

    @test has_edge(g, 1, 2, 2)
    @test rem_vertices!(g, [1, 5, 4, 6, 8]) == [2, 3, 7]
    add_edge!(g, 2, 3, 2)
    rem_edge!(g, 2, 3, 1)

    @test has_edge(g, 2, 3)
    @test !has_edge(g, 2, 3, 2)
    @test !has_edge(g, 2, 2)
end