
"""
    matte_example(example, path; force = false, activate = true)

Create a new Matte app, based on the example specified by `example`. See the manual for a
list of examples that you can use here.

`path` should be a folder that doesn't exist. If it doesnt, you can use `force = true` to
overwrite. `activate` controls whether the helper will activate the project for the newly
created app.
"""
function matte_example(example, path; force = false, activate = true)
    src = joinpath(dirname(pathof(Matte)), "..", "examples", example)
    cp(src, path)
    println("App created.\nChanging working directory to `$path`...")
    cd(path)
    if activate
        println("And activating the project...")
        Pkg.activate(".")
    end
    println("Done!")
end

"""
    new_matte_app(path; force = false, activate = true)

Create a new skeleton Matte app in the folder `path`. The folder should be empty. Matte will
create the final folder if it doesn't exist, but will fail if the rest of the path doesn't
exist.

`path` should be a folder that doesn't exist. If it doesnt, you can use `force = true` to
overwrite. `activate` controls whether the helper will activate the project for the newly
created app.
"""
function new_matte_app(path; force = false, activate = true)
    matte_example("blank", path, force = force, activate = activate)
end
