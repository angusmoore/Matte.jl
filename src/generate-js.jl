
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
    dependencies
end

function dependency_tree(server_module)
    output_fns = module_functions(server_module)
    dependencies = Dict{String, Array{String, 1}}()
    for fn in output_fns
        dependencies[string(fn)] = string.(argument_names(get_handler(fn, server_module)))
    end
    dependencies
end

function jsonify_inputs(inputs)
    join(["$input : this.$(input)" for input in inputs], ", ")
end

function watch_function(input_id, reverse_dependencies, dependency_tree)
    out = "$input_id: function(value) {\n"
    for output in reverse_dependencies
        out *= "        this.fetch_result(\"$output\", {$(jsonify_inputs(dependency_tree[output]))})\n"
    end
    out *= "    }"

    out
end

function generate_output_js(server_module)
    dep_tree = dependency_tree(server_module)
    rev_dep = reverse_dependency_tree(server_module)

    watches = [watch_function(input_id, outputs_affected, dep_tree) for (input_id, outputs_affected) in rev_dep]
    mounts = ["this.fetch_result(\"$output_id\", {$(jsonify_inputs(dependencies))})" for (output_id, dependencies) in dep_tree]

    """
    watch: {
        $(join(watches, ",\n"))
    },
    mounted: function() {
      $(join(mounts, ",\n   "))
    }
    """
end
