
function jsonify_inputs(inputs, is_value)
    out = Array{String, 1}()
    for input in inputs
        if !ismissing(is_value) && input == is_value
            push!(out, "'$input': value")
        else
            push!(out, "'$input' : this.$(input)")
        end
    end
    join(out, ", ")
end

vue_models(m::UIModel) = "$(m.id): $(m.default)"

function matte_builtin_models()
"""
            matte_notconnected_overlay: true,
            error_snackbar: false,
            matte_error_msg: "",
            session_id: uuidv1()"""
end

function vue_models(content::NTuple{N, UIModel}) where N
    join([matte_builtin_models(), [vue_models(x) for x in content]...], ",\n")
end

function fetch_update_method(input_id, reverse_dependencies, dependency_tree)
    out = "
    fetch_update_$input_id: function(value) {\n"
    for output in reverse_dependencies
        out *= "        Matte.request_update(\"$output\", {$(jsonify_inputs(dependency_tree[output], input_id))})\n"
    end
    out *= "    }"

    out
end

function watch_function(input_id, content)
    "
    $input_id: function(value) {
        $content
    }"
end

function watch_functions(rev_dep, watch_extras)
    # Define the set of watch functions for inputs that affected outputs
    watch_dict = Dict{String, String}(input_id => "this.fetch_update_$input_id(value)" for input_id in keys(rev_dep))

    # define manually added watch statements
    for extra in watch_extras
        if haskey(watch_dict, extra.id)
            watch_dict[extra.id] *= "\n" * extra.code
        else
            watch_dict[extra.id] = extra.code
        end
    end

    join([watch_function(id, code) for (id, code) in watch_dict], ",\n")
end

function on_connected(dep_tree)
    mount_calls = join(["Matte.request_update(\"$output_id\", {$(jsonify_inputs(dependencies, missing))})" for (output_id, dependencies) in dep_tree], ";\n")
    """
    on_connected: function() {
        this.matte_notconnected_overlay = false;
        $mount_calls
    }"""
end

function update_model()
    """
    update_model: function(response) {
        if (Object.prototype.hasOwnProperty.call(response, "matte_error_msg") && !(response["matte_error_msg"] === null)) {
            this.matte_error_msg = response["matte_error_msg"]
            this.error_snackbar = true
        } else if (!(response['value'] === null)) {
            this[response['id']] = response['value']
        }
    }"""
end

function vue_methods(models, rev_dep, dep_tree)
    for model in models
        if !haskey(rev_dep, model.id)
            rev_dep[model.id] = []
        end
    end
    methods = [fetch_update_method(input_id, outputs_affected, dep_tree) for (input_id, outputs_affected) in rev_dep]
    pushfirst!(methods, on_connected(dep_tree))
    pushfirst!(methods, update_model())
    join(methods, ",\n")
end

function vue_watch(rev_dep, watch)
    watch_functions(rev_dep, watch)
end

function vue_js(rev_dep, dep_tree, models, watch)
    """
    new Vue({
      el: '#app',
      vuetify: new Vuetify(),
      data: {
        $(vue_models(models))
      },
      methods: {
        $(vue_methods(models, rev_dep, dep_tree))
      },
      watch: {
        $(vue_watch(rev_dep, watch))
      },
      mounted: function() {
        Matte.load_channels(this);
      }
    })
    """
end
