using Matte
using Test
import JSON, HTTP

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

@testset "Examples" begin
    include("test-examples.jl")
end

@testset "Layouts" begin
    include("test-layouts.jl")
end

@testset "Reflection" begin
    include("test-reflection.jl")
end

@testset "Sanity check" begin
    include("test-sanitycheck.jl")
end

@testset "Sessions" begin
    include("test-session.jl")
end
