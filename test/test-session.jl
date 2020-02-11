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

res = HTTP.request("POST", "http://localhost:8000/matte/api", [("Content-Type", "application/json")],
       """{"id": "counter", "session_id": "session1", "input" : {"button" : true}}""")
@test String(res.body) == "{\"counter\":1}"

res = HTTP.request("POST", "http://localhost:8000/matte/api", [("Content-Type", "application/json")],
      """{"id": "counter", "session_id": "session1", "input" : {"button" : true}}""")
@test String(res.body) == "{\"counter\":2}"

res = HTTP.request("POST", "http://localhost:8000/matte/api", [("Content-Type", "application/json")],
       """{"id": "counter", "session_id": "session2", "input" : {"button" : true}}""")
@test String(res.body) == "{\"counter\":1}"
