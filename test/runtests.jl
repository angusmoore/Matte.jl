using Matte
using Test
import HTTP

@testset "Template" begin
    include("test-template.jl")
end

@testset "Generate JS" begin
    include("test-generate-js.jl")
end

@testset "Scaffolding helper functions" begin
    include("test-usethis.jl")
end

@testset "API" begin
    include("test-api.jl")
end

@testset "Layouts" begin
    include("test-layouts.jl")
end

@testset "Reflection" begin
    include("test-reflection.jl")
end
