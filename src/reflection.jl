
function reverse_dependency_tree(server_module)
    output_fns = module_functions(server_module)
    # Map from input variables to the outputs they affect
    dependencies = Dict{String, Array{String, 1}}()
    for fn in output_fns
        inputs = argument_names(get_handler(fn, server_module))
        for input_var in string.(inputs)
            if haskey(dependencies, input_var)
                push!(dependencies[input_var], string(fn))
            else
                dependencies[input_var] = [string(fn)]
            end
        end
    end

    filter(k -> first(k) != "session", dependencies)
end

function dependency_tree(server_module)
    output_fns = module_functions(server_module)
    dependencies = Dict{String, Array{String, 1}}()
    for fn in output_fns
        args = argument_names(get_handler(fn, server_module))
        args = filter(x -> x != :session, args)
        dependencies[string(fn)] = string.(args)
    end
    dependencies
end

function is_user_defined(symbol)
    string(symbol)[1] != '#' && symbol != :eval && symbol != :include
end

function module_functions(server_module)
    output_fns = names(server_module, all = true)
    output_fns = filter(is_user_defined, output_fns)[2:end]
    filter(f -> length(methods(getfield(server_module, f))) > 0, output_fns) # Drop functions with no methods. This happens when using Revise if functions are deleted
end

# this works for closures
function argument_names(fn::Function)
    m = methods(fn)
    length(m) > 1 && error("You cannot define more than one method for each output (for output `$id`)")
    m, _ = iterate(m)
    Base.method_argnames(m)[2:end]
end

function get_handler(id, server_module)
    try
        getfield(server_module, Symbol(id))
    catch e
        if typeof(e) <: UndefVarError
            rethrow(ErrorException("You have not defined output for `$id`"))
        else
            rethrow(e)
        end
    end
end
