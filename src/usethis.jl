
"""
    matte_example(example, path)

Create a new Matte app, based on the example specified by `example`. See the manual for a
list of examples that you can use here.
"""
function matte_example(example, path)
    joinpath(dirname(pathof(Matte)), "..", "examples", "hello_world")
end

"""
    new_matte_app(path)

Create a new skeleton Matte app in the folder `path`. The folder should be empty. Matte will
create the final folder if it doesn't exist, but will fail if the rest of the path doesn't
exist.
"""
function new_matte_app(path)
    stop("Not implemented")
end
