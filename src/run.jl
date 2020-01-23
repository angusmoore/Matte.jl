
"""
Run a Matte app

Inputs:
    app: The module that defines your app.
    async (optional, default false): Start the server in async mode (returns a
    repl after starting the server).

The module that defines your app must have a function called `ui` that defines
the UI. The functions in the module (which don't need to be exported) define
the logic for your app. The name of the function is the name of the outputs in
your UI, and the inputs to those functions correspond to the `id`s of inputs in
the UI.

See the `getting started` guide for help on how to define your app.
"""
function run_app(app::Module; async = false)
    server = app.Server
    ui = app.ui
    Genie.Router.route("/") do
        generate_template(app.title, ui, server)
    end

    Genie.Router.route("/matte/api", method = Genie.Router.POST) do
        json_request = Genie.Requests.jsonpayload()
        if haskey(json_request, "id")
            handle_request(json_request["id"], json_request["input"], server)
        end
    end

    Genie.AppServer.startup(async = async)
end
