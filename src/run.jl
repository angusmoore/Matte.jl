
function run_app(app::Module; async = false)
    server = app.Server
    ui = app.ui
    Genie.Router.route("/index.html") do
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
