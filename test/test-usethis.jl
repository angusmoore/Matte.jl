

@test_throws SystemError("mkdir", 2, "/foo/bar/app") matte_example("hello_world", "/foo/bar/app")
@test new_matte_app("test_new_app") == "test_new_app"
@test matte_example("hello_world", "hello_world") == "hello_world"

rm("test_new_app", recursive = true)
rm("hello_world", recursive = true)
