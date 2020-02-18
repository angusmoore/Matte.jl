isdir("sandpit") && rm("sandpit", recursive = true)
mkdir("sandpit")
cd("sandpit")

@testset "australian_wages" begin
    matte_example("australian_wages", "australian_wages", activate = false)
    include(joinpath(pwd(), "app.jl"))
    run_app(AustralianWages, async = true)
    res = HTTP.request("GET", "http://localhost:8000/")
    @test res.status == 200
    stop_app()
    cd("../")
end

@testset "bad_long_running" begin
    matte_example("bad_long_running", "bad_long_running", activate = false)
    include(joinpath(pwd(), "app.jl"))
    run_app(BadLongRunningExample, async = true)
    res = HTTP.request("GET", "http://localhost:8000/")
    @test res.status == 200
    stop_app()
    cd("../")
end

@testset "better_long_running" begin
    matte_example("better_long_running", "better_long_running", activate = false)
    include(joinpath(pwd(), "app.jl"))
    run_app(BetterLongRunningExample, async = true)
    res = HTTP.request("GET", "http://localhost:8000/")
    @test res.status == 200
    stop_app()
    cd("../")
end

@testset "blank" begin
    new_matte_app("blank", activate = false)
    include(joinpath(pwd(), "app.jl"))
    run_app(NewMatteApp, async = true)
    res = HTTP.request("GET", "http://localhost:8000/")
    @test res.status == 200
    stop_app()
    cd("../")
end

@testset "broken_sideeffect" begin
    matte_example("broken_sideeffect", "broken_sideeffect", activate = false)
    include(joinpath(pwd(), "app.jl"))
    run_app(BrokenSideEffect, async = true)
    res = HTTP.request("GET", "http://localhost:8000/")
    @test res.status == 200
    stop_app()
    cd("../")
end

@testset "dynamic_select" begin
    matte_example("dynamic_select", "dynamic_select", activate = false)
    include(joinpath(pwd(), "app.jl"))
    run_app(DynamicSelectApp, async = true)
    res = HTTP.request("GET", "http://localhost:8000/")
    @test res.status == 200
    stop_app()
    cd("../")
end

@testset "hello_world" begin
    matte_example("hello_world", "hello_world", activate = false)
    include(joinpath(pwd(), "app.jl"))
    run_app(HelloWorldApp, async = true)
    res = HTTP.request("GET", "http://localhost:8000/")
    @test res.status == 200
    stop_app()
    cd("../")
end

@testset "iris" begin
    matte_example("iris", "iris", activate = false)
    include(joinpath(pwd(), "app.jl"))
    run_app(IrisApp, async = true)
    res = HTTP.request("GET", "http://localhost:8000/")
    @test res.status == 200
    stop_app()
    cd("../")
end

@testset "plot_example" begin
    matte_example("plot_example", "plot_example", activate = false)
    include(joinpath(pwd(), "app.jl"))
    run_app(PlotsExample, async = true)
    res = HTTP.request("GET", "http://localhost:8000/")
    @test res.status == 200
    stop_app()
    cd("../")
end

@testset "server_state" begin
    matte_example("server_state", "server_state", activate = false)
    include(joinpath(pwd(), "app.jl"))
    run_app(ServerStateExample, async = true)
    res = HTTP.request("GET", "http://localhost:8000/")
    @test res.status == 200
    stop_app()
    cd("../")
end

cd("../")
println(pwd())
rm("sandpit", recursive = true)
