"""
    ui_update(id, value, session)

Manually update a UI variable/element `id` to `value`. Use inside server-side functions for
_other_ outputs when you want calculations to have side effects in the UI.

`session` is the optional `session` argument to server-side functions that provides stateful
variables. See the [guide on server-side state](@ref server-side-state) for more information.
"""
function update_output(id, value, session)
    msg = JSON.json(Dict("id" => id, "value" => value))
    Genie.WebChannels.message(session.genie_wsclient, msg)
end
