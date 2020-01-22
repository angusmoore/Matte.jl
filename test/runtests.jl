using Matte
using Test


@testset "Template" begin
    include("test-template.jl")
end

@testset "Generate JS" begin
    include("test-generate-js.jl")
end
