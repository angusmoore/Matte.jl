

@test_throws Exception matte_example("hello_world", "/foo/bar/app")
new_matte_app("test_new_app", activate = false) == "test_new_app"
@test basename(pwd()) == "test_new_app"
@test isfile("app.jl")
cd("../")
rm("test_new_app", recursive = true)

matte_example("hello_world", "hello_world", activate = false) == "hello_world"
@test basename(pwd()) == "hello_world"
@test isfile("app.jl")
cd("../")
rm("hello_world", recursive = true)
