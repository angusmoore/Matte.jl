function included_file(path::String)
  read(normpath(joinpath(@__DIR__, "..", path)), String)
end

function channels_licence()
    """
    // This file is a modified version of the one from Genie.jl (https://github.com/GenieFramework/Genie.jl)
    // Copyright (c) 2016-2019 Adrian Salceanu and Genie.jl Contributors

    
    """
end

function channels_file()
    channels_licence() * Genie.Assets.js_settings() * included_file(joinpath("files", "channels.js"))
end

function establish_static_routes()
    Genie.Router.route("/__/matte.js") do
        Genie.Renderer.Js.js(channels_file())
    end
end
