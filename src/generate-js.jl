
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

    filter(k -> first(k) != "stateful_vars", dependencies)
end

function dependency_tree(server_module)
    output_fns = module_functions(server_module)
    dependencies = Dict{String, Array{String, 1}}()
    for fn in output_fns
        args = argument_names(get_handler(fn, server_module))
        args = filter(x -> x != :stateful_vars, args)
        dependencies[string(fn)] = string.(args)
    end
    dependencies
end

function jsonify_inputs(inputs, is_value)
    out = Array{String, 1}()
    for input in inputs
        if !ismissing(is_value) && input == is_value
            push!(out, "$input: value")
        else
            push!(out, "$input : this.$(input)")
        end
    end
    join(out, ", ")
end

function fetch_update_methods(input_id, reverse_dependencies, dependency_tree)
    out = "
    fetch_update_$input_id: function(value) {\n"
    for output in reverse_dependencies
        out *= "        this.fetch_result(\"$output\", {$(jsonify_inputs(dependency_tree[output], input_id))})\n"
    end
    out *= "    }"

    out
end

function watch_function(input_id)
    "
    $input_id: function(value) {
        this.fetch_update_$input_id(value)
    }"
end

function fetch_method_js()
    """
    fetch_result: function(id, inputs) {
        axios.post("http://localhost:8000/matte/api", {
            id: id,
            input: inputs,
            session_id: this.session_id
        }).then(response => {
                if (response.data.hasOwnProperty("matte_error_msg") && !(response.data["matte_error_msg"] === null)) {
                    this.matte_error_msg = response.data["matte_error_msg"]
                    this.error_snackbar = true
                } else if (!(response.data[id] === null)) {
                    this[id] = response.data[id]
                }
            })
    }
    """
end

function generate_output_js(server_module)
    dep_tree = dependency_tree(server_module)
    rev_dep = reverse_dependency_tree(server_module)

    methods = [fetch_update_methods(input_id, outputs_affected, dep_tree) for (input_id, outputs_affected) in rev_dep]
    pushfirst!(methods, fetch_method_js())
    watches = [watch_function(input_id) for (input_id, outputs_affected) in rev_dep]
    mounts = ["this.fetch_result(\"$output_id\", {$(jsonify_inputs(dependencies, missing))})" for (output_id, dependencies) in dep_tree]

    """
    methods: {
        $(join(methods, ",\n"))
    },
    watch: {
        $(join(watches, ",\n"))
    },
    mounted: function() {
      $(join(mounts, ",\n   "))
    }
    """
end
