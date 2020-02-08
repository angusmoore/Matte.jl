function genie_config()
    # Wrap everything for setting up Genie here for ease
    Genie.config.websockets_server = true
    Genie.config.server_host = "127.0.0.1"
    Genie.config.server_port = 8000
    Genie.config.log_level = Logging.Error
    Genie.config.log_to_file = false
end


"""
    run_app(app; async = false)

The`app` module that defines your app must have a function called `ui` that defines
the UI. The functions in the module (which don't need to be exported) define
the logic for your app. The name of the function is the name of the outputs in
your UI, and the inputs to those functions correspond to the `id`s of inputs in
the UI.

See the `getting started` guide for help on how to define your app.
"""
function run_app(app::Module; async = false)
    server = app.Server
    ui = app.ui
    sessions = create_sessions(app)

    genie_config()

    Genie.Router.route("/") do
        generate_template(app.title, ui, server)
    end

    Genie.Router.channel("/matte/api") do
        json_request = JSON.parse(Genie.Router.@params(:payload))
        channel_id = Genie.Router.@params(:WS_CLIENT)
        println(channel_id)

        #=if haskey(json_request, "id")
            session = sessions[json_request["session_id"]]
            handle_request(json_request["id"], json_request["input"], server, session, channel_id)
        end=#
    end

    Genie.AppServer.startup(async = async)
end
