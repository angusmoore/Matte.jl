"""
    ui_update(id, value, session)

Manually update a UI variable/element `id` to `value`. Use inside server-side functions for
_other_ outputs when you want calculations to have side effects in the UI.

`session` is the optional `session` argument to server-side functions that provides stateful
variables. See the guides on [server-side state](@ref g06a-server-side-state) and
[side effects](@ref g06b-side-effects) for more information.
"""
function update_output(id, value, session)
    response = try
        response = render_response(value)
        JSON.json(Dict("id" => id, "value" => response))
    catch e
        msg = sprint(showerror, e)
        @error string(msg, "\nError occurred trying to `update_output` for `$id` to `$value`")

        JSON.json(Dict("matte_error_msg" => msg))
    end
    Genie.WebChannels.message(session.genie_wsclient, response)
end
