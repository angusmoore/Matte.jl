module TestSession

using Matte

function ui()
    sidebar_layout(
        main_panel(
        p(text_output("counter"))
    ),
    side_panel(
        h1("hi there"),
        button("button", "Push me")
    ))
end

function register_session_vars()
    Dict(
        :counter => 0
    )
end

module Server

import DataFrames

function counter(button, session)
    if button
        session.counter += 1
        session.counter
    else
        session.counter
    end
end

end

end

run_app(TestSession, async = true)

HTTP.WebSockets.open("ws://127.0.0.1:8001") do ws
    payload = Dict(
        :channel => "matte",
        :message => "api",
        :payload => Dict(
            :id => "counter",
            :session_id => "session1",
            :input => Dict(
                :button => true
            )
        )
    )
    expected = Dict(
        "id" => "counter",
        "value" => 1
    )
    write(ws, JSON.json(payload))
    @test JSON.parse(String(readavailable(ws))) == expected
end

HTTP.WebSockets.open("ws://127.0.0.1:8001") do ws
    payload = Dict(
        :channel => "matte",
        :message => "api",
        :payload => Dict(
            :id => "counter",
            :session_id => "session1",
            :input => Dict(
                :button => true
            )
        )
    )
    expected = Dict(
        "id" => "counter",
        "value" => 2
    )
    write(ws, JSON.json(payload))
    @test JSON.parse(String(readavailable(ws))) == expected
end

HTTP.WebSockets.open("ws://127.0.0.1:8001") do ws
    payload = Dict(
        :channel => "matte",
        :message => "api",
        :payload => Dict(
            :id => "counter",
            :session_id => "session2",
            :input => Dict(
                :button => true
            )
        )
    )
    expected = Dict(
        "id" => "counter",
        "value" => 1
    )
    write(ws, JSON.json(payload))
    @test JSON.parse(String(readavailable(ws))) == expected
end

stop_app()
