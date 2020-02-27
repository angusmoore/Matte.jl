function genie_config()
    # Wrap everything for setting up Genie here for ease
    Genie.config.websockets_server = true
    Genie.config.server_host = "127.0.0.1"
    Genie.config.server_port = 8000
    Genie.config.log_level = Logging.Error
    Genie.config.log_to_file = false
    Genie.config.server_document_root = included_file_path(joinpath("files"))
    Genie.config.webchannels_default_route = "matte"
    Genie.config.webchannels_subscribe_channel = "subscribe"
    Genie.config.webchannels_unsubscribe_channel = "unsubscribe"
    Genie.config.webchannels_autosubscribe = true
end

function establish_subscription_channels()
    Genie.Router.channel("/$(Genie.config.webchannels_default_route)/subscribe") do
        Genie.WebChannels.subscribe(Genie.Requests.wsclient(), Genie.config.webchannels_default_route)
        "Subscription: OK"
    end

    Genie.Router.channel("/$(Genie.config.webchannels_default_route)/unsubscribe") do
        Genie.WebChannels.unsubscribe(Genie.Requests.wsclient(), Genie.config.webchannels_default_route)
        Genie.WebChannels.unsubscribe_disconnected_clients()
        "Unsubscription: OK"
    end
end

"""
    run_app(app; async = true)

The`app` module that defines your app must have a function called `ui` that defines
the UI. The functions in the module (which don't need to be exported) define
the logic for your app. The name of the function is the name of the outputs in
your UI, and the inputs to those functions correspond to the `id`s of inputs in
the UI.

See the `getting started` guide for help on how to define your app.
"""
function run_app(app::Module; async = true)
    sanitycheck(app)
    server = app.Server
    ui = app.ui
    sessions = create_sessions(app)

    genie_config()

    establish_subscription_channels()

    Genie.Router.route("/") do
        generate_template(app.title, ui, server)
    end

    Genie.Router.channel("/matte/api") do
        json_request = Genie.Router.@params(:payload)

        if haskey(json_request, "id")
            session = sessions[json_request["session_id"]]
            session.genie_wsclient = Genie.Requests.wsclient()
            handle_request(json_request["id"], json_request["input"], server, session)
        end
    end

    Genie.AppServer.startup(async = async)
end

"""
    stop_app()

Stops a running server that was started with `async=true`
"""
function stop_app()
    @async Base.throwto(Genie.AppServer.SERVERS.webserver, InterruptException())
    @async Base.throwto(Genie.AppServer.SERVERS.websockets, InterruptException())
end
