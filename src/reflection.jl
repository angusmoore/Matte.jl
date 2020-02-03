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
