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

function jsonify_table_row(row)
    Dict(columnname => getproperty(row, columnname) for columnname in propertynames(row))
end

function render_response(response::Union{DataFrames.AbstractDataFrame, Tables.Table})
    data = [jsonify_table_row(row) for row in Tables.rows(response)]
    if length(data) == 0
         data = String[]
     end
    colnames = string.(Tables.schema(response).names)
    header = [Dict(:text => colname, :value => colname) for colname in colnames]

    [header, data...]
end

function handle_request(id, input_dict, server_module, stateful_vars)
    fn = get_handler(id, server_module)
    names = argument_names(fn)
    args = ()
    for argname in names
        if argname == :stateful_vars
            args = (args..., stateful_vars)
        else
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
