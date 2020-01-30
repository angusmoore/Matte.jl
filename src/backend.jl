
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
        Genie.Renderer.Json.json(Dict(id => response))
    catch e
        @error e
        msg = sprint(showerror, e)
        Genie.Renderer.Json.json(Dict("matte_error_msg" => msg))
    end
end
