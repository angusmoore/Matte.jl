function included_file_path(path::String)
    normpath(joinpath(@__DIR__, "..", path))
end

function included_file(path::String)
  read(included_file_path(path), String)
end

function channels_file()
    included_file(joinpath("files", "bundle.min.js"))
end

function establish_static_routes()
    Genie.Router.route("/__/matte.js") do
        Genie.Renderer.Js.js(channels_file())
    end
end
