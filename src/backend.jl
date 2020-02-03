render_response(response) = error("Don't know how to render result of type `$(typeof(response))`")

render_response(response::AbstractString) = response
render_response(response::Bool) = response
render_response(response::Number) = response
render_response(response::Nothing) = nothing

function render_response(response::Plots.Plot)
    io = IOBuffer()
    show(io, "image/png", response)

    png = read(seekstart(io), String)
    "data:image/png;base64," * base64encode(png)
end

function handle_request(id, input_dict, server_module)
    fn = get_handler(id, server_module)
    names = argument_names(fn)
    args = ()
    for argname in names
        try
            args = (args..., input_dict[string(argname)])
        catch e
            @error "Bad Server module configuration: Server-side function `$id` takes `$argname` as an input, but there is no UI element with that id"
            msg = sprint(showerror, e)
            if typeof(e) <: KeyError
                return Genie.Renderer.Json.json(Dict("matte_error_msg" => "Bad Server module configuration: Server-side function `$id` takes `$argname` as an input, but there is no UI element with that id"))
            else
                return Genie.Renderer.Json.json(Dict("matte_error_msg" => msg))
            end
        end
    end
    try
        response = fn(args...)
        response = render_response(response)
        Genie.Renderer.Json.json(Dict(id => response))
    catch e
        @error e
        msg = sprint(showerror, e)
        Genie.Renderer.Json.json(Dict("matte_error_msg" => msg))
    end
end
