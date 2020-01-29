
"""
    matte_example(example, path, force = false)

Create a new Matte app, based on the example specified by `example`. See the manual for a
list of examples that you can use here.

`path` should be a folder that doesn't exist. If it doesnt, you can use `force = true` to
overwrite
"""
function matte_example(example, path, force = false)
    src = joinpath(dirname(pathof(Matte)), "..", "examples", "hello_world")
    cp(src, path)
end

"""
    new_matte_app(path, force = false)

Create a new skeleton Matte app in the folder `path`. The folder should be empty. Matte will
create the final folder if it doesn't exist, but will fail if the rest of the path doesn't
exist.

`path` should be a folder that doesn't exist. If it doesnt, you can use `force = true` to
overwrite
"""
function new_matte_app(path, force = false)
    matte_example("blank", path, force)
end
